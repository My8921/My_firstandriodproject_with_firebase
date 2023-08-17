
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynew/Widgets/Roundbutton.dart';
import 'package:mynew/ui/auth/verify_code.dart';
import 'package:mynew/utils/utils.dart';

class loginwithphone extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return S2();
  }

}
class S2 extends State<loginwithphone>{
  final numbercontroller=TextEditingController();
  bool loading=false;
  final auth=FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(

  title: Text("Login"),
),

      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            SizedBox(height:80,),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: numbercontroller,
              decoration: InputDecoration(
                hintText: "+1 234 3455 234",
              ),
            ),
SizedBox(height: 80,),

            Roundbutton(title: "Login",loading: loading  ,onTap:(){

              setState(() {
                loading=true;
              });


auth.verifyPhoneNumber(
    phoneNumber: numbercontroller.text,
    verificationCompleted:(_){

    },
    verificationFailed:(e){
      setState(() {
        loading=false;
      });
      Utils().Message(e.toString());


      },
    codeSent:(String verificationId,int? token){

      Navigator.push(context,MaterialPageRoute(builder:(context)=>verifycode(VerificationId: verificationId,)));
      setState(() {
        loading=false;
      });
    },
    codeAutoRetrievalTimeout:(e){

      setState(() {
        loading=false;
      });

    Utils().Message(e.toString()) ;
    }

);} ,),
          ],
        ),
      ),
    );
  }




}