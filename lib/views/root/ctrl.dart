import 'package:tu/tu.dart';

class RootCtrl extends GetxController {
  final _currentTab = Rx<int>(0);
  int get currentTab => _currentTab.value;
  set currentTab(int val) => _currentTab.value = val;
}
