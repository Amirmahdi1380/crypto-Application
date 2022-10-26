import 'package:crypto_application/screen/data/constants/constant.dart';
import 'package:crypto_application/screen/data/model/Crypto.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CryptoList extends StatefulWidget {
  CryptoList({Key? key, this.cryptoList}) : super(key: key);
  List<Crypto>? cryptoList;
  @override
  State<CryptoList> createState() => _CryptoListState();
}

class _CryptoListState extends State<CryptoList> {
  List<Crypto>? cryptoList;
  bool searching = false;
  @override
  void initState() {
    super.initState();
    cryptoList = widget.cryptoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blackColor,
        automaticallyImplyLeading: false,
        title: Text(
          'کریپتو بازار',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: blackColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    onChanged: (value) {
                      _getFillterList(value);
                      //print(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'اسم رمزارز خود را وارد کنید',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          style: BorderStyle.none,
                          width: 0,
                          // color: Colors.white,
                        ),
                      ),
                      filled: true,
                      fillColor: greenColor,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: searching,
                    child: Text(
                      '...در حال آپدیت',
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Visibility(
                    visible: searching,
                    child: SpinKitSquareCircle(
                      color: greenColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: RefreshIndicator(
                  //key: _refreshIndicatorKey,
                  color: Colors.white,
                  backgroundColor: greenColor,
                  strokeWidth: 5.0,
                  onRefresh: () async {
                    List<Crypto> freshData = await _getRefresh();
                    setState(() {
                      cryptoList = freshData;
                    });
                    //return Future<void>.delayed(const Duration(seconds: 3));
                  },
                  child: ListView.builder(
                    itemCount: cryptoList!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Center(
                          child: _getItemList(cryptoList![index]),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getItemList(Crypto crypto) {
    return ListTile(
      title: Text(
        crypto.name,
        style: TextStyle(color: greenColor, fontSize: 18),
      ),
      subtitle: Text(
        crypto.name,
        style: TextStyle(color: greyColor),
      ),
      leading: SizedBox(
        width: 30.0,
        child: Center(
          child: Text(
            crypto.rank.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      trailing: SizedBox(
        width: 150.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  crypto.priceUsd.toStringAsFixed(2),
                  style: TextStyle(color: greyColor, fontSize: 20),
                ),
                Text(
                  crypto.changePercent24hr.toStringAsFixed(2),
                  style: TextStyle(
                    color: _getColorPrice(crypto.changePercent24hr),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 40.0,
              child: Center(
                child: _getIconChangePercent(
                  crypto.changePercent24hr,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Crypto>> _getRefresh() async {
    var response = await Dio().get('https://api.coincap.io/v2/assets');
    List<Crypto> cryptoList = response.data['data']
        .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
        .toList();
    return cryptoList;
  }

  Widget _getIconChangePercent(double percent24h) {
    //   Widget w;
    //   if (percent24h <= 0) {
    //     w = Icon(Icons.trending_down);
    //   } else
    //     w = Icon(Icons.trending_up);
    //   return w;
    // }
    return percent24h <= 0
        ? Icon(
            Icons.trending_down,
            color: Colors.red,
          )
        : Icon(
            Icons.trending_up,
            color: Colors.green,
          );
  }

  Color _getColorPrice(double changePercent24hr) {
    return changePercent24hr <= 0 ? redColor : greenColor;
  }

  Future<void> _getFillterList(String KeyboardType) async {
    List<Crypto> cryptoResultList = [];
    if (KeyboardType.isEmpty) {
      setState(() {
        searching = true;
      });
      var result = await _getRefresh();
      setState(() {
        cryptoList = result;
        searching = false;
      });
    }
    cryptoResultList = cryptoList!.where((element) {
      return element.name.toLowerCase().contains(KeyboardType);
    }).toList();
    setState(() {
      cryptoList = cryptoResultList;
    });
  }
}
