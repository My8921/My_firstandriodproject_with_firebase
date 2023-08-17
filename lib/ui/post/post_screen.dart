

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynew/ui/auth/login_screen.dart';
import 'package:mynew/ui/post/add_posts.dart';
import 'package:mynew/utils/utils.dart';

class post_Screen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return S2();
  }

}

class S2 extends State<post_Screen>{
  final auth= FirebaseAuth.instance;
final ref=FirebaseDatabase.instance.ref('Post');
final searchcontroller=TextEditingController();
  final editcontroller=TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Post Screen"),

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
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child:   TextFormField(
    controller: searchcontroller,

    decoration: InputDecoration(

      hintText: 'Search',

  border: OutlineInputBorder()

    ),
onChanged:(String value){
      setState(() {

      });
},
  ),
),
          Expanded(
            child: FirebaseAnimatedList(query:ref,

 itemBuilder:(context,snapshot,animation,index)
 {
   final titles= snapshot.child('title').value.toString();

if(searchcontroller.text.isEmpty)
  {
    return ListTile(

      title: Text(snapshot.child('title').value.toString()),
      trailing:PopupMenuButton(
        icon:Icon(Icons.more_vert),
        itemBuilder: (context)=>[
          PopupMenuItem(

value: 1,
              child:ListTile(
                onTap: (){
                 Navigator.pop(context);
                  ShowMyDialog(titles,snapshot.child('id').value.toString());
                },
                leading: Icon(Icons.edit),
                title: Text("Edit"),)
          ),
          PopupMenuItem(
              value: 2,
              child:ListTile(
                onTap: (){
                  Navigator.pop(context);
                  ref.child(snapshot.child('id').value.toString()).remove();
                },
                leading: Icon(Icons.delete),
                title: Text("Delete"),)
          ),

        ],
      ),
    );
  }
else if(titles.toLowerCase().contains(searchcontroller.text.toLowerCase()))
{//Sara ka Sara Search Controller kahi bhi title mai arha hai
  return ListTile(

    title: Text(snapshot.child('title').value.toString()),
  );

}
else{
  return Container();
}
               }
               ),
          ),

        ],
      ),
      floatingActionButton:FloatingActionButton(

onPressed: (){

Navigator.push(context, MaterialPageRoute(builder:(context)=> add_postscreen() ));

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
                ref.child(id).update({
                  'title':editcontroller.text.toString(),
                }).then((value) {

                  Utils().Message("Updated Succesfully");
                }).onError((error, stackTrace) {
                  Utils().Message(error.toString());

                });
                Navigator.pop(context);
              }, child: Text("Update"))

            ],
          );
        });
  }




}

