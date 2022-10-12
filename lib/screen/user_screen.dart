import 'package:crypto_application/screen/data/model/Crypto.dart';
import 'package:flutter/material.dart';

class CryptoList extends StatefulWidget {
  CryptoList({Key? key, this.cryptoList}) : super(key: key);
  List<Crypto>? cryptoList;
  @override
  State<CryptoList> createState() => _CryptoListState();
}

class _CryptoListState extends State<CryptoList> {
  List<Crypto>? cryptoList;
  @override
  void initState() {
    super.initState();
    cryptoList = widget.cryptoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView.builder(
            itemCount: cryptoList!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: Center(
                  child: ListTile(
                    title: Text(cryptoList![index].name),
                    subtitle: Text(cryptoList![index].name),
                    leading: SizedBox(
                      width: 30.0,
                      child: Center(
                        child: Text(
                          cryptoList![index].rank.toString(),
                        ),
                      ),
                    ),
                    trailing: SizedBox(
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cryptoList![index].priceUsd.toStringAsFixed(2),
                              ),
                              Text(
                                cryptoList![index]
                                    .changePercent24hr
                                    .toStringAsFixed(2),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 40.0,
                            child: Center(
                              child: _getIconChangePercent(
                                  cryptoList![index].changePercent24hr),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
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
}
