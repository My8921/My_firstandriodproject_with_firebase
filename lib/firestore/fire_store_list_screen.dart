import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:mynew/firestore/add_FireStore_Data.dart';
import 'package:mynew/ui/auth/login_screen.dart';

import 'package:mynew/utils/utils.dart';

class fireStoreScreen extends StatefulWidget {
  const fireStoreScreen({super.key});

  @override
  State<fireStoreScreen> createState() => _fireStoreScreenState();
}

class _fireStoreScreenState extends State<fireStoreScreen> {
  final auth= FirebaseAuth.instance;
  final firestore=FirebaseFirestore.instance.collection('users').snapshots();

  final editcontroller=TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Fire Store"),

        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){

              Navigator.push(context, MaterialPageRoute(builder:(context) => login_screen()));

            }).onError((error, stackTrace) {
              Utils().Message(error.toString());


            });
          }, icon:Icon(Icons.login_outlined)),
          SizedBox(width: 10,)
        ],),
      body: Column(
        children: [
          SizedBox(height: 10,),
StreamBuilder<QuerySnapshot>(
    stream: firestore,
    builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
if(snapshot.connectionState==ConnectionState.waiting)
  {
    return CircularProgressIndicator();
  }

if(snapshot.hasError)
  {
    return Text("Some error");
  }
return    Expanded(

  child:ListView.builder(
      itemCount:snapshot.data!.docs.length,
      itemBuilder: (context,index){
        return ListTile(
          title: Text(snapshot.data!.docs[index]['title'].toString()),

        );
      }),
);
}),
        ],
      ),
      floatingActionButton:FloatingActionButton(

        onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder:(context)=> FirestoreScreen() ));

        }, child:Icon(Icons.add),
      ),

    );
  }


  Future<void>ShowMyDialog(String title,String id)async{

    editcontroller.text=title;
    return showDialog(context: context,
        builder:(BuildContext context ){
          return AlertDialog(
            title: Text("Update"),
            content: Container(
              child: TextField(
                controller: editcontroller,
                decoration: InputDecoration(
                    hintText: "Edit Here"
                ),
              ),
            ),
            actions: [

              TextButton(onPressed: (){
                Navigator.pop(context);

              }, child: Text("Cancel")),
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Update"))

            ],
          );
        });
  }


}
