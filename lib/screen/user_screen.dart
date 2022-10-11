import 'package:crypto_application/screen/data/model/user.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  UserScreen({Key? key, this.user}) : super(key: key);
  List<User>? user;
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<User>? user;
  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView.builder(
            itemCount: user!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  height: 140,
                  width: 100,
                  color: Colors.red,
                  child: Text(
                    user![index].name,
                    style: TextStyle(fontSize: 34),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
