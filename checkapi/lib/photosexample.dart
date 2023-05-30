import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/sercondmodel.dart';

class PhotosExample extends StatefulWidget {
  const PhotosExample({super.key});

  @override
  State<PhotosExample> createState() => _PhotosExampleState();
}

class _PhotosExampleState extends State<PhotosExample> {
  List<SecondModel> photosList = [];

  Future<List<SecondModel>> getphotosAPI() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        SecondModel secondModel =
            SecondModel(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(secondModel);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          // occupy avaliable widget
          child: FutureBuilder(
              future: getphotosAPI(),
              builder: (context, AsyncSnapshot<List<SecondModel>> snapshot) {
                return ListView.builder(
                    itemCount: photosList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading:
                            Image.network(snapshot.data![index].url.toString()),
                        subtitle: Text(snapshot.data![index].title.toString()),
                        title: Text(snapshot.data![index].id.toString()),
                      );
                    });
              }),
        )
      ]),
    );
  }
}
