import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:crypts/coindesign.dart';
import 'package:crypts/coinmodel.dart';
import 'package:crypts/currencies.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future <List<Coinmodel>> fetchcoin() async {
    print("1");
    coinList = [];
    String apiUrl = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false';
    final res = await http.get(Uri.parse(apiUrl));
    try {
      if (res.statusCode == 200) {
        print("200");
        List<dynamic> response = [];
        response = jsonDecode(res.body);
        if (response.isNotEmpty) {
          print("not empty");
          for (
          int i = 0; i < response.length; i++
          ) {
            if (response[i] != null) {

              // print(response[i]);
              Map<String, dynamic> map = response[i];
              coinList.add(Coinmodel.fromJson(map));
            }
          }
          setState(() {
            coinList;
          });
        }

      }
    }
    catch(e)
    {
    print(e);
    }
    return coinList;

  }
  @override
  void initState() {
    fetchcoin();
    // Timer.periodic(const Duration(seconds: 10), (timer) => fetchcoin());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white24,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: coinList.length,
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                                child:
                                CoinDesign(
                                    symbol:coinList[index].symbol,
                                    name: coinList[index].name,
                                    image: coinList[index].image,
                                    currentPrice: coinList[index].currentPrice,
                                    priceChangePercentage24H: coinList[index].priceChangePercentage24H
                                )
                            );
                  },
                )),
          ],
        ),
      ),


      // Container(
      //   height: double.infinity,
      //   child: ListView.builder(
      //       scrollDirection: Axis.vertical,
      //       itemCount: coinList.length,
      //       itemBuilder: (context, index) {
      //     return SingleChildScrollView(
      //         child:
      //         CoinDesign(
      //             symbol:coinList[index].symbol,
      //             name: coinList[index].name,
      //             image: coinList[index].image,
      //             currentPrice: coinList[index].currentPrice,
      //             priceChangePercentage24H: coinList[index].priceChangePercentage24H
      //         )
      //     );
      //
      //
      //   }),
      // ),
    );
  }


}
