// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
@Tags(['node'])
@Skip('https://github.com/dart-lang/web/issues/372')
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:web_generator/src/cli.dart';

void main() {
  final testGenFolder = p.join('test', 'gen');
  final testGenDTSFiles = p.join(testGenFolder, 'input');

  group('Web Generator TS Bindings Integration Test', () {
    final inputDir = Directory(testGenDTSFiles);

    setUpAll(() async {
      // set up npm
      await runProc('npm', ['install'],
          workingDirectory: bindingsGeneratorPath, detached: true);

      // compile file
      await runProc(
          Platform.executable,
          [
            'compile',
            'js',
            '--enable-asserts',
            '--server-mode',
            'dart_main.dart',
            '-o',
            'dart_main.js',
          ],
          workingDirectory: bindingsGeneratorPath,
          detached: true);
    });

    for (final inputFile in inputDir.listSync().whereType<File>()) {
      final inputFileName = p.basenameWithoutExtension(inputFile.path);

      final outputActualPath =
          p.join('test', 'gen', 'expected', '${inputFileName}_actual.dart');
      final outputExpectedPath =
          p.join('test', 'gen', 'expected', '${inputFileName}_expected.dart');

      test(inputFileName, () async {
        final inputFilePath =
            p.relative(inputFile.path, from: bindingsGeneratorPath);
        final outFilePath =
            p.relative(outputActualPath, from: bindingsGeneratorPath);
        // run the entrypoint
        await runProc(
            'node',
            [
              'main.mjs',
              '--input=$inputFilePath',
              '--output=$outFilePath',
              '--declaration'
            ],
            workingDirectory: bindingsGeneratorPath,
            detached: true);

        // read files
        final expectedOutput = await File(outputExpectedPath).readAsString();
        final actualOutput = await File(outputActualPath).readAsString();

        expect(actualOutput, expectedOutput);
      });
    }
  });
}
