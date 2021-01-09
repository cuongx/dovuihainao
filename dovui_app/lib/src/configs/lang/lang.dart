export 'language_model.dart';
export 'app_language.dart';
export 'app_localization.dart';

// MaterialApp(
//     debugShowCheckedModeBanner: false,
//     ......
//     supportedLocales: AppLanguage.getSupportLanguage().map((e) => e.locale),
//     localizationsDelegates: [
//       AppLocalizations.delegate,
//       GlobalMaterialLocalizations.delegate,
//       GlobalCupertinoLocalizations.delegate,
//       GlobalWidgetsLocalizations.delegate,
//       DefaultCupertinoLocalizations.delegate
//     ],
//     localeResolutionCallback: (locale, supportedLocales) {
//       if (locale == null) {
//         debugPrint("*language locale is null!!!");
//         return supportedLocales.first;
//       }
//       for (var supportedLocale in supportedLocales) {
//         if (supportedLocale.languageCode == locale.languageCode &&
//             supportedLocale.countryCode == locale.countryCode) {
//           return supportedLocale;
//         }
//       }
//       return supportedLocales.first;
//     },
//     locale: Locale('vi', 'VN'),
//     ......
//     home: NavigationScreen(),
//     onGenerateRoute: Routers.generateRoute,
//   );
