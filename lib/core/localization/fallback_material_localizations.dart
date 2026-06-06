import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Flutter's bundled `GlobalMaterialLocalizations` / `GlobalCupertinoLocalizations`
/// don't ship strings for Bhojpuri (`bho`) or Maithili (`mai`). Our own app strings
/// DO exist for those locales, but the framework widgets (date pickers, default
/// dialog buttons, tooltips) would otherwise have no localizations and throw.
///
/// These delegates claim `bho`/`mai` and load the Hindi framework localizations
/// for them — Hindi is the closest Devanagari language and the documented fallback.
/// They're placed BEFORE the Global delegates so they win for `bho`/`mai`, while
/// every other locale still flows through the Global delegates unchanged.
const Locale _fallback = Locale('hi');

bool _isCustom(Locale l) => l.languageCode == 'bho' || l.languageCode == 'mai';

class _MaterialFallbackDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _MaterialFallbackDelegate();
  @override
  bool isSupported(Locale locale) => _isCustom(locale);
  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      GlobalMaterialLocalizations.delegate.load(_fallback);
  @override
  bool shouldReload(_MaterialFallbackDelegate old) => false;
}

class _CupertinoFallbackDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _CupertinoFallbackDelegate();
  @override
  bool isSupported(Locale locale) => _isCustom(locale);
  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      GlobalCupertinoLocalizations.delegate.load(_fallback);
  @override
  bool shouldReload(_CupertinoFallbackDelegate old) => false;
}

class _WidgetsFallbackDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const _WidgetsFallbackDelegate();
  @override
  bool isSupported(Locale locale) => _isCustom(locale);
  @override
  Future<WidgetsLocalizations> load(Locale locale) =>
      GlobalWidgetsLocalizations.delegate.load(_fallback);
  @override
  bool shouldReload(_WidgetsFallbackDelegate old) => false;
}

/// Add these before the Global* delegates in MaterialApp.localizationsDelegates.
const List<LocalizationsDelegate<dynamic>> fallbackLocalizationsDelegates = [
  _MaterialFallbackDelegate(),
  _CupertinoFallbackDelegate(),
  _WidgetsFallbackDelegate(),
];
