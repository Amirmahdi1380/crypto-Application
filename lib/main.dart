import 'package:crypto_application/screen/coin_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Main_Application());
}
class Main_Application extends StatelessWidget {
  const Main_Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
