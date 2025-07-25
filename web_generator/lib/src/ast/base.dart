// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';

import '../interop_gen/namer.dart';
import 'types.dart';

class GlobalOptions {
  static int variadicArgsCount = 4;
  static bool shouldEmitJsTypes = false;
  static bool redeclareOverrides = true;
}

class Options {}

class DeclarationOptions extends Options {
  bool override;

  DeclarationOptions({this.override = false});

  TypeOptions toTypeOptions({bool nullable = false}) =>
      TypeOptions(nullable: nullable);
}

class TypeOptions extends Options {
  bool nullable;

  TypeOptions({this.nullable = false});
}

class ASTOptions {
  bool parameter;
  bool emitJSTypes;
  int variadicArgsCount;

  ASTOptions(
      {this.parameter = false,
      this.variadicArgsCount = 4,
      this.emitJSTypes = false});
}

sealed class Node {
  abstract final String? name;
  abstract final ID id;
  String? get dartName;

  Spec emit([Options? options]);

  Node();
}

abstract class Declaration extends Node {
  @override
  abstract final String name;

  @override
  Spec emit([covariant DeclarationOptions? options]);
}

abstract class NamedDeclaration extends Declaration {
  ReferredType asReferredType([List<Type>? typeArgs]) =>
      ReferredType(name: name, declaration: this, typeParams: typeArgs ?? []);
}

abstract interface class ExportableDeclaration extends Declaration {
  /// Whether this declaration is exported.
  bool get exported;
}

abstract class Type extends Node {
  @override
  String? dartName;

  @override
  Reference emit([covariant TypeOptions? options]);
}

abstract class FieldDeclaration extends NamedDeclaration {
  abstract final Type type;
}

abstract class CallableDeclaration extends NamedDeclaration {
  abstract final List<ParameterDeclaration> parameters;

  abstract final List<GenericType> typeParameters;

  abstract final Type returnType;
}

enum DeclScope { private, protected, public }

class ParameterDeclaration {
  final String name;

  final bool optional;

  final Type type;

  final bool variadic;

  ParameterDeclaration(
      {required this.name,
      this.optional = false,
      required this.type,
      this.variadic = false});

  Parameter emit([DeclarationOptions? options]) {
    return Parameter((p) => p
      ..name = name
      ..type = type.emit(TypeOptions(nullable: optional)));
  }
}
