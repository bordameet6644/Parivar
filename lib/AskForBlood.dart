import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class AskForBlood extends StatefulWidget {
  const AskForBlood({Key? key}) : super(key: key);

  @override
  State<AskForBlood> createState() => _AskForBloodState();
}

class _AskForBloodState extends State<AskForBlood> {
  final TextEditingController _namecontroller=TextEditingController();
  final TextEditingController _surnamecontroller=TextEditingController();
  final TextEditingController _middlenamecontroller=TextEditingController();
  bool isLoading=false;
  List<String> _BloodGroups = <String>[
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];
  var selectedBloodGroup;
  late DateTime date=DateTime(DateTime.now().day,DateTime.now().month,DateTime.now().year);
  String getText(){
    if(date==null){
      return '${DateTime.now().day}/${DateTime.now().day}';
    }
    else{
      return '${date.day}/${date.month}/${date.year}';
    }
  }
  String dialCodeDigits='+91';
  final TextEditingController _numbercontroller=TextEditingController();

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
          hintText: "Enter MiddleName",
          labelText: 'Middle Name',
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
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          labelText: "Mobile Number",
          hintText: "Mobile Number",
          hintStyle: const TextStyle(
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
              if(_validate(name: _namecontroller.text, middleName: _middlenamecontroller.text, lastName: _surnamecontroller.text, number: _numbercontroller.text, bloodGroup:selectedBloodGroup)){
                setState(() {
                  isLoading=true;
                });
                try{
                  FirebaseFirestore firebaseFirestore2 = FirebaseFirestore.instance;
                  await firebaseFirestore2.collection('Blood Donate').doc('${_namecontroller.text.trim()} ${_middlenamecontroller.text.trim()} ${_surnamecontroller.text.trim()}').set(
                      {
                        'Name':_namecontroller.text.trim(),
                        'MiddleName':_middlenamecontroller.text.trim(),
                        'SurName':_surnamecontroller.text.trim(),
                        'Date':'${date.day}/${date.month}/${date.year}',
                        'BloodGroup':selectedBloodGroup,
                        'MobileNumber':'$dialCodeDigits${_numbercontroller.text}',
                      },SetOptions(merge: true)
                  ).then((value){
                    Fluttertoast.showToast(msg: 'Request Added Successfully');
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
          title: const Text('Ask For Blood',style: TextStyle(fontSize: 18,fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),),
          backgroundColor: Color(0xFF2B38B8),
          centerTitle: true,
          elevation: 5,
          toolbarHeight: 80,
        ),
        body:SafeArea(
          child: SingleChildScrollView(
            child:isLoading?
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.4),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ):Column(
              children: [
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10,right:10),
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
                      margin: EdgeInsets.only(left: 10,right:10),
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
                      width: MediaQuery.of(context).size.width*0.9,
                      child: surnameField,
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
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
                          textStyle: TextStyle(
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
                      'Date:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontFamily:'Poppins'

                      ),
                    ),
                    const SizedBox(width: 30,),
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width*0.7,
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
                            items: _BloodGroups
                                .map((value) =>DropdownMenuItem(
                              child:Text(
                                value,
                                style: const TextStyle(color: Colors.black,fontSize: 15,fontFamily:'Poppins',fontWeight: FontWeight.bold),
                              ),
                              value: value,
                            )).toList(),
                            onChanged:(selecteditem){
                              setState(() {
                                selectedBloodGroup=selecteditem;
                              });
                              print('$selectedBloodGroup');
                            },
                            value: selectedBloodGroup,
                            isExpanded: false,
                            hint: const Text('Blood Group',style: TextStyle(fontFamily: 'Poppins'),),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15,),
                submitButton,
                SizedBox(height: 20,),
              ],
            ),
          ),
        )
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
  bool _validate({required String name,required String middleName,required String lastName,required String number,required var bloodGroup}) {
    if (name.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your Name');
      return false;
    }else if (middleName.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your Middle Name');
      return false;
    }else if (lastName.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your Sur Name');
      return false;
    }else if (number.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Your PhoneNumber');
      return false;
    }else if (bloodGroup==null) {
      Fluttertoast.showToast(msg: 'Please Select Your BloodGroup');
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
    }else {
      return true;
    }
  }
}
