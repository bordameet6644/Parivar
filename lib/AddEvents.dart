import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
class AddEvents extends StatefulWidget {
  const AddEvents({Key? key}) : super(key: key);

  @override
  State<AddEvents> createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  final TextEditingController _namecontroller=TextEditingController();
  final TextEditingController _descriptioncontroller=TextEditingController();
  final TextEditingController _addresscontroller=TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  late DateTime date=DateTime(DateTime.now().day,DateTime.now().month,DateTime.now().year);
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

  String getText(){
    if(date==null){
      return '${DateTime.now().day}/${DateTime.now().day}';
    }
    else{
      return '${date.day}/${date.month}/${date.year}';
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
            return ("Please Enter Event Name");
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
          hintText: "Enter Event Name",
          labelText: "Event Name",
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
        maxLines: 4,
        decoration: const InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          filled: true,
          fillColor: Colors.white,
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
    final addressField = TextFormField(
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16,fontFamily:'Poppins'),
        autofocus: false,
        controller: _addresscontroller,
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
          _addresscontroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          filled: true,
          fillColor: Colors.white,
          hintText: "Enter Address",
          labelText: 'Address',
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
              if(_validate(name: _namecontroller.text, address: _addresscontroller.text, description: _descriptioncontroller.text, image: _image)){
                setState(() {
                  isLoading=true;
                });
                try{
                  Reference ref=FirebaseStorage.instance.ref().child("Events/images")
                      .child('${_namecontroller.text}');
                  await ref.putFile(_image!);
                  downloadurl=await ref.getDownloadURL();
                  Fluttertoast.showToast(msg: "Image Uploaded Sucessfully!");
                  FirebaseFirestore firebaseFirestore2 = FirebaseFirestore.instance;
                  await firebaseFirestore2.collection('Events').doc('${_namecontroller.text.trim()}').set(
                      {
                        'Name':_namecontroller.text.trim(),
                        'Address':_addresscontroller.text,
                        'Description':_descriptioncontroller.text,
                        'Photo':downloadurl,
                        'Time':"${selectedTime.hour}:${selectedTime.minute}",
                        'Date':'${date.day}/${date.month}/${date.year}',
                      },SetOptions(merge: true)
                  ).then((value){
                    Fluttertoast.showToast(msg: 'Profile Updated Successfully');
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
        title: const Text('Add Event',style: TextStyle(fontSize: 18,fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),),
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
                    height: MediaQuery.of(context).size.height*0.3,
                    width: MediaQuery.of(context).size.width*0.9,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: _image==null?
                      Icon(FontAwesome5.image,size: MediaQuery.of(context).size.height*0.1,):
                          Image.file(_image!)
                    )
                    /*CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: _image==null?
                      AssetImage(
                        'assets/addimage-depositphotos-bgremover (1).png',
                      ):
                      FileImage(File(_image!.path)) as ImageProvider,
                    ),*/
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
                    child: descriptionField,
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
                    child: addressField,
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 30,),
                  const Text(
                    'Event Date:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily:'Poppins'
                    ),
                  ),
                  const SizedBox(width: 30,),
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width*0.56,
                    color: Color(0xFF2B38B8),
                    onPressed:(){
                      pickDate(context);
                    },
                    child:Text('${getText()}',style: TextStyle(fontFamily:'Poppins',color: Colors.white),),
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(width: 30,),
                  const Text(
                    'Event Time:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily:'Poppins'
                    ),
                  ),
                  const SizedBox(width: 30,),
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width*0.56,
                    color: Color(0xFF2B38B8),
                    onPressed: () {
                      _selectTime(context);
                    },
                    child: Text("${selectedTime.hour}:${selectedTime.minute}",style: TextStyle(fontFamily:'Poppins',color: Colors.white),),
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
  Future pickDate(BuildContext context)async{
    final initialDate=DateTime.now();
    final newDate=await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year-100),
        lastDate: DateTime(DateTime.now().year+100)
    );
    if(newDate==null) return;
    setState(() {
      date=newDate;
    });
  }
  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
  bool _validate({required String name,required String address,required String description,required File? image}) {
    if (image==null) {
      Fluttertoast.showToast(msg: 'Please Select Profile Picture');
      return false;
    }else if (name.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your Name');
      return false;
    }else if (address.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your Middle Name');
      return false;
    }else if (description.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your Sur Name');
      return false;
    }else if (name.length < 2) {
      Fluttertoast.showToast(msg: 'Name Must Contains 2 Characters');
      return false;
    }else if (address.length < 2) {
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
