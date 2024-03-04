import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kp_admin/PostPreview.dart';
import 'Posts.dart';
class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _namecontroller=TextEditingController();
  final TextEditingController _descriptioncontroller=TextEditingController();
  bool isLoading=false;
  File? _image;
  final imagepicker=ImagePicker();
  String? downloadurl;
  final String date='${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
  List<String> _Position = <String>[
    'center',
    'topLeft',
    'topRight',
    'bottomLeft',
    'bottomRight',
  ];
  var selectedPosition;
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
    final descriptionField = TextFormField(
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16,fontFamily:'Poppins'),
        autofocus: false,
        controller: _descriptioncontroller,
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
          _descriptioncontroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        maxLines: 2,
        decoration: const InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          filled: true,
          fillColor: Colors.white,
          hintText: "Enter Description",
          labelText: "Description",
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
              if(_validate(name:_namecontroller.text, description: _descriptioncontroller.text, image: _image,position: selectedPosition)){
                setState(() {
                  isLoading=true;
                });
                try{
                  Reference ref=FirebaseStorage.instance.ref().child("Posts/images")
                      .child('${_namecontroller.text} ${DateTime.now().millisecondsSinceEpoch}');
                  await ref.putFile(_image!);
                  downloadurl=await ref.getDownloadURL();
                  Fluttertoast.showToast(msg: "Image Uploaded Sucessfully!");
                  FirebaseFirestore firebaseFirestore2 = FirebaseFirestore.instance;
                  await firebaseFirestore2.collection('Posts').doc('${_namecontroller.text.trim()} ${DateTime.now().millisecondsSinceEpoch}').set(
                      {
                        'Name':_namecontroller.text.trim(),
                        'Date':date,
                        'Description':_descriptioncontroller.text,
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
    final previewButton = Material(
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
              if(_validate(name:_namecontroller.text, description: _descriptioncontroller.text, image: _image,position: selectedPosition)){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PostPreview(
                    image: _image,
                    description: _descriptioncontroller.text,
                    name: _namecontroller.text,
                    position: selectedPosition)));
              };
            },
            child: const Text(
              "Preview",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16,fontFamily:'Poppins'),
            )
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Add Post',style: TextStyle(fontSize: 18,fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFF2B38B8),
        centerTitle: true,
        elevation: 5,
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child: isLoading?
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.4),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ):
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      imagepick();
                    },
                    child:  _image==null? Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      height: MediaQuery.of(context).size.height*0.3,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 2)
                      ),
                      child: Center(
                        child: Icon(Icons.image),
                      ),
                    ):Image.file(_image!,width: MediaQuery.of(context).size.width*0.89,height: MediaQuery.of(context).size.height*0.29,),
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
                    child: descriptionField,
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    color: Colors.white,
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          items: _Position
                              .map((value) =>DropdownMenuItem(
                            child:Text(
                              value,
                              style: const TextStyle(color: Colors.black,fontSize: 15,fontFamily:'Poppins',fontWeight: FontWeight.bold),
                            ),
                            value: value,
                          )).toList(),
                          onChanged:(selecteditem){
                            setState(() {
                              selectedPosition=selecteditem;
                            });
                            print('$selectedPosition');
                          },
                          value: selectedPosition,
                          isExpanded: false,
                          hint: const Text('Profile Position',style: TextStyle(fontFamily: 'Poppins'),),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20,),
              //submitButton,
              previewButton
            ],
          ),
        ),
      ),
    );
  }
  bool _validate({required String name,required String description,required File? image,required var position}) {
    if (image==null) {
      Fluttertoast.showToast(msg: 'Please Select Profile Picture');
      return false;
    }else if (name.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your Name');
      return false;
    }else if (description.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your Middle Name');
      return false;
    }else if (position==null) {
      Fluttertoast.showToast(msg: 'Please Select Your BloodGroup');
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

