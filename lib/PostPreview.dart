import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
class PostPreview extends StatefulWidget {
  String name;
  String description;
  String position;
  File? image;
  PostPreview({required this.image,required this.description,required this.name,required this.position});

  @override
  State<PostPreview> createState() => _PostPreviewState();
}

class _PostPreviewState extends State<PostPreview> {
  bool isLoading=false;
  File? _image;
  String? downloadurl;
  final String date='${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';

  @override
  Widget build(BuildContext context) {
    final submitButton = Material(
      elevation: 9,
      borderRadius: BorderRadius.circular(50),
      color: const Color(0xFF536C71),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFF2b38b8)
        ),
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width*0.9,
            onPressed: () async{
              if(_validate(name:widget.name, description: widget.description, image: widget.image)){
                setState(() {
                  isLoading=true;
                });
                try{
                  Reference ref=FirebaseStorage.instance.ref().child("Posts/images")
                      .child('${widget.name} ${DateTime.now().millisecondsSinceEpoch}');
                  await ref.putFile(widget.image!);
                  downloadurl=await ref.getDownloadURL();
                  Fluttertoast.showToast(msg: "Image Uploaded Sucessfully!");
                  FirebaseFirestore firebaseFirestore2 = FirebaseFirestore.instance;
                  await firebaseFirestore2.collection('Posts').doc('${widget.name.trim()} ${DateTime.now().millisecondsSinceEpoch}').set(
                      {
                        'Name':widget.name.trim(),
                        'Date':date,
                        'Position':widget.position,
                        'Description':widget.description,
                        'Time':'${DateTime.now().hour}:${DateTime.now().minute}',
                        'Image':downloadurl,
                      },SetOptions(merge: true)
                  ).then((value){
                    Fluttertoast.showToast(msg: 'Post Added Successfully');
                    Navigator.pop(context);
                  });
                }catch(e){
                  print('$e');
                  Fluttertoast.showToast(msg: 'Something Went Wrong!!!');
                }
              };
            },
            child: const Text(
              "Add Post",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16,fontFamily:'Poppins'),
            )
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Post Preview',style: TextStyle(fontSize: 18,fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFF2B38B8),
        centerTitle: true,
        elevation: 5,
        toolbarHeight: 80,
      ),
      body:SafeArea(
        child: isLoading?
        Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ):
        Container(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.4,
                    child:Image.file(
                      widget.image!,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.4,
                    alignment: widget.position=='topLeft'? Alignment.topLeft
                        :widget.position=='topRight'? Alignment.topRight
                        :widget.position=='bottomLeft'? Alignment.bottomLeft
                        :widget.position=='bottomRight'? Alignment.bottomRight
                        :Alignment.center,
                    padding: EdgeInsets.only(left: 50,right: 50,top: 10,bottom: 10),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              submitButton
            ],
          ),
        ),
      ),
    );
  }

  bool _validate({required String name,required String description,required File? image}) {
    if (image==null) {
      Fluttertoast.showToast(msg: 'Please Select Profile Picture');
      return false;
    }else if (name.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your Name');
      return false;
    }else if (description.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your Middle Name');
      return false;
    }else if (name.length < 2) {
      Fluttertoast.showToast(msg: 'Name Must Contains 2 Characters');
      return false;
    }else if (description.length < 2) {
      Fluttertoast.showToast(msg: 'Name Must Contains 2 Characters');
      return false;
    }else {
      return true;
    }
  }
}
