import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  String dialCodeDigits='+91';

  bool isLoading=false;

  final TextEditingController _phoneController=TextEditingController();

  final TextEditingController _Namecontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final numberField = TextFormField(
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16,fontFamily:'Poppins'),
        autofillHints: const [AutofillHints.telephoneNumberNational],
        autofocus: false,
        controller: _phoneController,
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
          _phoneController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          hintText: "Mobile Number",
          hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 16
          ),
        )
    );
    final nameField = TextFormField(
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16,fontFamily:'Poppins'),
        autofillHints: const [AutofillHints.telephoneNumberNational],
        autofocus: false,
        controller: _Namecontroller,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your name");
          }
          if (value.length < 2) {
            return ("invalid name");
          }
          return null;
        },
        onSaved: (value) {
          _Namecontroller.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          //border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          hintText: "User Name",
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
              if (_validate(mobile:_phoneController.text,name: _Namecontroller.text)){
                //await SharedPref.saveUserPhoneNumSharedPreference('$dialCodeDigits${_phoneController.text}');
                setState(() {
                  isLoading=true;
                });
                FirebaseFirestore firebaseFirestore2 = FirebaseFirestore.instance;
                var a = await firebaseFirestore2.collection('users').doc('$dialCodeDigits${_phoneController.text}').get();
                if(a.exists){
                  setState(() {
                    isLoading=false;
                  });
                  //print('Exists');
                  Fluttertoast.showToast(msg: "User with this number already exist!!!");
                }
                if(!a.exists){
                  //print('Not exists');
                  await firebaseFirestore2.collection('users').doc('$dialCodeDigits${_phoneController.text}').set(
                      {
                        'MobileNumber':'$dialCodeDigits${_phoneController.text}',
                        'Name':'${_Namecontroller.text}',
                        'Profile':'Not Done'
                      }).then((value){
                    Fluttertoast.showToast(msg: 'User Added Successfully');
                    Navigator.pop(context);
                  });
                }
              }
            },
            child: const Text(
              "Add User",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16,fontFamily:'Poppins'),
            )
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Add User',style: TextStyle(fontSize: 18,fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFF2B38B8),
        centerTitle: true,
        elevation: 5,
        toolbarHeight: 80,
      ),
      body: isLoading?Container(
        //margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ):SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
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
                      height: 60,
                      child: CountryCodePicker(
                        onChanged: (country){
                          setState(() {
                            dialCodeDigits=country.dialCode!;
                          });
                        },
                        initialSelection: 'IN',
                        showCountryOnly: false,
                        showDropDownButton: true,
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
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                child: nameField,
              ),
              const SizedBox(
                height: 40,
              ),
              submitButton
            ],
          ),
        ),
      ),
    );
  }
  bool _validate({required String mobile,required String name}) {
    if (mobile.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter User Mobile Number');
      return false;
    } else if (name.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter User Name');
      return false;
    }else if (mobile.length < 10) {
      Fluttertoast.showToast(msg: 'Mobile number Must Contains 10 Characters');
      return false;
    } else if (name.length < 2) {
      Fluttertoast.showToast(msg: 'Name Must Contains 2 Characters');
      return false;
    } else {
      return true;
    }
  }
}
