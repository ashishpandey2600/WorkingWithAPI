import 'dart:convert';
import 'dart:math';

import 'package:checkapi/models/sercondmodel.dart';
import 'package:checkapi/models/servicemodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ServiceModel> serviceList = [];
  Future<List<ServiceModel>> getpostAPI() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      var data = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        serviceList.clear();
        for (Map i in data) {
          serviceList.add(ServiceModel.fromJson(i));
        }
        return serviceList;
      } else {
        return serviceList;
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  List<SecondModel> photosList = [];

  Future<List<SecondModel>> getphotosAPI() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        SecondModel secondModel = SecondModel(title: i['title'], url: i['url']);
        photosList.add(secondModel);
      }
    } else {
      return [];
    }
    return photosList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("API"),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getpostAPI(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("Loading somthing...");
                    } else {
                      return ListView.builder(
                          itemCount: serviceList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                children: [
                                  Text(serviceList[index].userId.toString()),
                                  Text(serviceList[index].id.toString()),
                                  Text(serviceList[index].title.toString()),
                                  Text(serviceList[index].body.toString())
                                ],
                              ),
                            );
                          });
                    }
                  }),
            ),
          ],
        ));
  }
}
