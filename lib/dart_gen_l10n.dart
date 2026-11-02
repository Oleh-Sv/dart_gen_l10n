/// Flutter's `gen-l10n` localizations generator emitting pure Dart.
library;

export 'src/gen_l10n.dart' show LocalizationsGenerator, generateLocalizations;
export 'src/gen_l10n_types.dart' show L10nException;
export 'src/localizations_utils.dart'
    show LocalizationOptions, parseLocalizationsOptionsFromYAML;
export 'src/tool_support.dart' show Logger, ToolExit;
