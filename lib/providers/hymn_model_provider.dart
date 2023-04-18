import 'package:flutter/foundation.dart';
import 'package:hdc_remake/models/hymn.dart';

class HymnsModel extends ChangeNotifier {
  List<Hymn> _hymns = [];

  List<Hymn> get hymns => _hymns;

  void setHymns(List<Hymn> newHymns) {
    _hymns = newHymns;
    notifyListeners();
  }
}
