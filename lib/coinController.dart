import 'dart:async';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:crypts/coinmodel.dart';


class CoinController extends GetxController {

   RxList<Coinmodel>coinList = <Coinmodel>[].obs;
   RxBool loading=true.obs;

   @override
   void onInit() {
      super.onInit();
      fetchCoin();
      Timer.periodic(const Duration(seconds: 10), (timer) => fetchCoin());
   }

   // Inside your CoinController class
   void searchCoins(String query) {
      // Filter the coin list based on the query
      final filteredCoins = coinList.where((coin) {
         final name = coin.name.toLowerCase();
         return name.contains(query.toLowerCase());
      }).toList();

      // Update the coinList with the filtered results
      coinList.assignAll(filteredCoins);
   }



   fetchCoin() async {
      try {
         var response = await http.get(Uri.parse(
             'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));

         List<Coinmodel> coins = CoinmodelFromJson(response.body);
         coinList.value = coins;
      }
      finally{
         loading(false);
      }
   }
}