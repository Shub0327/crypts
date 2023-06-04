import 'package:crypts/signupController.dart';
import 'package:crypts/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final controller = Get.put(SignupController());

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/register.png'), fit: BoxFit.cover),
          ),
          padding: EdgeInsets.all(30),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 35, top:60),
                  child: Text(
                    'Create\nAccount',
                    style: TextStyle(color: Colors.white, fontSize: 33,fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: TextFormField(
                    controller: controller.email,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.mail,color: Colors.white,), hintText: 'Enter the mail address', labelText: 'Email',hintStyle: TextStyle(color: Colors.white),labelStyle:  TextStyle(color: Colors.white) ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'invaild';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: TextFormField(
                    // autofocus: true,
                    controller: controller.password,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.password,color: Colors.white), hintText: 'Enter the Password', labelText: 'Password',hintStyle: TextStyle(color: Colors.white),labelStyle:  TextStyle(color: Colors.white)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'invaild';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 60,),
                // Container(
                //   child: ElevatedButton(
                //     child: Text('Submit'),
                //     onPressed: () {
                //
                //     },
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.w700),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xff4c505b),
                      child: IconButton(
                          color: Colors.white,
                          onPressed: () {if (_formkey.currentState!.validate()) {
                            print('success');
                            SignupController.instance
                                .registerUser(controller.email.text.trim(), controller.password.text.trim());
                            // Get.to(Home());
                          }},
                          icon: Icon(
                            Icons.arrow_forward,
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
