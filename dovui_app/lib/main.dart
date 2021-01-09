import 'package:dovui_app/src/presentation/homepage/home_screen.dart';
import 'package:dovui_app/src/presentation/moreapp/more_app.dart';
import 'package:dovui_app/src/resource/services/sound_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'src/configs/configs.dart';
import 'src/resource/resource.dart';
import 'src/presentation/presentation.dart';

void main() {

  SoundService soundService = new SoundService();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  WidgetsBinding.instance.addObserver(soundService);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: Colors.pink, // status bar color
  ));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {


    runApp(MultiProvider(
        child: MyApp(), providers: <SingleChildWidget>[
      Provider.value(
        value: OtherRepository(),
      ),
      // Provider<MusicViewModel>(create: (_) => MusicViewModel()),
      Provider.value(value: soundService..init())
    ]));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      title: AppDefaults.APP_DOVUI,
      theme: normalTheme(context),
      supportedLocales: AppLanguage.getSupportLanguage().map((e) => e.locale),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) {
          debugPrint("*language locale is null!!!");
          return supportedLocales.first;
        }
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      locale: Locale('vi', 'VN'),
      home: SplashScreen(),
      onGenerateRoute: Routers.generateRoute,
      initialRoute: Routers.splash,
      routes: {
        Routers.splash: (context) => SplashScreen(),
        Routers.homePage: (context) => HomeScreen(),
        Routers.moreapp: (context) => MoreApp()
      },
    );
  }
}
