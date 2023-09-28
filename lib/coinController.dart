import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:crypts/coinmodel.dart';

import 'Models/TrendCoinModel.dart';


class CoinController extends GetxController {

   RxList<Coinmodel>coinList = <Coinmodel>[].obs;
   // RxList<Trendmodel>tredingList = <Trendmodel>[].obs;
   RxList<Item> itemList = <Item>[].obs;

   RxBool loading=true.obs;
   RxBool tloading=true.obs;


   @override
   void onInit() {
      super.onInit();
      fetchCoin();
      Timer.periodic(const Duration(seconds: 10), (timer) => fetchCoin());
      tredingCoin();
      Timer.periodic(const Duration(seconds: 10), (timer) => tredingCoin());
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


   Future<void> tredingCoin() async {
      try {
         final response = await http.get(Uri.parse('https://api.coingecko.com/api/v3/search/trending/'));

         if (response.statusCode == 200) {
            final jsonData = json.decode(response.body);
            if (jsonData.containsKey("coins") && jsonData["coins"] is List) {
               final List<dynamic> coinListData = jsonData["coins"];
               final List<Item> trendingItems = coinListData
                   .map((coinJson) => Item.fromJson(coinJson["item"]))
                   .toList();

               // Update itemList with the trending items
               itemList.assignAll(trendingItems);

               // Now you have a list of Item objects

            } else {
               // Handle a case where "coins" key is not found or is not a List
               print("Invalid JSON data format");
            }
         } else {
            // Handle HTTP request failure
            print('API request failed with status code: ${response.statusCode}');
         }
      } catch (e) {
         // Handle other exceptions, e.g., network errors or JSON parsing errors
         print('Error during API request: $e');
      } finally {
         tloading(false);
      }
   }

   // tredingCoin()async{
   //    try{
   //       var response= await http.get(Uri.parse('https://api.coingecko.com/api/v3/search/trending/'));
   //       List<Trendmodel> tcoin= TrendmodelFromJson(response.body);
   //       tredingList.value=tcoin;
   //    }
   //
   //        finally{
   //       tloading(false);
   //        }
   // }

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