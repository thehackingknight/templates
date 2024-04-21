import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tu/functions.dart';
import 'package:tu/widgets/updates_view.dart';
import 'package:tuned/controllers/app_ctrl.dart';
import 'package:tu/tu.dart';
import 'package:tuned/utils/config.dart';
import 'package:tuned/views/root/view.dart';
import 'package:visibility_aware_state/visibility_aware_state.dart';
import 'controllers/form_ctrl.dart';
import 'models/settings.dart';
import 'routers/app.dart';
import 'utils/constants.dart';

void main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isIOS) {
    FlutterNativeSplash.preserve(widgetsBinding: binding);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  //setupWindowManager();
  await configIsar();

  ///FLUTTER DOWNLOADER
  if (Platform.isAndroid || Platform.isIOS) {
    await FlutterDownloader.initialize(
        debug:
            dev, // optional: set to false to disable printing logs to console (default: true)
        ignoreSsl:
            true // option: set to false to disable working with http links (default: false)
        );
  }
  //TuAppLovin.config();
  clog("RUNNING APP...");
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  static AppCtrl appCtrl = Get.put(AppCtrl());
  static BarCtrl barCtrl = Get.put(BarCtrl());
  static FormCtrl formCtrl = Get.put(FormCtrl());
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends VisibilityAwareState<MainApp> {
  //final _router = AppRouter().router;
  final _appCtrl = MainApp.appCtrl;

  _configApp() async {
    /* Get/Create settings */
    var settings = await isar.settings.get(1);
    if (settings.isNullTu) {
      settings = Settings();
      await isar.writeTxn(() async {
        isar.settings.put(settings!);
      });
    }
    _appCtrl.autoCheckUpdates = settings!.autoCheckUpdates;

    Tu.appCtrl.darkMode = settings.darkMode;
    _appCtrl.ready = true;
    clog('IS READY');
    _checkUpdates(settings);
  }

  _checkUpdates(Settings settings) async {
    if (settings.autoCheckUpdates) {
      clog("Auto checking...");
      final res = await checkUpdates(
          appId: _appCtrl.appId,
          appName: _appCtrl.title,
          showLoader: false,
          appVersion: await getAppVersion());
      if (res != null) {
        Get.bottomSheet(UpdatesView3(
          update: res,
          appName: _appCtrl.title,
        ));
      }
    }
  }

  void _init() {
    Get.put(AppCtrl());
    Get.put(BarCtrl());
    _configApp();
  }

  @override
  void initState() {
    super.initState();
    clog("MAIN APP INIT");
    _init();
    //_router.routerDelegate.addListener(_onRouter);
  }

  void _onVisibilityChanged(WidgetVisibility visibility) {
    clog("VISIBILITY CHANGED: ${visibility.toString()}");
    MainApp.appCtrl.isVisible = visibility == WidgetVisibility.VISIBLE;
  }

  @override
  void onVisibilityChanged(WidgetVisibility visibility) {
    _onVisibilityChanged(visibility);
    super.onVisibilityChanged(visibility);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !_appCtrl.ready
          ? const TuSplash()
          : MaterialApp(
              home: const RootView(),
              //routerConfig: _router,
              theme: TuTheme(
                      context: context,
                      colors: TuColors(),
                      dark: Tu.appCtrl.darkMode)
                  .theme(),
              debugShowCheckedModeBanner: false,
              //home: const Root(),
            ),
    );
  }
}

class TuSplash extends StatelessWidget {
  const TuSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme:
            TuTheme(context: context, colors: TuColors(), dark: true).theme(),
        home: Scaffold(
          backgroundColor: colors.primaryContainer,
          body: Center(
            child: Text(
              MainApp.appCtrl.title,
              style: styles.h1(color: Colors.white),
            ),
          ),
        ));
  }
}
