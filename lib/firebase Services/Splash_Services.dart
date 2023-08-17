


import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynew/firestore/fire_store_list_screen.dart';
import 'package:mynew/ui/auth/login_screen.dart';
import 'package:mynew/ui/images/upload_images.dart';
import 'package:mynew/ui/post/post_screen.dart';

class SplashServices{






  void islogin(BuildContext context){

  final auth=FirebaseAuth.instance;
  final user=  auth.currentUser;

  if(user!=null)
  {

    Timer.periodic(Duration(seconds: 6), (timer) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>post_Screen()));

    });
  }
else{

    Timer.periodic(Duration(seconds: 6), (timer) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>login_screen()));

    });

  }




  }

}