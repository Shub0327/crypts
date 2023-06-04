import 'dart:async';
import 'dart:convert';
import 'package:crypts/authentication_repo.dart';
import 'package:crypts/drawer_widget.dart';
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
  bool _loading = false;
  Future<List<Coinmodel>> fetchCoin() async {
    coinList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coinmodel.fromJson(map));
          }
        }
        setState(() {
          _loading = false;
          coinList;
        });
      }
      return coinList;
    }

    else {
      throw Exception('Failed to load coins');
    }
  }


  @override
  void initState() {
    fetchCoin();
    setState(() {
          _loading = true;
        });

    Timer.periodic(const Duration(seconds: 10), (timer) => fetchCoin());
    super.initState();
  }

  // Future<List<Coinmodel>> fetchCoin() async {
  //   coinList = [];
  //   final response = await http.get(Uri.parse(
  //       'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
  //   if (response.statusCode == 200) {
  //     try {
  //       final values = (json.decode(response.body) as List).cast<Map<String, dynamic>>();
  //       // List<dynamic> values = [];
  //       // values = json.decode(response.body);
  //       if (values.isNotEmpty) {
  //         for (int i = 0; i < values.length; i++) {
  //           if (values[i] != null) {
  //             Map<String, dynamic> map = values[i];
  //             coinList.add(Coinmodel.fromJson(map));
  //           }
  //         }
  //         setState(() {
  //           _loading = false;
  //           coinList;
  //         });
  //       }
  //
  //
  //     }
  //
  //     catch(e){
  //       print(e);
  //     }
  //
  //   }
  //   return coinList;
  //
  //   // else {
  //   //   throw Exception('Failed to load coins');
  //   // }
  // }
  // Future<List<Coinmodel>> fetchCoin() async {
  //   print("in fetchcoin");
  //   coinList = [];
  //   final response = await http.get(Uri.parse(
  //       'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
  //   try {
  //
  //     print("in try block");
  //     // if (response.statusCode == 200) {
  //       print("2");
  //
  //       List<dynamic> values = [];
  //       values = json.decode(response.body);
  //       if (values.isNotEmpty) {
  //         for (int i = 0; i < values.length; i++) {
  //           if (values[i] != null) {
  //             Map<String, dynamic> map = values[i];
  //             coinList.add(Coinmodel.fromJson(map));
  //           }
  //         }
  //         setState(() {
  //           print('Sucess');
  //           _loading = false;
  //           coinList;
  //         });
  //       }
  //
  //
  //     // }
  //
  //   }
  //
  //   catch(e){print(e);}
  //   // else {
  //   //   throw Exception('Failed to load coins');
  //   // }
  //   return coinList;
  // }

  // @override
  // void initState() {
  //   fetchCoin();
  //   setState(() {
  //     _loading = true;
  //   });
  //   Timer.periodic(const Duration(seconds: 10), (timer) => fetchCoin());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    AppBar(
      leading: Icon(Icons.menu),
      title: Text('Page title'),
      actions: [
        Icon(Icons.favorite),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(Icons.search),
        ),
        Icon(Icons.more_vert),
      ],
      backgroundColor: Colors.purple,
    );
    return Scaffold(
      drawer: DrawerWidget(),
      body: Stack(
        children: <Widget>[

          Center(
            child: !_loading
                ? Opacity(
                    opacity: 0,
                    child: ModalBarrier(dismissible: false, color: Colors.black),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Please wait until coins are getting loaded",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
          ),
          Container(
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
                            child: CoinDesign(
                                symbol: coinList[index].symbol,
                                name: coinList[index].name,
                                image: coinList[index].image,
                                currentPrice: coinList[index].currentPrice,
                                priceChangePercentage24H: coinList[index].priceChangePercentage24H));
                      },
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
