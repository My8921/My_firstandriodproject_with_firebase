import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mynew/Widgets/Roundbutton.dart';

import 'package:firebase_storage/firebase_storage.dart' as  firebase_storage;
import 'package:mynew/utils/utils.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {

  File? _image;
  final picker=ImagePicker();
  firebase_storage.FirebaseStorage Storage=firebase_storage.FirebaseStorage.instance;
  bool loading=false;
  final ali=FirebaseDatabase.instance.ref('images');

  Future getImageGallery ()async{

    final pickedfile=await picker.pickImage(source:ImageSource.gallery,imageQuality: 80);

    setState(() {
      if(pickedfile!=null)
      {
        _image=File(pickedfile.path);

      }});


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Uplaod image"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: (){
getImageGallery();

                },
                child: Container(
                  height: 200,
                  width: 200,
decoration: BoxDecoration(
  border: Border.all(
    color: Colors.black,
  )
),
                  child: Center(child:_image!=null? Image.file(_image!.absolute) :Icon(Icons.image,size: 45,)
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Roundbutton(title:'Upload',loading: loading, onTap:() async{

              setState(() {
                loading=true;
              });
             firebase_storage.Reference ref=firebase_storage.FirebaseStorage.instance.ref('/foldername/'+DateTime.now().microsecondsSinceEpoch.toString());
             firebase_storage.UploadTask uploadtask=ref.putFile(_image!.absolute);

             Future.value(uploadtask).then((value) async{

               var newurl= await ref.getDownloadURL();

               ali.child('1').set({

                 'id':'122',
                 'path':newurl.toString(),

               }).then((value) {

                 setState(() {
                   loading=false;
                 });


                 Utils().Message("Image uploaded Successfully");

               }).onError((error, stackTrace) {

                 setState(() {
                   loading=false;
                 });
                 Utils().Message(error.toString());



               });






             }).onError((error, stackTrace) {
setState(() {
  loading=false;
});

             });



            }),



          ],
        ),
      ),
    );
  }
}
