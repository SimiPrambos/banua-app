import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppController with ChangeNotifier {
  int _index = 0;
  bool _loading = false;

  get index => _index;
  set index(int val) {
    _index = val;
    notifyListeners();
  }

  get loading => _loading;
  set lading(bool val) {
    _loading = val;
    notifyListeners();
  }
}

Widget withController(Widget myApp) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppController()),
    ],
    child: myApp,
  );
}
