import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mynew/Widgets/Roundbutton.dart';
import 'package:mynew/utils/utils.dart';

class add_postscreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return S2();
  }
}

class S2 extends State<add_postscreen>{
  bool loading=false;
  final postcontroller=TextEditingController();
  final ali=FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Add Post"),
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

ali.child(id).set(
{
  'id':id,
  'title':postcontroller.text.toString()
}
).then((value) {
Utils().Message('Post Added');
setState(() {
  loading=false;
});

}).onError((error, stackTrace){
  Utils().Message(error.toString());
  setState(() {
    loading=false;
  });
});
          })
        ],
      ),
    ),
  );

  }

}