import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:search_api/api/playlist_api.dart';
import 'package:search_api/model/count_model.dart';
import 'package:search_api/model/playlist_model.dart';
import 'package:search_api/model/search_text.dart';

class MinusPage extends StatefulWidget {
  final title;
  const MinusPage({super.key, required this.title});

  @override
  State<MinusPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MinusPage> {
  final search = TextEditingController();
  String text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            // Search Artist
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: Consumer<PlayLists>(builder: (context, playlist, _) {
                    return Column(
                      children: [
                        TextFormField(
                          controller: search,
                          style: const TextStyle(
                            color: Colors.green,
                            letterSpacing: 0.3,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          cursorColor: Colors.green,
                          decoration: const InputDecoration(
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            fillColor: Colors.black,
                            border: InputBorder.none,
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Provider.of<TextSearch>(context, listen: false)
                                .textList
                                .clear();
                            Provider.of<TextSearch>(context, listen: false)
                                .addText(search: search.text);

                            playlist.playList.clear();
                            GetInfo().getInfo(context: context);
                          },
                          child: const Text("Click"),
                        ),
                        Consumer<TextSearch>(builder: (context, textsearch, _) {
                          if (textsearch.textList.isEmpty) {
                            return const Text("search something ");
                          }
                          return Text(textsearch.textList.first);
                        }),
                        ListView(
                          shrinkWrap: true,
                          children: [
                            if (playlist.playList.isNotEmpty)
                              ...playlist.playList.map(
                                (e) => ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Image.network(e.albumPhoto),
                                    Text(e.songName),
                                    if (playlist.playList.isEmpty)
                                      const Text("no data found")
                                  ],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ...playlist.playList.map((e) => Container(
                              width: 400,
                              height: 70,
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              color: Colors.black,
                              child: Row(
                                children: [
                                  Image.network(
                                    e.albumPhoto,
                                    width: 100,
                                    height: 100,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.songName,
                                            style: const TextStyle(
                                              color: Colors.green,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            e.artistName,
                                            style: const TextStyle(
                                              color: Colors.green,
                                              fontSize: 15,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 40,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.green,
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
