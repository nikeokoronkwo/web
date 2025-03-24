

import 'dart:io';

import 'package:args/args.dart';
import 'package:io/ansi.dart' as ansi;
import 'package:io/io.dart';

final _parser = ArgParser()
..addFlag('help', abbr: 'h', help: 'Show Help Information', negatable: false)
;

final _usage = '''
Usage:
${_parser.usage}''';

void main(List<String> args) {
  final ArgResults argResult;

  try {
    argResult = _parser.parse(args);
  } on FormatException catch (e) {
    print('''
${ansi.lightRed.wrap(e.message)}

$_usage''');
    exitCode = ExitCode.usage.code;
    return;
  }

  if (argResult.wasParsed('help')) {
    print(_usage);
    return;
  }

  if (argResult.rest.isEmpty) {
    print('''Need at least one argument:

$_usage''');
    exitCode = ExitCode.usage.code;
    return;
  }

  
}