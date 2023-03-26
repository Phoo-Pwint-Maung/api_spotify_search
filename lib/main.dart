import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:search_api/add_page.dart';
import 'package:search_api/minus_page.dart';
import 'package:search_api/provider/providers_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: provider,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AddPage(title: "Search Song and Image"),
        routes: {
          "/minus_page": (context) => const MinusPage(title: "Spotify Search")
        },
      ),
    );
  }
}
