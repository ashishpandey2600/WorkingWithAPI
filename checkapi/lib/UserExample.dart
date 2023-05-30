import 'dart:convert';
import 'package:checkapi/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserExample extends StatefulWidget {
  const UserExample({super.key});

  @override
  State<UserExample> createState() => _UserExampleState();
}

class _UserExampleState extends State<UserExample> {
  List<UsersModel> userList = [];

  Future<List<UsersModel>> getUserid() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        userList.add(UsersModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
            child: FutureBuilder(
          future: getUserid(),
          builder: (context, AsyncSnapshot<List<UsersModel>> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Flexible(
                          child: Column(children: [
                            ReusableRow(
                                title: 'Name',
                                value: snapshot.data![index].name),
                            ReusableRow(
                                title: 'email',
                                value: snapshot.data![index].email),
                            ReusableRow(
                                title: 'username',
                                value: snapshot.data![index].username),
                            ReusableRow(
                                title: 'id',
                                value: snapshot.data![index].id.toString()),
                            ReusableRow(
                                title: 'Address',
                                value: snapshot.data![index].address!.city
                                        .toString() +
                                    "\n" +
                                    snapshot.data![index].address!.street
                                        .toString() +
                                    "\n" +
                                    snapshot.data![index].address!.suite
                                        .toString() +
                                    "\n" +
                                    snapshot.data![index].address!.city
                                        .toString() +
                                    "\n" +
                                    snapshot.data![index].address!.zipcode
                                        .toString()),
                            ReusableRow(
                                title: 'geo',
                                value: snapshot.data![index].address!.geo!.lat
                                        .toString() +
                                    snapshot.data![index].address!.geo!.lng
                                        .toString()),
                            ReusableRow(
                                title: 'phone',
                                value: snapshot.data![index].phone.toString()),
                            ReusableRow(
                                title: 'website',
                                value:
                                    snapshot.data![index].website.toString()),
                            ReusableRow(
                                title: 'company name',
                                value: snapshot.data![index].company!.name
                                    .toString()),
                            ReusableRow(
                                title: 'catchPhrase',
                                value: snapshot
                                    .data![index].company!.catchPhrase
                                    .toString()),
                            ReusableRow(
                                title: 'company bs',
                                value: snapshot.data![index].company!.bs
                                    .toString()),
                          ]),
                        ),
                      ),
                    );
                  });
            }
          },
        ))
      ]),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String? title, value;

  ReusableRow({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title!),
        Text(value!),
      ],
    );
  }
}
