import 'package:flutter/material.dart';

class Spotify {
  String title;
  String photoUrl;

  Spotify({
    required this.title,
    required this.photoUrl,
  });
}

class SpotifyList extends ChangeNotifier {
  List allList = [];

  void addSpotify({required Spotify value}) {
    allList.add(value);
    debugPrint("@@@@@@@${allList.length}");
    notifyListeners();
  }
}
