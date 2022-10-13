import 'package:crypto_application/screen/data/model/Crypto.dart';
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
  List<Crypto>? crypto;
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
            Image(
              image: AssetImage('assets/images/money.png'),
              height: 450.0,
              width: 300.0,
            ),
            Text(
              'لطفا صبر کنید',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: SpinKitSpinningLines(
                color: Colors.white,
                size: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getDate() async {
    var response = await Dio().get('https://api.coincap.io/v2/assets');
    List<Crypto> cryptoList = response.data['data']
        .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
        .toList();
    //var user = User.fromMapJson(jsonMapObject);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CryptoList(
          cryptoList: cryptoList,
        ),
      ),
    );
  }
}
