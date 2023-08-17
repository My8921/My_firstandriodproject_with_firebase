
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynew/Widgets/Roundbutton.dart';
import 'package:mynew/ui/post/post_screen.dart';
import 'package:mynew/utils/utils.dart';

class verifycode extends StatefulWidget{

  final String VerificationId;
  verifycode({Key? key,required this.VerificationId}):super(key: key);
  @override
  State<StatefulWidget> createState() {
    return S2();
  }

}
class S2 extends State<verifycode>{




  final numbercontroller=TextEditingController();
  bool loading=false;
  final auth=FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Verify"),
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
                hintText: "6 Digit Code",
              ),
            ),
            SizedBox(height: 80,),

            Roundbutton(title: "Verify",loading: loading  ,onTap:() async{

              setState(() {
                loading=true;
              });

              final credentials=PhoneAuthProvider.credential(verificationId:widget.VerificationId, smsCode:numbercontroller.text.toString());

              try{
                await auth.signInWithCredential(credentials);
                Navigator.push(context,MaterialPageRoute(builder: (context)=>post_Screen()));
              }catch(e){
                setState(() {
                  loading=false;
                });

                Utils().Message(e.toString());


              }


            }

             ),
          ],
        ),
      ),
    );
  }




}