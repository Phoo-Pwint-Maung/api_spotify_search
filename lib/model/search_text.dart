import 'package:flutter/material.dart';

class SearchText {
  String searchText;
  SearchText({required this.searchText});
}

class TextSearch extends ChangeNotifier {
  List textList = [];
  void addText({required String search}) {
    textList.add(search);
    notifyListeners();
  }
}
