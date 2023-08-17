


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynew/Widgets/Roundbutton.dart';
import 'package:mynew/utils/utils.dart';

class Forget_PasswordScreen extends StatefulWidget {
  const Forget_PasswordScreen({super.key});

  @override
  State<Forget_PasswordScreen> createState() => _Forget_PasswordScreenState();
}

class _Forget_PasswordScreenState extends State<Forget_PasswordScreen> {
  final emailcontroller=TextEditingController();
final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    title: Text("Forgot Password"),
  ),
  body: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextFormField(
          controller: emailcontroller,
          decoration: InputDecoration(

            hintText: "Email",
          ),
        ),
        SizedBox(height: 40,),
        Roundbutton(title: 'Forgot', onTap: (){
auth.sendPasswordResetEmail(email: emailcontroller.text.toString()).then((value) {
  Utils().Message("Please check your email to Reset Password");

}).onError((error, stackTrace){

  Utils().Message(error.toString());

});
        })
      ],
    ),
  ),

);
  }
}
