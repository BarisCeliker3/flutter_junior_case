import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'Case App',
      'films': 'Films',
      'upload': 'Upload',
      'darkTheme': 'Dark Theme',
      'lightTheme': 'Light Theme',
      'profile': 'Profile',
      'likedMovies': 'Liked Movies',
      'noLikedMovies': 'No liked movies yet.',
    },
    'tr': {
      'appTitle': 'Vaka Uygulaması',
      'films': 'Filmler',
      'upload': 'Yükle',
      'darkTheme': 'Koyu Tema',
      'lightTheme': 'Açık Tema',
      'profile': 'Profil',
      'likedMovies': 'Beğenilen Filmler',
      'noLikedMovies': 'Henüz beğenilen film yok.',
    },
  };

  String get appTitle => _localizedValues[locale.languageCode]!['appTitle']!;
  String get films => _localizedValues[locale.languageCode]!['films']!;
  String get upload => _localizedValues[locale.languageCode]!['upload']!;
  String get darkTheme => _localizedValues[locale.languageCode]!['darkTheme']!;
  String get lightTheme => _localizedValues[locale.languageCode]!['lightTheme']!;
  String get profile => _localizedValues[locale.languageCode]!['profile']!;
  String get likedMovies => _localizedValues[locale.languageCode]!['likedMovies']!;
  String get noLikedMovies => _localizedValues[locale.languageCode]!['noLikedMovies']!;
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'tr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}