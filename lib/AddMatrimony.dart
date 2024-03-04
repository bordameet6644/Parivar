import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
class AddMatrimony extends StatefulWidget {
  String gender;
  AddMatrimony({required this.gender});

  @override
  State<AddMatrimony> createState() => _AddMatrimonyState();
}

class _AddMatrimonyState extends State<AddMatrimony> {
  String dialCodeDigits='+91';
  final TextEditingController _numbercontroller=TextEditingController();
  final TextEditingController _namecontroller=TextEditingController();
  final TextEditingController _surnamecontroller=TextEditingController();
  final TextEditingController _middlenamecontroller=TextEditingController();
  final TextEditingController _villagecontroller=TextEditingController();
  bool isLoading=false;
  String default_gender_choice='Male';
  int default_gender_index=0;
  String default_marrige_choice='Unmarried';
  int default_marrige_index=0;
  final List<String> _occupation = <String>[
    'Business',
    'Job',
    'Student',
    'Retired',
    'House Wife'
  ];
  final List<String> _BloodGroups = <String>[
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];
  var selectedSubOccupation, selectedOccupation , selectedBloodGroup;
  late DateTime date=DateTime(DateTime.now().day,DateTime.now().month,DateTime.now().year);
  File? _image;
  final imagepicker=ImagePicker();
  String? downloadurl;

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = [];
    String temp = "";
    for (int i = 0; i < caseNumber.length; i++) {
      temp = temp + caseNumber[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }


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
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          filled: true,
          fillColor: Colors.white,
          labelText: "SurName",
          hintText: "Enter SurName",
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
    final middlenameField = TextFormField(
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16,fontFamily:'Poppins'),
        autofocus: false,
        controller: _middlenamecontroller,
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
          _middlenamecontroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          filled: true,
          fillColor: Colors.white,
          labelText: "Middle Name",
          hintText: "Enter MiddleName",
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
          // reg expression for email validation
          if (value.length <= 2) {
            return ("Please Enter Valid VillageName");
          }
          return null;
        },
        onSaved: (value) {
          _villagecontroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          filled: true,
          fillColor: Colors.white,
          labelText: "Village Name",
          hintText: "Enter Village Name",
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
    final numberField = TextFormField(
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16,fontFamily:'Poppins'),
        autofillHints: const [AutofillHints.telephoneNumberNational],
        autofocus: false,
        controller: _numbercontroller,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your mobile number");
          }
          // reg expression for email validation
          if (value.length != 10) {
            return ("Mobile Number must be of 10 digit");
          }
          return null;
        },
        onSaved: (value) {
          _numbercontroller.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          labelText: "Mobile Number",
          hintText: "Mobile Number",
          hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 16
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
              if(_validate(name: _namecontroller.text, middleName: _middlenamecontroller.text, lastName: _surnamecontroller.text, number: _numbercontroller.text,village: _villagecontroller.text, occupation: selectedOccupation, subOccupation: selectedSubOccupation,image: _image)){
                setState(() {
                  isLoading=true;
                });
                try{
                  Reference ref=FirebaseStorage.instance.ref().child("Matrimony/${widget.gender}/images")
                      .child('${_namecontroller.text.trim()} ${_middlenamecontroller.text.trim()} ${_surnamecontroller.text.trim()}');
                  await ref.putFile(_image!);
                  downloadurl=await ref.getDownloadURL();
                  Fluttertoast.showToast(msg: "Image Uploaded Sucessfully!");
                  FirebaseFirestore firebaseFirestore2 = FirebaseFirestore.instance;
                  await firebaseFirestore2.collection('Matrimony').doc('${widget.gender}').collection('${widget.gender}').doc('${_namecontroller.text.trim()} ${_middlenamecontroller.text.trim()} ${_surnamecontroller.text.trim()}').set(
                      {
                        'Name':_namecontroller.text.trim(),
                        'Age':'${DateTime.now().year-date.year}',
                        'MiddleName':_middlenamecontroller.text.trim(),
                        'SurName':_surnamecontroller.text.trim(),
                        'Village':_villagecontroller.text,
                        'BirthDate':'${date.day}/${date.month}/${date.year}',
                        'Occupation':selectedOccupation,
                        'SubOccupation':selectedSubOccupation,
                        'PhoneNumber':'$dialCodeDigits${_numbercontroller.text}',
                        'ProfilePicture':downloadurl,
                        'FullName':'${_namecontroller.text.trim()} ${_middlenamecontroller.text.trim()} ${_surnamecontroller.text.trim()}',
                      },SetOptions(merge: true)
                  ).then((value)async{
                    Fluttertoast.showToast(msg: 'Person Added Successfully');
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
        title: Text('Add ${widget.gender}',style: TextStyle(fontSize: 18,fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFF2B38B8),
        centerTitle: true,
        elevation: 5,
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:isLoading?
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
                      const AssetImage(
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
                    child: middlenameField,
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
                    child: villageField,
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 130,
                      height: 50,
                      child: CountryCodePicker(
                        onChanged: (country){
                          setState(() {
                            dialCodeDigits=country.dialCode!;
                          });
                        },
                        initialSelection: 'IN',
                        showCountryOnly: false,
                        showDropDownButton: false,
                        showOnlyCountryWhenClosed:false,
                        textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.black
                        ),
                        dialogSize:Size(MediaQuery.of(context).size.width*0.7, MediaQuery.of(context).size.height*0.5),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width*0.45,
                        child: numberField
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 30,),
                  const Text(
                    'Birth Date:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily:'Poppins'

                    ),
                  ),
                  const SizedBox(width: 30,),
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width*0.58,
                    color: Color(0xFF2B38B8),
                    onPressed:(){
                      pickDate(context);
                    },
                    child:Text('${getText()}',style: TextStyle(fontFamily:'Poppins',color: Colors.white),),
                  )
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
                          items: _occupation
                              .map((value) =>DropdownMenuItem(
                            child:Text(
                              value,
                              style: const TextStyle(color: Colors.black,fontSize: 15,fontFamily:'Poppins',fontWeight: FontWeight.bold),                            ),
                            value: value,
                          )).toList(),
                          onChanged:(selecteditem){
                            print('$selecteditem');
                            setState(() {
                              selectedOccupation=selecteditem;
                            });
                            print('$selectedOccupation');
                          },
                          value: selectedOccupation,
                          isExpanded: false,
                          hint: const Text('Occupation',style: TextStyle(fontFamily: 'Poppins'),),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Suboccupation').snapshots(),
                  builder:(context,snapshot){
                    if(!snapshot.hasData){
                      return const CircularProgressIndicator();
                    }
                    else{
                      List<DropdownMenuItem> suboccupation = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data!.docs[i];
                        suboccupation.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.id,
                              style: const TextStyle(color: Colors.black,fontSize: 15,fontFamily:'Poppins',fontWeight: FontWeight.bold),
                            ),
                            value: "${snap.id}",
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:<Widget> [
                          Container(
                            width: MediaQuery.of(context).size.width*0.9,
                            color: Colors.white,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<dynamic>(
                                  items: suboccupation,
                                  onChanged: (currencyValue) {
                                    /*final snackBar = SnackBar(
                                      content: Text(
                                        'Selected Currency value is $currencyValue',
                                        style: TextStyle(color: Color(0xff11b719)),
                                      ),
                                    );*/
                                    //Scaffold.of(context).showSnackBar(snackBar);
                                    setState(() {
                                      selectedSubOccupation = currencyValue;
                                    });
                                    print('$selectedSubOccupation');
                                  },
                                  value: selectedSubOccupation,
                                  isExpanded: false,
                                  hint: const Text(
                                    "Sub-Occupation",style: TextStyle(fontFamily: 'Poppins'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }
              ),
              const SizedBox(height: 10,),
              submitButton,
              const SizedBox(height: 20,),
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
  bool _validate({required String name,required String middleName,required String lastName,required String village,required String number,required var occupation,required var subOccupation,required File? image}) {
    if (image==null) {
      Fluttertoast.showToast(msg: 'Please Select Profile Picture');
      return false;
    }else if (name.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your Name');
      return false;
    }else if (middleName.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your Middle Name');
      return false;
    }else if (lastName.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your Sur Name');
      return false;
    }else if (village.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your Village');
      return false;
    }else if (number.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your PhoneNumber');
      return false;
    }else if (occupation==null) {
      Fluttertoast.showToast(msg: 'Please Select Your occupation');
      return false;
    }else if (subOccupation==null) {
      Fluttertoast.showToast(msg: 'Please Select Your subOccupation');
      return false;
    }else if (name.length < 2) {
      Fluttertoast.showToast(msg: 'Name Must Contains 2 Characters');
      return false;
    }else if (middleName.length < 2) {
      Fluttertoast.showToast(msg: 'Name Must Contains 2 Characters');
      return false;
    }else if (lastName.length < 2) {
      Fluttertoast.showToast(msg: 'Name Must Contains 2 Characters');
      return false;
    }else if (village.length < 2) {
      Fluttertoast.showToast(msg: 'Name Must Contains 2 Characters');
      return false;
    }else {
      return true;
    }
  }
}

