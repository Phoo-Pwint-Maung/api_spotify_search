import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:search_api/api/music_api.dart';
import 'package:search_api/model/count_model.dart';
import 'package:search_api/model/music_api_model.dart';

class AddPage extends StatefulWidget {
  final String title;
  const AddPage({super.key, required this.title});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String photoGet1 = "";
  String photoGet2 = "";

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<SpotifyList>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 30,
          ),
          child: Column(children: [
            // number and Total Text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // getting data from data holder and show
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
            // Plus button and Next Page Button
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    if (Provider.of<CountModel>(context, listen: false).x < 5) {
                      Provider.of<CountModel>(context, listen: false)
                          .incrementX();
                    }
                  },
                  child: const Icon(Icons.add),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/minus_page");
                  },
                  child: const Text("next Page"),
                ),
              ],
            ),
            // Get Image Button
            ElevatedButton(
              onPressed: () async {
                var getImage1 = await http.get(Uri.parse(
                    "https://random.imagecdn.app/v1/image?width=500&height=500&category=people"));
                var getImage2 = await http.get(Uri.parse(
                    "https://random.imagecdn.app/v1/image?width=500&height=500&category=people"));

                setState(() {
                  photoGet1 = getImage1.body;
                  photoGet2 = getImage2.body;
                });
              },
              child: const Text("Get Image"),
            ),
            // Show Two Image
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (photoGet1.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Image.network(
                      photoGet1,
                      width: 150,
                      height: 150,
                    ),
                  ),
                if (photoGet2.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Image.network(
                      photoGet2,
                      width: 150,
                      height: 150,
                    ),
                  ),
              ],
            ),
            // API image button
            Consumer<SpotifyList>(builder: (context, spotiy, _) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(children: [
                  OutlinedButton(
                    onPressed: () {
                      list.allList.clear();
                      MusicApi.getResponse(context: context);
                    },
                    child: const Text("Get Image From API"),
                  ),

                  // API get Image TExt  here
                  Column(
                    children: [
                      ...spotiy.allList.map(
                        (e) => Column(
                          children: [
                            Image.network(e.photoUrl, errorBuilder:
                                (BuildContext context, Object exception,
                                    StackTrace? stackTrace) {
                              return const Text('image not found');
                            }),
                            Text(e.title),
                          ],
                        ),
                      ),
                      const Text("Here is Done ############")
                    ],
                  )
                ]),
              );
            })
          ]),
        ),
      ),
    );
  }
}
