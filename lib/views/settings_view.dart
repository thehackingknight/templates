import 'package:flutter/material.dart';
import 'package:tu/functions.dart';
import 'package:tu/tu.dart';

import '../main.dart';
import '../models/settings.dart';
import '../utils/constants.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  Settings? _appSettings;

  _init() async {
    var res = await isar.settings.get(1);
    if (context.mounted) {
      setState(() {
        _appSettings = res;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    final appCtrl = MainApp.appCtrl;
    return Scaffold(
      appBar: tuAppbar(title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            mY(topMargin),
            InfoItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("App version"),
                  Obx(() => Text(MainApp.appCtrl.version)),
                ],
              ),
            ),
            InfoItem(
              child: tuRow(children: [
                const Text("Auto check updates"),
                Obx(
                  () => Switch(
                      value: appCtrl.autoCheckUpdates,
                      onChanged: (val) async {
                        await isar.writeTxn(() async {
                          isar.settings
                              .put(_appSettings!..autoCheckUpdates = val);
                        });
                        appCtrl.autoCheckUpdates = val;
                      }),
                )
              ]),
            ),
            InfoItem(
              child: tuRow(children: [
                const Text("Dark mode"),
                Obx(
                  () => Switch(
                      value: Tu.appCtrl.darkMode,
                      onChanged: (val) async {
                        await isar.writeTxn(() async {
                          isar.settings.put(_appSettings!..darkMode = val);
                        });
                        Tu.appCtrl.darkMode = val;
                      }),
                )
              ]),
            ),
            InfoItem(
              child: const Text("Check updates"),
              onTap: () async {
                await checkUpdates(
                    appVersion: appCtrl.version,
                    appId: 'com.tb.tulyrics',
                    appName: appCtrl.title);
              },
            ),
          ],
        ),
      ),
    );
  }
}
