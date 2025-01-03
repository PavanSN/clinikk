import 'package:flutter/foundation.dart';

class HomeController extends ChangeNotifier {
  int tabIndex = 0;
  String tabName = 'Home';

  void setTabName() {
    switch (tabIndex) {
      case 0:
        tabName = 'Home';
      case 1:
        tabName = 'Search';
      case 3:
        tabName = 'Alert';
      case 4:
        tabName = 'Profile';
      default:
        tabName = 'Home';
    }
  }

  void navToTab(int index) {
    tabIndex = index;
    setTabName();
    notifyListeners();
  }
}
