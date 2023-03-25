import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/src/response.dart';
import 'package:provider/provider.dart';
import 'package:search_api/model/music_api_model.dart';

class MusicApi {
  static void getResponse({required BuildContext context}) async {
    final response = await AppApi.getApi(
      endPoint:
          "/Search/ImageSearchAPI?q=taylor%20swift&pageNumber=1&pageSize=10&autoCorrect=true",
    );

    final data = (jsonDecode(response.body) as Map)['value'] as List;

    for (var e in data) {
      // Provider.of<SpotifyList>(context).addSpotify(
      //   value: Spotify(title: e["title"], photoUrl: e["url"]),
      // );
      // SpotifyList().addSpotify(value: Spotify(title: e["title"], photoUrl: e["url"]),);
      context.read<SpotifyList>().addSpotify(
            value: Spotify(title: e["title"], photoUrl: e["url"]),
          );
    }
  }
}

class AppApi {
  static String _baseUrl =
      "https://contextualwebsearch-websearch-v1.p.rapidapi.com/api";

  static String _rapidKey =
      "275969399amshef593573afa7fd8p1ff3e0jsn9e168261f7f0";
  static String _rapidHost = "contextualwebsearch-websearch-v1.p.rapidapi.com";

  static final Map<String, String> _header = {};

  static Future<Response> getApi(
      {required String endPoint,
      String? baseUrl,
      String? rapidKey,
      String? rapidHost}) async {
    if (baseUrl != null) {
      _baseUrl = baseUrl;
    }
    if (rapidKey != null) {
      _rapidKey = rapidKey;
    }
    _header["X-RapidAPI-Key"] = _rapidKey;
    if (rapidHost != null) {
      _rapidHost = rapidHost;
    }
    _header["X-RapidAPI-Host"] = _rapidHost;
    return await http.get(Uri.parse("$_baseUrl$endPoint"), headers: _header);
  }
}
