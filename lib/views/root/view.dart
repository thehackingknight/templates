import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tu/tu.dart';
import 'package:tu/views.dart';
import 'package:tuned/views/rf.dart';
import 'package:tuned/views/root/ctrl.dart';
import 'package:tuned/widgets/sidebar.dart';

import '../about.dart';
import '../home.dart';
import '../settings_view.dart';

class RootView extends StatelessWidget {
  const RootView({super.key});

  static List<TuPage> routes = [
    TuPage('/', const HomeView(), icon: CupertinoIcons.home, label: "Home"),
    TuPage(
      '/widgets',
      const WidgetsView(),
      label: 'Widgets',
      icon: Icons.apps_outlined,
    ),
    TuPage('/rf', const RFView(),
        icon: CupertinoIcons.lab_flask, label: "RF", isAction: true),
    TuPage('/about', const AboutView(),
        icon: CupertinoIcons.info_circle, label: "About", isAction: true),
    TuPage('/settings', const SettingsView(),
        icon: CupertinoIcons.settings, label: "Settings", isAction: true),
  ];
  static RootCtrl ctrl = Get.put(RootCtrl());
  @override
  Widget build(BuildContext context) {
    /* final routeName =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();
    var currIndex = routes.indexWhere((element) => element.to == routeName);
    currIndex = currIndex >= 0 ? currIndex : 0; */
    return isMobile
        ? const MobileRoot()
        : const DesktopRoot(
            /* routeName: routeName, currIndex: currIndex, child: child */);
  }
}

class MobileRoot extends StatelessWidget {
  const MobileRoot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final routes = RootView.routes;
    final ctrl = RootView.ctrl;

    return Scaffold(
        drawer: const Drawer(),
        body: WillPopScope(
            onWillPop: () async {
              if (ctrl.currentTab != 0) {
                ctrl.currentTab = 0;
                return false;
              }
              return true;
            },
            child:
                Obx(() => RootView.routes.elementAt(ctrl.currentTab).widget)),
        bottomNavigationBar: Obx(
          () => TuBottomNavbar(
            routes: routes,
            currentIndex: ctrl.currentTab,
            onTap: (index) {
              ctrl.currentTab = index;
            },
          ),
        ));
  }
}

class DesktopRoot extends StatelessWidget {
  const DesktopRoot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colors.surface,
        ),
        body: const Row(
          children: [
            /* TuSidebar(routeName: routeName, currIndex: currIndex),
            Expanded(child: child) */
          ],
        ));
  }
}
