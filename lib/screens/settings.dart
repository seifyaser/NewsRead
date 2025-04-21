import 'package:flutter/material.dart';
import 'package:project/cubits/cubit/changeLanguageCubit.dart';
import 'package:project/cubits/cubit/fetch_news_cubit.dart';
import 'package:project/generated/l10n.dart';
import 'package:project/themes/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // مهم

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedCountry = 'eg';
  String _selectedLanguage = 'en'; // اللغة الافتراضية

  final List<Map<String, String>> _countries = [
    {'code': 'us', 'name': 'United States'},
    {'code': 'eg', 'name': 'Egypt'},
  ];

  final List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'ar', 'name': 'العربية'},
  ];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedCountry = prefs.getString('country_code') ?? 'us';
      _selectedLanguage = prefs.getString('language_code') ?? 'en';
    });
  }

  Future<void> _saveCountry(String countryCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('country_code', countryCode);
    setState(() {
      _selectedCountry = countryCode;
    });
    context.read<FetchNewsCubitCubit>().fetchNews();
  }

  Future<void> _saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', languageCode);
    setState(() {
      _selectedLanguage = languageCode;
    });

    // هنا بنستخدم LocaleCubit عشان نغير اللغة في التطبيق
    context.read<LocaleCubit>().changeLocale(languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Text(S.of(context).Settings, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),

            // Light / Dark Mode
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).ChooseMode, style: Theme.of(context).textTheme.bodyMedium),
                  Switch(
                    value: themeManager.themeMode == ThemeMode.dark,
                    onChanged: (bool isDarkMode) {
                      themeManager.toggleTheme(isDarkMode);
                    },
                    activeColor: const Color.fromARGB(255, 8, 84, 217),
                    inactiveThumbColor: const Color.fromARGB(255, 8, 84, 217),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // اختيار البلد
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).ChooseCountry, style: Theme.of(context).textTheme.bodyMedium),
                  DropdownButton<String>(
                    value: _selectedCountry,
                    onChanged: (value) {
                      if (value != null) {
                        _saveCountry(value);
                      }
                    },
                    dropdownColor: Theme.of(context).colorScheme.secondary,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).textTheme.titleSmall?.color,
                        ),
                    iconEnabledColor: Colors.blue,
                    items: _countries.map((country) {
                      return DropdownMenuItem(
                        value: country['code'],
                        child: Text(country['name']!),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // اختيار اللغة
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).ChooseLanguage,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  DropdownButton<String>(
                    value: _selectedLanguage,
                    onChanged: (value) {
                      if (value != null) {
                        _saveLanguage(value);
                      }
                    },
                    dropdownColor: Theme.of(context).colorScheme.secondary,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).textTheme.titleSmall?.color,
                        ),
                    iconEnabledColor: Colors.blue,
                    items: _languages.map((lang) {
                      return DropdownMenuItem(
                        value: lang['code'],
                        child: Text(lang['name']!),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
