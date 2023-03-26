import 'package:flutter/material.dart';

class PlayList {
  String songName;
  String albumPhoto;
  String artistName;

  PlayList(
      {required this.songName,
      required this.albumPhoto,
      required this.artistName});
}

class PlayLists extends ChangeNotifier {
  List playList = [];

  void addPlayList({required PlayList value}) {
    playList.add(value);
    notifyListeners();
  }
}
