// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:js_interop';

@JS()
external String get url;

@JS('process.exit')
external void exit(int code);

@JS('console.error')
external void printErr(String message);
