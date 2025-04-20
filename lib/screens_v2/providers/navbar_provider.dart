import 'package:flutter/material.dart';

class NavBarProvider with ChangeNotifier {
  int _currentIndex = 1; // เริ่มต้นที่หน้า Home

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }
}