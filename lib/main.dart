import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project/components/bottomNavigationBar.dart';
import 'package:project/cubits/cubit/changeLanguageCubit.dart';
import 'package:project/cubits/cubit/fetch_news_cubit.dart';
import 'package:project/firebase_options.dart';
import 'package:project/generated/l10n.dart';
import 'package:project/services/api_service.dart';
import 'package:project/themes/theme_constants.dart';
import 'package:project/themes/theme_manager.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseService().initNotification();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeManager()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => FetchNewsCubitCubit()..fetchNews()),
          BlocProvider(create: (context) => LocaleCubit()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp(
          locale: locale, // اللغة هنا ديناميكية بناءً على الحالة
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeManager.themeMode,
          home: const CustomNavigationBar(), // أول صفحة
        );
      },
    );
  }
}
