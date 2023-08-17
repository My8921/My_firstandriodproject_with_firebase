import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';


import 'package:mynew/Widgets/Roundbutton.dart';
import 'package:mynew/utils/utils.dart';

class FirestoreScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return S2();
  }
}

class S2 extends State<FirestoreScreen>{
  bool loading=false;
  final postcontroller=TextEditingController();
final firestore=FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Fire Store Data"),
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextFormField(
              maxLines: 4,
              controller: postcontroller,
              decoration: InputDecoration(
                  hintText: "What is in your mind",
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 30,),
            Roundbutton(title:"Add" ,
                loading: loading,

                onTap: (){
                  setState(() {
                    loading=true;
                  });
String id=DateTime.now().microsecondsSinceEpoch.toString();


firestore.doc(id).set({

  'title':postcontroller.text.toString(),
  'id':id

}).then((value) {


    setState(() {
    loading=false;
    });
Utils().Message("Data is Added Successfully");

}).onError((error, stackTrace) {
  setState(() {
    loading=false;
  });

  Utils().Message(error.toString());

});}
            )

          ],
        ),
      ),
    );

  }

}