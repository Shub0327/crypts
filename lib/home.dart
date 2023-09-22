import 'dart:async';
import 'dart:convert';
import 'package:crypts/authentication_repo.dart';
import 'package:crypts/coinController.dart';
import 'package:crypts/drawer_widget.dart';
import 'package:http/http.dart' as http;
import 'package:crypts/coindesign.dart';
import 'package:crypts/coinmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

final CoinController controller=Get.put(CoinController());

  RxBool loading=true.obs;
  RxBool search=false.obs;
  TextEditingController editingController=new TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:
        AppBar(
          leading: Icon(Icons.menu),
          title: Text('Crypts'),
          actions: [
            Icon(Icons.favorite),
            IconButton(
              iconSize: 30,
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  search.value = !search.value; // Toggle the search value
                  if (!search.value) {
                    // Clear the search query and restore the original coin list
                    editingController.clear();
                    // controller.resetCoins();
                  }
                });
              },
            ),
            Icon(Icons.more_vert),
          ],
          backgroundColor: Colors.purple,
        ),
      drawer: DrawerWidget(),
      body: Stack(
        children: <Widget>[


          Container(
            color: Colors.white24,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                if (search.value)
              Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
          child: TextField(
            controller: editingController,
            onChanged: (query) {
              controller.searchCoins(query); // Call the search function
            },
              ),
              ),


                Expanded(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Obx(()=>

                         controller.loading.value?Column(
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
                         ):

                         ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: controller.coinList.length,
                          itemBuilder: (context, index) {
                            return SingleChildScrollView(
                                child: CoinDesign(
                                    symbol: controller.coinList[index].symbol,
                                    name: controller.coinList[index].name,
                                    image: controller.coinList[index].image,
                                    currentPrice: controller.coinList[index].currentPrice,
                                    priceChangePercentage24H: controller.coinList[index].priceChangePercentage24H));
                          },
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
