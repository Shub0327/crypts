import 'package:crypts/Models/broughtCoin.dart';
import 'package:crypts/authentication_repo.dart';
import 'package:crypts/coinController.dart';
import 'package:crypts/trendCoinDesign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:crypts/coindesign.dart';
import 'package:flutter/foundation.dart';
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

  RxBool loading = true.obs;
  RxBool tloading = true.obs;
  RxBool search = false.obs;
  TextEditingController editingController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  initState() {
    super.initState();
    checkFirstLogin();
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
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.purpleAccent),
                  child: Text("Settings"),
                ),
                ListTile(
                  title: const Text("Logout"),
                  onTap: () {
                    setState(() {
                      AuthenticationRepo.instance.logout();
                    });
                  },
                ),
              ],
            ),
          ),
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
                                        itemCount: controller.itemList.length,
                                        itemBuilder: (context, index) {
                                          return SingleChildScrollView(
                                              child: TrendDesign(
                                            symbol: controller.itemList[index].symbol,
                                            name: controller.itemList[index].name,
                                            coinId: controller.itemList[index].coinId,
                                            small: controller.itemList[index].small,
                                            priceBtc: controller.itemList[index].priceBtc,
                                            score: controller.itemList[index].score,
                                            marketCapRank: controller.itemList[index].marketCapRank,
                                          ));
                                        },
                                      ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Colors.blueGrey,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text(
                              'Portfolio Value',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '\$${initialAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Wallet Balance',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              '\$${initialAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
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
                        final User? user = _auth.currentUser;
                        String uid = user!.uid;

                        // String? coinId = dbref.child("Users").child(uid).child("BroughtCoins").push().key;

                        Map<String, dynamic> data = {
                          "name": nameController.text.toString(),
                          "quantity": quantityController.text.toString()
                        };
                        dbref
                            .child("Users")
                            .child(uid)
                            .child("BroughtCoins")
                            .push()
                            .set(data)
                            .then((value) => Navigator.of(context).pop());
                      },
                      child: const Text("Save"))
                ],
              ),
            ),
          );
        });
  }

  void retrieveData() {
    final User? user = _auth.currentUser;

    if (user != null) {
      String uid = user.uid;
      // String? coinId = dbref.child("Users").child(uid).child("BroughtCoins").push().key;
      dbref.child("Users").child(uid).child("BroughtCoins").onChildAdded.listen((data) {
        BroughtcoinData broughtcoinData = BroughtcoinData.fromJson(data.snapshot.value as Map);
        Broughtcoin broughtcoin = Broughtcoin(key: data.snapshot.key, broughtcoinData: broughtcoinData);
        setState(() {
          broughtcoinsList.add(broughtcoin);
        });
      });
    }
  }

  bool isFirstLogin = true; // A flag to track first-time login

  void checkFirstLogin() {
    final User? user = _auth.currentUser;
    if (user != null) {
      String? uid = user.uid;

      // Check if the user's data already exists in the database
      dbref.child("Users").once().then((DatabaseEvent databaseEvent) {
        if (databaseEvent.snapshot.value != null) {
          Map<String, dynamic> userData = databaseEvent.snapshot.value as Map<String, dynamic>;

          // Check if "displayName" exists and is not null in userData
          if (!userData.containsKey(uid) || userData["displayName"] == "") {
            showEditProfileDialog(user);
          }

          // Check if "wallet" exists and is not null in userData
          // if (userData.containsKey("wallet") && userData["wallet"] != null) {
          //   String walletBalance = userData["wallet"];
          //
          //   // Set the walletBalance in the quantityController
          //   quantityController.text = walletBalance;
          // }
          // Now, you can proceed with showing the edit profile dialog
        }
        // If "UserData" doesn't exist in the database, you can still show the edit profile dialog
      }).catchError((error) {
        // Handle error if data retrieval fails
        if (kDebugMode) {
          print("Error retrieving UserData: $error");
        }
      });
    }
  }

  void showEditProfileDialog(User user) {
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
                  decoration: InputDecoration(
                    helperText: "Enter Display Name",
                    hintText: user.displayName ?? "", // Show current display name if available
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: quantityController,
                  decoration: InputDecoration(
                    helperText: "Enter Wallet Balance",
                    hintText: isFirstLogin ? "" : initialAmount.toString(), // Show empty or current wallet balance
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    String displayName = nameController.text.toString();
                    String walletBalance = quantityController.text.toString();

                    // Update user data in the database
                    updateUserProfile(user, displayName, walletBalance);

                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text("Save"),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void updateUserProfile(User user, String displayName, String walletBalance) {
    // Update wallet balance in the database
    final String uid = user.uid;
    Map<String, dynamic> userData = {
      "displayName": displayName,
      "email": user.email,
      "wallet": walletBalance,
    };

    dbref.child("Users").child(uid).child("UserData").set(userData).then((value) {
      // After updating, set isFirstLogin to false
      isFirstLogin = false;
    }).catchError((error) {
      // Handle error if user data storage fails
      print("Error storing user data: $error");
    });
  }
}
