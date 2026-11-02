# dart_gen_l10n

Flutter's [`gen-l10n`](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization)
localizations generator for **pure Dart** packages.

It is the `gen-l10n` source from Flutter 3.47.2 (`flutter_tools`), with two
changes: it runs without the Flutter SDK, and the code it generates has no
Flutter dependency. ARB parsing, placeholder validation, plurals, selects and
number/date formats are Flutter's code, so messages come out exactly as
`flutter gen-l10n` writes them.

## What differs from `flutter gen-l10n`

The generated output library:

- imports only `package:intl` and uses `Locale` from `package:intl/locale.dart`;
- has no `of(BuildContext)`, `LocalizationsDelegate` or `localizationsDelegates`;
- exposes `<Class>.supportedLocales` (intl `Locale`s) and the top-level
  `lookup<Class>(Locale locale)`, which throws `UnsupportedError` for unsupported
  locales.

The per-locale files (`<file>_<locale>.dart`) are unchanged.

The tool:

- doesn't need `flutter: generate: true` in `pubspec.yaml`;
- reads options only from `l10n.yaml`; there are no command-line options.

`nullable-getter` has no effect, because no `of(context)` is generated.

## Usage

Add `intl` to the package's dependencies and an `l10n.yaml` with the usual
[gen-l10n options](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization#configuring-the-l10n-yaml-file),
then run from the package directory:

```sh
dart pub global activate dart_gen_l10n
dart pub global run dart_gen_l10n
```

or add `dart_gen_l10n` to `dev_dependencies` and run `dart run dart_gen_l10n`.

### Using the output in Flutter

Wrap the lookup in a delegate in a Flutter package:

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/locale.dart' as intl;
import 'package:my_strings/my_strings.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  static final supportedLocales = [
    for (final locale in AppLocalizations.supportedLocales)
      Locale.fromSubtags(
        languageCode: locale.languageCode,
        scriptCode: locale.scriptCode,
        countryCode: locale.countryCode,
      ),
  ];

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture(lookupAppLocalizations(intl.Locale.fromSubtags(
        languageCode: locale.languageCode,
        scriptCode: locale.scriptCode,
        countryCode: locale.countryCode,
      )));

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales
      .any((supported) => supported.languageCode == locale.languageCode);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
```

## License

BSD 3-Clause. The generator is derived from Flutter's `flutter_tools` (Copyright
2014 The Flutter Authors), see [LICENSE](LICENSE). Each file in `lib/src/`
notes what changed from the Flutter original.
