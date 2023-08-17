

import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynew/Widgets/Roundbutton.dart';
import 'package:mynew/ui/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynew/utils/utils.dart';
class signupscreen extends StatefulWidget{




  @override
  State<StatefulWidget> createState() {

    return S2();
  }
}

class S2 extends State<signupscreen>{
  bool loading=false;
  final _formfield=GlobalKey<FormState>();
  final emailcontroller=TextEditingController();
  final passwordcontroller=TextEditingController();
  FirebaseAuth _auth=FirebaseAuth.instance;
  

  void Singup()
  {


      setState(() {
        loading=true;
      });


      _auth.createUserWithEmailAndPassword(email: emailcontroller.text.toString(), password: passwordcontroller.text.toString()).then((value){


        setState(() {
          loading=false;
        });


      }).onError((error, stackTrace) {
        setState(() {
          loading=false;
        });
        Utils().Message(error.toString());
      });}



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp "),
      ),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(key: _formfield,
            child: Column(
              children: [
                TextFormField(


                  decoration:const InputDecoration(

                    hintText: "Email",

                    prefixIcon: Icon(Icons.alternate_email,color: Colors.purple,),

                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value){
                    if(value!.isEmpty){

                      return " Please Enter Email";

                    }
                    return null;

                  },
                  controller:emailcontroller ,
                ),

                SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller:passwordcontroller,
                  obscureText: true,
                  decoration:const InputDecoration(

                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock_open),

                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Enter Password";
                    }
                    return null;

                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 50,),
          Roundbutton(title: "Singup",
            loading: loading,
            onTap:(){
            if(_formfield.currentState!.validate())
              {
                Singup();
              }

            },
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?"),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>login_screen()));
              }, child:Text("Login"))
            ],
          ),
        ],
      ),
    );
  }








}
