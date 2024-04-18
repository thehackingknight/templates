import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tu/tu.dart';
import 'package:tuned/views/root/view.dart';

class TuSidebar extends StatelessWidget {
  final String routeName;
  final int currIndex;
  const TuSidebar({Key? key, required this.routeName, required this.currIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routes = RootView.routes;

    return Obx(
      () => Container(
          color: colors.bg1,
          width: appBarH,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: routes
                      .where((it) => !it.isAction)
                      .toList()
                      .asMap()
                      .entries
                      .map((e) {
                    return SizedBox(
                      height: appBarH,
                      child: IconButton(
                          splashRadius: splashRadius,
                          iconSize: iconSize,
                          color: currIndex == e.key ? colors.primary : null,
                          onPressed: () {
                            final route = routes[e.key];
                            try {
                              context.goNamed(route.to);
                            } catch (e) {
                              clog(e);
                            }
                          },
                          icon: e.value.icon),
                    );
                  }).toList()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: routes
                    .where((it) => it.isAction)
                    .toList()
                    .asMap()
                    .entries
                    .map((e) {
                  final index =
                      e.key + routes.where((it) => !it.isAction).length;
                  return SizedBox(
                    height: appBarH,
                    child: IconButton(
                        splashRadius: splashRadius,
                        color: currIndex == index ? colors.primary : null,
                        onPressed: () {
                          final route = routes[index];
                          try {
                            context.goNamed(route.to);
                          } catch (e) {
                            clog(e);
                          }
                        },
                        icon: e.value.icon),
                  );
                }).toList(),
              ),
            ],
          )),
    );
  }
}
