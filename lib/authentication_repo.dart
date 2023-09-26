import 'package:crypts/signup.dart';
import 'package:crypts/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypts/home.dart';
import 'package:get/get.dart';

class AuthenticationRepo extends GetxController {
  static AuthenticationRepo get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 6));
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setIntialScreen);
  }



  String? getUidData() {
    final User? user = _auth.currentUser;
    String? uid = user?.uid;
    return uid;
    // here you write the codes to input the data into firestore
  }

  _setIntialScreen(User? user) {
    user == null ? Get.offAll(() => Signup()) : Get.offAll(() => Home());
  }

  Future<void> createUserWithEmailPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }
  Future<void> loginWithEmailPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }
  Future<void> logout()async {
    await _auth.signOut();
  }

}

