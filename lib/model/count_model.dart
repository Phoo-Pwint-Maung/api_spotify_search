import 'package:flutter/material.dart';

class CountModel extends ChangeNotifier {
  int _x = 0;
  int get x => _x;
  void incrementX() {
    _x++;
    notifyListeners(); // setState နဲ့တူတယ် // update()
  }

  void decrement() {
    _x--;
    notifyListeners(); // setState နဲ့တူတယ် // update()
  }
}
