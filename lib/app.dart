import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:shop_laptop_project/presentation/view/main/main_view.dart';

import 'common/res/colors.dart';
import 'common/res/themes.dart';
import 'config/di/app_module.dart';
import 'config/router/router.dart';
import 'generated/l10n.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1200))
        .then((value) => FlutterNativeSplash.remove());

    return GetMaterialApp(
      theme: Themes.commonThemeData(context),
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
      onGenerateRoute: appRouter.generator,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: const MainView(),
    );
  }
}

Future<void> configureApp() async {
  // Init di
  await configureDependencies();

  // Init routes
  await configureRouters();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: ColorsRes.transparent,
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
