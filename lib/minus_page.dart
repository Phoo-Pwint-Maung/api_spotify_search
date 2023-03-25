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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              // Minus Function Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<CountModel>(builder: (context, countModel, child) {
                    return Text(
                      "${countModel.x}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // context.read<CountModel>().decrement(); အတူတူပဲ
                      if (Provider.of<CountModel>(context, listen: false).x >
                          0) {
                        Provider.of<CountModel>(context, listen: false)
                            .decrement();
                      }
                    },
                    child: const Icon(Icons.remove),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("next Page"),
                  )
                ],
              ),
              //  Minus Function Row

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
                          Consumer<TextSearch>(
                              builder: (context, textsearch, _) {
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
                          )
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
