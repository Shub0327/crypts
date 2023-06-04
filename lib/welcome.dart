import 'package:crypts/home.dart';
import 'package:crypts/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:splashscreen/splashscreen.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       child: ElevatedButton(
           onPressed: (){
             Get.to(Signup());
           },
           child: Text("hello")),

      ),
    );
    // return SplashScreen(
    //   seconds: 6,
    //   navigateAfterSeconds: new Signup(),
    //   title: new Text('Cryts',textScaleFactor: 2,),
    //   image: new Image.network('https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.rd.com%2Farticle%2Fhow-does-cryptocurrency-work%2F&psig=AOvVaw1y1yrY9Fm2lpoCRZ0zrm3D&ust=1685881048822000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCIjTvrqKp_8CFQAAAAAdAAAAABAE'),
    //   loadingText: Text("Loading"),
    //   photoSize: 100.0,
    //   loaderColor: Colors.blue,
    // );
  }
}
