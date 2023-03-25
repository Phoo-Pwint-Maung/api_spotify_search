import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/src/response.dart';
import 'package:provider/provider.dart';
import 'package:search_api/model/playlist_model.dart';
import 'package:search_api/model/search_text.dart';

class GetInfo {
  void getInfo({required BuildContext context}) async {
    String searching = context.read<TextSearch>().textList.first;

    Response response = await ApiInfo().getApi(
        endPoint:
            "search/?q=$searching&type=tracks&limit=3&numberOfTopResults=5");

    String songName =
        jsonDecode(response.body)["tracks"]["items"][0]["data"]["name"];
    String albumPhoto = jsonDecode(response.body)["tracks"]["items"][0]["data"]
        ["albumOfTrack"]["coverArt"]["sources"][0]["url"];
    context.read<PlayLists>().addPlayList(
        value: PlayList(songName: songName, albumPhoto: albumPhoto));
  }
}

class ApiInfo {
  String _baseUrl = "https://spotify23.p.rapidapi.com/";
  final Map<String, String> _header = {};
  String _apiKey = "275969399amshef593573afa7fd8p1ff3e0jsn9e168261f7f0";
  String _apiHost = "spotify23.p.rapidapi.com";

  Future<Response> getApi(
      {required String endPoint,
      String? baseUrl,
      String? apiKey,
      String? apiHost}) async {
    if (baseUrl != null) {
      _baseUrl = baseUrl;
    }
    if (apiKey != null) {
      _apiKey = apiKey;
    }
    _header["X-RapidAPI-Key"] = _apiKey;
    if (apiHost != null) {
      _apiHost = apiHost;
    }
    _header["X-RapidAPI-Host"] = _apiHost;

    return await http.get(Uri.parse("$_baseUrl$endPoint"), headers: _header);
  }
}
