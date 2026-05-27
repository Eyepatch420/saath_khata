import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class LocaleProvider extends ChangeNotifier {
  final StorageService _storage;
  late Locale _locale;

  LocaleProvider(this._storage) {
    final saved = _storage.getLocale();
    _locale = saved != null ? Locale(saved) : const Locale('en');
  }

  Locale get locale => _locale;

  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;
    _locale = locale;
    await _storage.setLocale(locale.languageCode);
    notifyListeners();
  }

  Future<void> clearLocale() async {
    _locale = const Locale('en');
    await _storage.setLocale('en');
    notifyListeners();
  }
}
