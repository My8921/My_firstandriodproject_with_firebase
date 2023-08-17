import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynew/firebase%20Services/Splash_Services.dart';

class Splash_Screen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return S1();

  }

}

class  S1 extends State<Splash_Screen>
{
  SplashServices splashScreen=SplashServices();





  @override
  void initState() {

    super.initState();
    splashScreen.islogin(context);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

body: Container(
  color:Colors.purple,
  child:   Center(

    child: Text("Welcome to the Firebase",style: TextStyle(fontSize: 30,color:Colors.white),),

  ),
),

    );

  }



}
