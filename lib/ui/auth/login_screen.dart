

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mynew/Widgets/Roundbutton.dart';
import 'package:mynew/ui/Forget_Password.dart';
import 'package:mynew/ui/auth/login_with_phone_number.dart';
import 'package:mynew/ui/auth/signup_screen.dart';
import 'package:mynew/ui/post/post_screen.dart';
import 'package:mynew/utils/utils.dart';

class login_screen extends StatefulWidget{




  @override
  State<StatefulWidget> createState() {

    return S2();
  }
}

class S2 extends State<login_screen>{
  final _formfield=GlobalKey<FormState>();
  final emailcontroller=TextEditingController();
  final passwordcontroller=TextEditingController();
 final _auth=FirebaseAuth.instance;

 bool loading=false;


 void login(){

   setState(() {
     loading=true;
   });

   _auth.signInWithEmailAndPassword(email: emailcontroller.text.toString(), password:passwordcontroller.text.toString()).then((value) {

     Utils().Message(value.user!.email.toString());
     Navigator.push(context, MaterialPageRoute(builder: (context)=>post_Screen()));

     setState(() {
       loading=false;
     });


   }).onError((error, stackTrace) {

     Utils().Message(error.toString());

     setState(() {
       loading=false;
     });

   });
 }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {


    return WillPopScope(
onWillPop: ()async{

  SystemNavigator.pop();
  return true;
},

      child: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
body: Center(
  child:   SingleChildScrollView(
  
    child:   Column(
  
      mainAxisAlignment: MainAxisAlignment.center,
  
    
  
      children: [
  
    
  
    Form(key: _formfield,
  
    
  
    child: Column(
  
      children: [
  
    
  
    
  
    
  
    
  
    
  
    
  
    
  
          TextFormField(
  
    
  
    
  
    
  
    
  
    
  
    
  
    
  
    
  
    
  
    
  
    
  
    
  
    
  
    
  
    
  
    
  
    
  
    
  
    
  
    
  
    
  
    
  
    
  
            decoration:const InputDecoration(
  
    
  
              hintText: "Email",
  
    
  
              prefixIcon: Icon(Icons.alternate_email),
  
    
  
    
  
    
  
            ),
  
    
  
    
  
    
  
    
  
    
  
    
  
    
  
            keyboardType: TextInputType.emailAddress,
  
    
  
    
  
    
  
            validator: (value){
  
    
  
    if(value!.isEmpty){
  
    
  
      return " Please Enter Email";}
  
    
  
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
  
    
  
          Roundbutton(title: "Login",
  
    
  
            loading: loading,
  
    
  
            onTap:(){
  
    
  
    if(_formfield.currentState!.validate())
  
    
  
      {
  
    
  
        login();
  
    
  
      }
  
    
  
            },
  
    
  
          ),
  
        Align(
  
          alignment: Alignment.bottomRight,
  
          child: TextButton(onPressed: (){
  
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Forget_PasswordScreen()));
  
          }, child:Text("Forget Password?")),
  
        ),
  
          SizedBox(height: 30,),
  
          Row(
  
    
  
            mainAxisAlignment: MainAxisAlignment.center,
  
    
  
            children: [
  
    
  
              Text("Don't have an account?"),
  
    
  
              TextButton(onPressed: (){
  
    
  
                Navigator.push(context, MaterialPageRoute(builder: (context)=>signupscreen()));
  
    
  
              }, child:Text("Sign Up"))],
  
          ),
  
    
  
    
  
        SizedBox(height: 30,),
  
        InkWell(
  
          onTap: (){
  
            Navigator.push(context, MaterialPageRoute(builder: (context)=>loginwithphone()));
  
          },
  
          child: Container(
  
            height: 50,
  
            decoration: BoxDecoration(
  
    
  
              borderRadius: BorderRadius.circular(50),
  
              border: Border.all(
  
                color: Colors.black
  
              )
  
            ),
  
            child: Center(
  
              child: Text("Login with phone"),
  
            ),
  
          ),
  
        )
  
      ],
  
    
  
    ),
  
  ),
),
      ),
    );
  }








}
