// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:js_interop';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

import '../ast/base.dart';
import '../config.dart';
import '../js/typescript.dart' as ts;
import '../js/typescript.types.dart';
import 'namer.dart';
import 'parser.dart';
import 'transform/transformer.dart';

void _setGlobalOptions(Config config) {
  GlobalOptions.variadicArgsCount = config.functions?.varArgs ?? 4;
}

class TransformResult {
  ProgramDeclarationMap programMap;

  TransformResult._(this.programMap);

  // TODO(https://github.com/dart-lang/web/issues/388): Handle union of overloads
  //  (namespaces + functions, multiple interfaces, etc)
  Map<String, String> generate(Config config) {
    final emitter = DartEmitter.scoped(useNullSafetySyntax: true);
    final formatter = DartFormatter(
        languageVersion: DartFormatter.latestShortStyleLanguageVersion);

    _setGlobalOptions(config);

    return programMap.map((file, declMap) {
      final specs = declMap.decls.values.map((d) {
        return switch (d) {
          final Declaration n => n.emit(),
          final Type _ => null,
        };
      }).whereType<Spec>();
      final lib = Library((l) {
        if (config.preamble case final preamble?) {
          l.comments.addAll(const LineSplitter().convert(preamble).map((l) {
            if (l.startsWith('//')) {
              return l.replaceFirst(RegExp(r'^\/\/\s*'), '');
            }
            return l;
          }));
        }
        l
          ..ignoreForFile.addAll(
              ['constant_identifier_names', 'non_constant_identifier_names'])
          ..body.addAll(specs);
      });
      return MapEntry(
          file,
          formatter.format('${lib.accept(emitter)}'
              .replaceAll('static external', 'external static')));
    });
  }
}

/// A map of declarations, where the key is the declaration's stringified [ID].
extension type NodeMap._(Map<String, Node> decls) implements Map<String, Node> {
  NodeMap([Map<String, Node>? decls]) : decls = decls ?? <String, Node>{};

  List<Node> findByName(String name) {
    return decls.entries
        .where((e) => UniqueNamer.parse(e.key).name == name)
        .map((e) => e.value)
        .toList();
  }

  void add(Node decl) => decls[decl.id.toString()] = decl;
}

typedef ProgramDeclarationMap = Map<String, NodeMap>;

TransformResult transform(ParserResult parsedDeclarations,
    {required Config config}) {
  final programDeclarationMap = <String, NodeMap>{};

  for (final file in parsedDeclarations.files) {
    if (programDeclarationMap.containsKey(file)) continue;

    transformFile(parsedDeclarations.program, file, programDeclarationMap,
        config: config);
  }

  return TransformResult._(programDeclarationMap);
}

void transformFile(ts.TSProgram program, String file,
    Map<String, NodeMap> programDeclarationMap,
    {required Config config}) {
  final src = program.getSourceFile(file);

  if (src == null) return;

  final typeChecker = program.getTypeChecker();

  final transformer = Transformer(programDeclarationMap, typeChecker,
      filterDeclSet: config.includedDeclarations);

  ts.forEachChild(
      src,
      ((TSNode node) {
        // ignore end of file
        if (node.kind == TSSyntaxKind.EndOfFileToken) return;

        transformer.transform(node);
      }).toJS as ts.TSNodeCallback);

  // filter
  final resolvedMap = transformer.filterAndReturn();

  programDeclarationMap.addAll({file: resolvedMap});
}
