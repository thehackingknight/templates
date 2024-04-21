import 'package:flutter/material.dart';
import 'package:tu/tu.dart';

import '../views/root/view.dart';

/* class AppRouter {
  static final GoRouter _router = GoRouter(navigatorKey: Get.key, routes: [
    ShellRoute(
        builder: (context, state, child) => RootView(child: child),
        routes: [
          ...RootView.routes.map((e) => GoRoute(
                path: e.to,
                name: e.to,
                builder: (context, state) => e.widget,
                pageBuilder: (context, state) => CustomTransitionPage(
                    child: e.widget,
                    transitionsBuilder: (_, a, __, c) =>
                        FadeTransition(opacity: a, child: c)),
              ))
        ])
  ]);
  GoRouter get router => _router;
}
 */