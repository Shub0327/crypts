import 'package:crypts/authentication_repo.dart';
import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
@override
void initState(){
  AuthenticationRepo.instance.logout();
}
