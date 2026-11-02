import 'dart:io';

import 'package:dart_gen_l10n/dart_gen_l10n.dart';
import 'package:file/local.dart';

/// Generates the localizations classes of the package in the current directory
/// from its ARB files, with the options of its `l10n.yaml`, like
/// `flutter gen-l10n` but without Flutter.
Future<void> main() async {
  const fileSystem = LocalFileSystem();
  const logger = Logger();
  try {
    final options = parseLocalizationsOptionsFromYAML(
      file: fileSystem.file('l10n.yaml'),
      logger: logger,
      fileSystem: fileSystem,
      defaultArbDir: fileSystem.path.join('lib', 'l10n'),
    );
    await generateLocalizations(
      projectDir: fileSystem.currentDirectory,
      options: options,
      logger: logger,
      fileSystem: fileSystem,
    );
  } on ToolExit catch (e) {
    stderr.writeln(e);
    exitCode = e.exitCode ?? 1;
  }
}
