import 'package:crypts/Models/UserData.dart';
import 'package:crypts/Models/broughtCoin.dart';
import 'package:crypts/coinController.dart';
import 'package:crypts/drawer_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:crypts/coindesign.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CoinController controller = Get.put(CoinController());

  int initialAmount = 1000;
  List<Broughtcoin> broughtcoinsList = [];

  DatabaseReference dbref = FirebaseDatabase.instance.ref();

  void retrieveData() {
    final User? user = _auth.currentUser;
    String uid = user!.uid;
    dbref.child("Users").child(uid).onChildAdded.listen((data) {
      BroughtcoinData broughtcoinData = BroughtcoinData.fromJson(data.snapshot.value as Map);
      Broughtcoin broughtcoin = Broughtcoin(key: data.snapshot.key, broughtcoinData: broughtcoinData);
      broughtcoinsList.add(broughtcoin);
      setState(() {});
    });
  }

  void addFunds() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(helperText: "Enter Name"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: quantityController,
                    decoration: const InputDecoration(helperText: "Enter Quantity"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Map<String, dynamic> data = {
                          "name": nameController.text.toString(),
                          "quantity": quantityController.text.toString()
                        };

                        final User? user = _auth.currentUser;
                        String uid = user!.uid;
                        dbref.child("Users").child(uid).push().set(data).then((value) => Navigator.of(context).pop());
                       
                      },
                      child: const Text("Save"))
                ],
              ),
            ),
          );
        });
  }

// Future<void> storeUserData(UserData userData) async {
//   try {
//     final DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users').child(userData.uid);
//
//     await userRef.set({
//       'displayName': userData.displayName,
//       'email': userData.email,
//       'wallet':initialAmount.toString(),
//     });
//   } catch (e) {
//     print("Error storing user data: $e");
//   }
// }

  RxBool loading = true.obs;
  RxBool tloading = true.obs;
  RxBool search = false.obs;
  TextEditingController editingController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  initState() {
    print("initState Called");
    retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              addFunds();
            },
          ),
          appBar: AppBar(
            leading: const Icon(Icons.menu),
            title: const Text('Crypts'),
            actions: [
              const Icon(Icons.favorite),
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
              const Icon(Icons.more_vert),
            ],
            backgroundColor: Colors.purple,
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  // text: "Chats",
                ),
                Tab(
                  icon: Icon(Icons.trending_up),
                  // text: "Calls",
                ),
                Tab(
                  icon: Icon(Icons.wallet_outlined),
                  // text: "Settings",
                )
              ],
            ),
          ),
          drawer: DrawerWidget(),
          body: TabBarView(
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    color: Colors.white24,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        if (search.value)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
                            child: TextField(
                              decoration: const InputDecoration(
                                // suffixIcon: Icon(Icons.dangerous),
                                icon: Icon(Icons.search),
                                labelText: "Search your coin here...",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                    color: Colors.purple,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.purple),
                                ),
                              ),
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
                              child: Obx(
                                () => controller.loading.value
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          CircularProgressIndicator(),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Please wait until coins are getting loaded",
                                            style: TextStyle(color: Colors.black),
                                          )
                                        ],
                                      )
                                    : ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: controller.coinList.length,
                                        itemBuilder: (context, index) {
                                          return SingleChildScrollView(
                                              child: CoinDesign(
                                                  symbol: controller.coinList[index].symbol,
                                                  name: controller.coinList[index].name,
                                                  image: controller.coinList[index].image,
                                                  currentPrice: controller.coinList[index].currentPrice,
                                                  priceChangePercentage24H:
                                                      controller.coinList[index].priceChangePercentage24H));
                                        },
                                      ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Stack(
                children: <Widget>[
                  Container(
                    color: Colors.white24,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        if (search.value)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
                            child: TextField(
                              decoration: const InputDecoration(
                                // suffixIcon: Icon(Icons.dangerous),
                                icon: Icon(Icons.search),
                                labelText: "Search your coin here...",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                    color: Colors.purple,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.purple),
                                ),
                              ),
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
                              child: Obx(
                                () => controller.tloading.value
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          CircularProgressIndicator(),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Please wait until trending coins are getting loaded",
                                            style: TextStyle(color: Colors.black),
                                          )
                                        ],
                                      )
                                    : ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: controller.tredingList.length,
                                        itemBuilder: (context, index) {
                                          return SingleChildScrollView(
                                              child: CoinDesign(
                                                  symbol: controller.tredingList[index].symbol,
                                                  name: controller.tredingList[index].name,
                                                  image: controller.tredingList[index].thumb,
                                                  currentPrice: controller.tredingList[index].priceBtc,
                                                  priceChangePercentage24H:
                                                      controller.tredingList[index].score.toDouble()));
                                        },
                                      ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    color: Colors.blueGrey,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Portfolio Value',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '\$${initialAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Wallet Balance',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '\$${initialAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          for (int i = 0; i < broughtcoinsList.length; i++) Widgetbroughtcoin(broughtcoinsList[i])
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }

  Widget Widgetbroughtcoin(Broughtcoin broughtcoinsList) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(broughtcoinsList.broughtcoinData.name!),
          Text(broughtcoinsList.broughtcoinData.quantity!),
        ],
      ),
    );
  }
}
