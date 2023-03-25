import 'package:flutter/material.dart';

class PlayList {
  String songName;
  String albumPhoto;

  PlayList({required this.songName, required this.albumPhoto});
}

class PlayLists extends ChangeNotifier {
  List playList = [];

  void addPlayList({required PlayList value}) {
    playList.add(value);
    notifyListeners();
  }
}
