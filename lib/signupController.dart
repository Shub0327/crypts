import 'package:crypts/authentication_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class SignupController extends GetxController{

  static SignupController get instance => Get.find();

  final email =TextEditingController();
  final password =TextEditingController();

  void registerUser(String email,String password){
    AuthenticationRepo.instance.createUserWithEmailPassword(email, password);

  }
  void loginUser(String email,String password){
    AuthenticationRepo.instance.loginWithEmailPassword(email, password);

  }
}