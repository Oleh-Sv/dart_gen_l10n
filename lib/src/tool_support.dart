// Stand-ins for the flutter_tools internals the vendored gen-l10n files import
// (base/common.dart, base/file_system.dart, base/logger.dart, base/io.dart,
// convert.dart), reduced to what those files use.

import 'dart:io' as io;

export 'dart:convert';
export 'dart:io' show Platform, Process, ProcessException, ProcessResult;

export 'package:file/file.dart';

Never throwToolExit(String? message, {int? exitCode}) =>
    throw ToolExit(message, exitCode: exitCode);

final class ToolExit implements Exception {
  ToolExit(this.message, {this.exitCode});

  final String? message;
  final int? exitCode;

  @override
  String toString() => 'Error: $message';
}

class Logger {
  const Logger();

  void printStatus(String message) => io.stdout.writeln(message);

  void printWarning(String message) => io.stderr.writeln('Warning: $message');

  void printError(String message) => io.stderr.writeln(message);

  void printTrace(String message) {}
}
