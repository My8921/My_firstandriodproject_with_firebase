import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Roundbutton extends  StatelessWidget{

   final String title;
 final VoidCallback onTap;
 bool loading;

   Roundbutton({Key ? key,required this.title,this.loading=false,
  required this.onTap}):super(key: key);

  @override
  Widget build(BuildContext context) {


    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 50,
          decoration: BoxDecoration(

            color: Colors.purple,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child:loading? CircularProgressIndicator(strokeWidth:3, color: Colors.white,)  : Text(title,style: TextStyle(color: Colors.white),),),
        ),
      ),

    );
  }











}