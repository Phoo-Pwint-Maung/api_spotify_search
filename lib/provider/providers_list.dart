import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:search_api/model/count_model.dart';
import 'package:search_api/model/music_api_model.dart';
import 'package:search_api/model/playlist_model.dart';
import 'package:search_api/model/search_text.dart';

final List<SingleChildWidget> provider = [
  ChangeNotifierProvider(
    create: (context) => SpotifyList(),
  ),
  ChangeNotifierProvider(
    create: (context) => CountModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => PlayLists(),
  ),
  ChangeNotifierProvider(
    create: (context) => TextSearch(),
  ),
];
