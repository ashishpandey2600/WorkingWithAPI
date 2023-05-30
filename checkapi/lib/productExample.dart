import 'dart:convert';

import 'package:checkapi/models/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductExample extends StatefulWidget {
  const ProductExample({super.key});

  @override
  State<ProductExample> createState() => _ProductExampleState();
}

class _ProductExampleState extends State<ProductExample> {
  Future<ProductModel> getProductApi() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/f3592abf-5eae-45b0-a390-1b187b07701c'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductModel.fromJson(data);
    } else {
      return ProductModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Expanded(
              child: FutureBuilder(
            future: getProductApi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .3,
                            width: MediaQuery.of(context).size.width * 1,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    snapshot.data!.data![index].images!.length,
                                itemBuilder: (context, position) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .25,
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data!
                                              .data![index]
                                              .images![position]
                                              .url
                                              .toString()),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
                    });
              } else {
                return Text("Loading");
              }
            },
          ))
        ]),
      ),
    );
  }
}
