// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:js_interop';

import 'package:path/path.dart' as p;

import 'js/webidl2.dart' as webidl2;
import 'js/webidl_api.dart' as webidl;
import 'js/webref_css_api.dart';
import 'js/webref_elements_api.dart';
import 'js/webref_idl_api.dart';
import 'translator.dart';
import 'util.dart';

/// Generate CSS property names for setting / getting CSS properties in JS.
Future<List<String>> _generateCSSStyleDeclarations() async {
  final cssStyleDeclarations = <String>{};
  final array = objectEntries(await css.listAll().toDart);
  for (var i = 0; i < array.length; i++) {
    final entry = array[i] as JSArray<CSSEntries>;
    final data = entry[1];
    final properties = data.properties;
    if (properties != null) {
      for (var j = 0; j < properties.length; j++) {
        final property = properties[j];
        // There are three cases for [styleDeclaration]:
        //   1) Length == 1, a single word CSS property.
        //   2) Length == 2, a kebab case property + a camel case property.
        //   3) Length == 3, webkit CSS properties.
        final styleDeclaration = property.styleDeclaration;
        if (styleDeclaration != null) {
          final length = styleDeclaration.length;
          if (length < 0 || length > 3) {
            throw Exception('Unexpected style declaration $styleDeclaration');
          }
          // For now we ignore browser specific properties.
          if (length == 3) continue;
          final style = styleDeclaration[length - 1].toDart;
          if (style.contains('-')) {
            throw Exception('Unexpected style declaration $styleDeclaration');
          }
          cssStyleDeclarations.add(style);
        }
      }
    }
  }
  return cssStyleDeclarations.toList()..sort();
}

/// Parse the elements spec and construct a map of element interfaces to the
/// tag names that correspond to the interface.
Future<Map<String, Set<String>>> _generateElementTagMap() async {
  final elementMap = <String, Set<String>>{};
  final array = objectEntries(await elements.listAll().toDart);
  for (var i = 0; i < array.length; i++) {
    final entry = array[i] as JSArray;
    final data = entry[1] as ElementsEntries;
    final elements = data.elements;
    if (elements != null) {
      for (var j = 0; j < elements.length; j++) {
        final element = elements[j];
        final tag = element.name;
        final interface = element.interface;
        if (tag == null || interface == null) continue;
        elementMap.putIfAbsent(interface, () => {}).add(tag);
      }
    }
  }
  return elementMap;
}

Future<(TranslationResult, Map<String, String>)> generateBindings(
    String packageRoot, String librarySubDir,
    {required bool generateAll}) async {
  final cssStyleDeclarations = await _generateCSSStyleDeclarations();
  final elementHTMLMap = await _generateElementTagMap();
  final translator = Translator(
      librarySubDir, cssStyleDeclarations, elementHTMLMap,
      generateAll: generateAll, packageRoot: packageRoot);
  final array = objectEntries(await idl.parseAll().toDart);
  for (var i = 0; i < array.length; i++) {
    final entry = array[i] as JSArray<JSAny?>;
    final shortname = (entry[0] as JSString).toDart;
    final ast = entry[1] as JSArray<webidl.Node>;
    translator.collect(shortname, ast);
  }
  translator.addInterfacesAndNamespaces();
  final result = translator.translate();
  final renamedTypes = translator.renamedClasses;

  return (result, renamedTypes);
}

Future<TranslationResult> generateBindingsForFiles(
    Map<String, String> fileContents, String output) async {
  // generate CSS style declarations and element tag map incase they are
  // needed for the input files.
  final cssStyleDeclarations = await _generateCSSStyleDeclarations();
  final elementHTMLMap = await _generateElementTagMap();
  final translator = Translator(output, cssStyleDeclarations, elementHTMLMap,
      generateAll: true, generateForWeb: false);

  for (final file in fileContents.entries) {
    final ast = webidl2.parse(file.value);
    translator.collect(p.basenameWithoutExtension(file.key), ast);
  }

  translator.addInterfacesAndNamespaces();
  return translator.translate();
}
