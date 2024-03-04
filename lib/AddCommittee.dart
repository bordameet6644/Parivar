import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
class AddCommittee extends StatefulWidget {
  @override
  State<AddCommittee> createState() => _AddCommitteeState();
}

class _AddCommitteeState extends State<AddCommittee> {
  final TextEditingController _namecontroller=TextEditingController();
  final TextEditingController _surnamecontroller=TextEditingController();
  final TextEditingController _placecontroller=TextEditingController();
  final TextEditingController _villagecontroller=TextEditingController();
  File? _image;
  final imagepicker=ImagePicker();
  String? downloadurl;
  bool isLoading=false;

  Future imagepick() async{
    final pick= await imagepicker.pickImage(source:ImageSource.gallery);
    if(pick !=null){
      _image=File(pick.path);
      setState(() {});
    }
    else{
      Fluttertoast.showToast(msg: 'No Profile Pic Selected!!!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16,fontFamily:'Poppins'),
        autofocus: false,
        controller: _namecontroller,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Name");
          }
          // reg expression for email validation
          if (value.length <= 2) {
            return ("Please Enter Valid Name");
          }
          return null;
        },
        onSaved: (value) {
          _namecontroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          filled: true,
          fillColor: Colors.white,
          hintText: "Enter Name",
          labelText: "Name",
          hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 16
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 0,color: Color(0xFFF7F8F9)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1,color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1,color: Colors.white),
          ),
        )
    );
    final surnameField = TextFormField(
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16,fontFamily:'Poppins'),
        autofocus: false,
        controller: _surnamecontroller,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your SurName");
          }
          // reg expression for email validation
          if (value.length <= 2) {
            return ("Please Enter Valid SurName");
          }
          return null;
        },
        onSaved: (value) {
          _surnamecontroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          filled: true,
          fillColor: Colors.white,
          hintText: "Enter SurName",
          labelText: "Sur Name",
          hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 16
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 0,color: Color(0xFFF7F8F9)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1,color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1,color: Colors.white),
          ),
        )
    );
    final placeField = TextFormField(
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16,fontFamily:'Poppins'),
        autofocus: false,
        controller: _placecontroller,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your MiddleName");
          }
          // reg expression for email validation
          if (value.length <= 2) {
            return ("Please Enter Valid MiddleName");
          }
          return null;
        },
        onSaved: (value) {
          _placecontroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          filled: true,
          fillColor: Colors.white,
          hintText: "Enter Place",
          labelText: 'Place',
          hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 16
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 0,color: Color(0xFFF7F8F9)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1,color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1,color: Colors.white),
          ),
        )
    );
    final villageField = TextFormField(
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16,fontFamily:'Poppins'),
        autofocus: false,
        controller: _villagecontroller,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your VillageName");
          }
          if (value.length <= 2) {
            return ("Please Enter Valid VillageName");
          }
          return null;
        },
        onSaved: (value) {
          _villagecontroller.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          filled: true,
          fillColor: Colors.white,
          hintText: "Enter Village Name",
          labelText: "Village Name",
          hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 16
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 0,color: Color(0xFFF7F8F9)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1,color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1,color: Colors.white),
          ),
        )
    );
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
              if(_validate(name:_namecontroller.text, surname: _surnamecontroller.text, village: _villagecontroller.text, place: _placecontroller.text, image: _image)){
                setState(() {
                  isLoading=true;
                });
                try{
                  Reference ref=FirebaseStorage.instance.ref().child("Committee/images")
                      .child('${_namecontroller.text} ${_surnamecontroller.text}');
                  await ref.putFile(_image!);
                  downloadurl=await ref.getDownloadURL();
                  Fluttertoast.showToast(msg: "Image Uploaded Sucessfully!");
                  FirebaseFirestore firebaseFirestore2 = FirebaseFirestore.instance;
                  await firebaseFirestore2.collection('committee').doc('${_namecontroller.text.trim()} ${_surnamecontroller.text.trim()}').set(
                      {
                        'Name':_namecontroller.text.trim(),
                        'SurName':_surnamecontroller.text.trim(),
                        'Place':_placecontroller.text.trim(),
                        'Village':_villagecontroller.text.trim(),
                        'ProfilePicture':downloadurl,
                      },SetOptions(merge: true)
                  ).then((value){
                    Fluttertoast.showToast(msg: 'Member Added Successfully');
                    Navigator.pop(context);
                  });
                }catch(e){
                  print('$e');
                  Fluttertoast.showToast(msg: 'Something Went Wrong!!!');
                }
              };
            },
            child: const Text(
              "SUBMIT",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16,fontFamily:'Poppins'),
            )
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Add Committee',style: TextStyle(fontSize: 18,fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFF2B38B8),
        centerTitle: true,
        elevation: 5,
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: isLoading?
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.4),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ):Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: (){
                  imagepick();
                },
                child: Center(
                  child: Container(
                    height: 90,
                    width: 90,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: _image==null?
                      AssetImage(
                        'assets/addimage-depositphotos-bgremover (1).png',
                      ):
                      FileImage(File(_image!.path)) as ImageProvider,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10,right:10),
                    width: MediaQuery.of(context).size.width*0.9,
                    child: nameField,
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10,right:10),
                    width: MediaQuery.of(context).size.width*0.9,
                    child: surnameField,
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10,right:10),
                    width: MediaQuery.of(context).size.width*0.9,
                    child: placeField,
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10,right:10),
                    width: MediaQuery.of(context).size.width*0.9,
                    child: villageField,
                  ),
                ],
              ),
              SizedBox(height: 15,),
              submitButton,
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
  bool _validate({required String name,required String surname,required String village,required String place,required File? image}) {
    if (image==null) {
      Fluttertoast.showToast(msg: 'Please Select Profile Picture');
      return false;
    }else if (name.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your Name');
      return false;
    }else if (surname.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your Middle Name');
      return false;
    }else if (village.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your Sur Name');
      return false;
    }else if (place.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your Sur Name');
      return false;
    }else if (name.length < 2) {
      Fluttertoast.showToast(msg: 'Name Must Contains 2 Characters');
      return false;
    }else if (surname.length < 2) {
      Fluttertoast.showToast(msg: 'Name Must Contains 2 Characters');
      return false;
    }else if (village.length < 2) {
      Fluttertoast.showToast(msg: 'Name Must Contains 2 Characters');
      return false;
    }else if (place.length < 2) {
      Fluttertoast.showToast(msg: 'Name Must Contains 2 Characters');
      return false;
    }else {
      return true;
    }
  }
}
