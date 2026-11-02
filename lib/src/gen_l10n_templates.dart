// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Vendored from Flutter 3.47.2 (d3b14c87690), packages/flutter_tools/lib/src/localizations/gen_l10n_templates.dart.
// Changed: pure Dart output (package:intl Locale, no delegate/of(context)/FlutterError).

const fileTemplate = '''
@(header)import 'package:intl/intl.dart' as intl;
import 'package:intl/locale.dart';

@(messageClassImports)

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of @(class)
/// returned by `lookup@(class)(locale)`.
///
/// This library is pure Dart. Flutter apps wrap `lookup@(class)` in a
/// `LocalizationsDelegate` and pass [@(class).supportedLocales] to the app's
/// `supportedLocales` list.
abstract class @(class) {
  @(class)(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  /// A list of this localizations class's supported locales.
  static final List<Locale> supportedLocales = <Locale>[
    @(supportedLocales)
  ];

@(methods)}

@(lookupFunction)
''';

const numberFormatPositionalTemplate = '''
    final intl.NumberFormat @(placeholder)NumberFormat = intl.NumberFormat.@(format)(localeName);
    final String @(placeholder)String = @(placeholder)NumberFormat.format(@(placeholder));
''';

const numberFormatNamedTemplate = '''
    final intl.NumberFormat @(placeholder)NumberFormat = intl.NumberFormat.@(format)(
      locale: localeName,
      @(parameters)
    );
    final String @(placeholder)String = @(placeholder)NumberFormat.format(@(placeholder));
''';

const dateFormatTemplate = '''
    final intl.DateFormat @(placeholder)DateFormat = intl.DateFormat.@(format)(localeName)@(addedFormats);
    final String @(placeholder)String = @(placeholder)DateFormat.format(@(placeholder));
''';

const dateFormatAddFormatTemplate = '''.add_@(format)()''';

const dateFormatCustomTemplate = '''
    final intl.DateFormat @(placeholder)DateFormat = intl.DateFormat(@(format), localeName);
    final String @(placeholder)String = @(placeholder)DateFormat.format(@(placeholder));
''';

const getterTemplate = '''
  @override
  String get @(name) => @(message);''';

const methodTemplate = '''
  @override
  String @(name)(@(parameters)) {
@(dateFormatting)
@(numberFormatting)
@(tempVars)    return @(message);
  }''';

const methodWithNamedParameterTemplate = '''
  @override
  String @(name)({@(parameters)}) {
@(dateFormatting)
@(numberFormatting)
@(tempVars)    return @(message);
  }''';

const pluralVariableTemplate = '''
    String @(varName) = intl.Intl.pluralLogic(
      @(count),
      locale: localeName,
@(pluralLogicArgs)
    );''';

const selectVariableTemplate = '''
    String @(varName) = intl.Intl.selectLogic(
      @(choice),
      {
@(selectCases)
      },
    );''';

const dateVariableTemplate = '''
    String @(varName) = intl.DateFormat.@(formatType)(localeName).format(@(argument));''';

const classFileTemplate = '''
@(header)// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import '@(fileName)';

// ignore_for_file: type=lint

/// The translations for @(language) (`@(localeName)`).
class @(class) extends @(baseClass) {
  @(class)([String locale = '@(localeName)']) : super(locale);

@(methods)
}
@(subclasses)''';

const subclassTemplate = '''

/// The translations for @(language) (`@(localeName)`).
class @(class) extends @(baseLanguageClassName) {
  @(class)(): super('@(localeName)');

@(methods)
}
''';

const baseClassGetterTemplate = '''
@(comment)
  ///
@(templateLocaleTranslationComment)
  String get @(name);
''';

const baseClassMethodTemplate = '''
@(comment)
  ///
@(templateLocaleTranslationComment)
  String @(name)(@(parameters));
''';

const baseClassMethodWithNamedParameterTemplate = '''
@(comment)
  ///
@(templateLocaleTranslationComment)
  String @(name)({@(parameters)});
''';

// LOOKUP TEMPLATES

const lookupFunctionTemplate = r'''
@(class) @(lookupName)(Locale locale) {
  @(lookupBody)

  throw UnsupportedError('@(class) does not support locale "$locale".');
}''';

const lookupFunctionDeferredLoadingTemplate = r'''
Future<@(class)> @(lookupName)(Locale locale) {
  @(lookupBody)

  throw UnsupportedError('@(class) does not support locale "$locale".');
}''';

const lookupBodyTemplate = '''
@(lookupAllCodesSpecified)
@(lookupScriptCodeSpecified)
@(lookupCountryCodeSpecified)
@(lookupLanguageCodeSpecified)''';

const switchClauseTemplate = '''case '@(case)': return @(localeClass)();''';

const switchClauseDeferredLoadingTemplate =
    '''case '@(case)': return @(library).loadLibrary().then((dynamic _) => @(library).@(localeClass)());''';

const nestedSwitchTemplate = '''
case '@(languageCode)': {
  switch (locale.@(code)) {
    @(switchClauses)
  }
  break;
}''';

const languageCodeSwitchTemplate = '''
  @(comment)
  switch (locale.languageCode) {
    @(switchClauses)
  }
''';

const allCodesLookupTemplate = '''
  // Lookup logic when language+script+country codes are specified.
  switch (locale.toLanguageTag().replaceAll('-', '_')) {
    @(allCodesSwitchClauses)
  }
''';
