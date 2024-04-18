import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tu/tu.dart';
import 'package:tu/views.dart';
import 'package:tuned/views/root/ctrl.dart';
import 'package:tuned/widgets/sidebar.dart';

import '../about.dart';
import '../home.dart';
import '../settings_view.dart';

class RootView extends StatelessWidget {
  final Widget child;
  const RootView({super.key, required this.child});

  static List<TuPage> routes = [
    TuPage('/', const HomeView(),
        icon: const Icon(
          CupertinoIcons.home,
        ),
        label: "Home"),
    TuPage(
      '/widgets',
      const WidgetsView(),
      label: 'Widgets',
      icon: const Icon(
        CupertinoIcons.app,
      ),
    ),
    TuPage('/about', const AboutView(),
        icon: const Icon(
          CupertinoIcons.info_circle,
        ),
        label: "About",
        isAction: true),
    TuPage('/settings', const SettingsView(),
        icon: const Icon(
          CupertinoIcons.settings,
        ),
        label: "Settings",
        isAction: true)
  ];
  static RootCtrl ctrl = Get.put(RootCtrl());
  @override
  Widget build(BuildContext context) {
    final routeName =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();
    var currIndex = routes.indexWhere((element) => element.to == routeName);
    currIndex = currIndex >= 0 ? currIndex : 0;
    return isMobile
        ? MobileRoot(
            routeName: routeName,
            currIndex: currIndex,
            child: child,
          )
        : DesktopRoot(routeName: routeName, currIndex: currIndex, child: child);
  }
}

class MobileRoot extends StatelessWidget {
  final String routeName;
  final int currIndex;
  final Widget child;
  const MobileRoot(
      {super.key,
      required this.routeName,
      required this.currIndex,
      required this.child});

  @override
  Widget build(BuildContext context) {
    final routes = RootView.routes;
    return Scaffold(
      drawer: const Drawer(),
      body: WillPopScope(
          onWillPop: () async {
            if (routeName != routes[0].to) {
              context.goNamed(routes[0].to);
              return false;
            }
            return true;
          },
          child: child),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            final route = routes[index];
            try {
              context.goNamed(route.to);
            } catch (e) {
              clog(e);
            }
          },
          currentIndex: currIndex,
          //selectedItemColor: Colors.white,
          items: routes
              .asMap()
              .entries
              .map(
                (e) => BottomNavigationBarItem(
                    icon: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            color: currIndex == e.key
                                ? colors.primaryFade
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(100)),
                        child: e.value.icon),
                    label: e.value.label,
                    backgroundColor: colors.surface),
              )
              .toList()),
    );
  }
}

class DesktopRoot extends StatelessWidget {
  final String routeName;
  final int currIndex;
  final Widget child;
  const DesktopRoot(
      {super.key,
      required this.routeName,
      required this.currIndex,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colors.surface,
        ),
        body: Row(
          children: [
            TuSidebar(routeName: routeName, currIndex: currIndex),
            Expanded(child: child)
          ],
        ));
  }
}
