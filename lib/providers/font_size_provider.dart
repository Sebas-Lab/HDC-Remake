import 'package:flutter/material.dart';

class FontSizeProvider with ChangeNotifier {
  double _fontSize = 18.0;

  double get fontSize => _fontSize;

  void increaseFontSize() {
    _fontSize += 2.0;

    if (_fontSize > 40) {
      _fontSize = 40;
    }

    notifyListeners();
  }

  void decreaseFontSize() {
    _fontSize -= 2.0;

    if (_fontSize < 15) {
      _fontSize = 15;
    }

    notifyListeners();
  }
}
