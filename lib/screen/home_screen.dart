import 'package:crypto_application/screen/data/model/user.dart';
import 'package:crypto_application/screen/user_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User>? user;
  @override
  void initState() {
    super.initState();
    getDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SpinKitFoldingCube(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void getDate() async {
    var response =
        await Dio().get('https://jsonplaceholder.typicode.com/users');
    List<User> userList = response.data
        .map<User>((jsonMapObject) => User.fromMapJson(jsonMapObject))
        .toList();
    //var user = User.fromMapJson(jsonMapObject);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserScreen(
          user: userList,
        ),
      ),
    );
  }
}
