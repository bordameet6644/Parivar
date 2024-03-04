import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddOccupation extends StatefulWidget {
  const AddOccupation({Key? key}) : super(key: key);

  @override
  State<AddOccupation> createState() => _AddOccupationState();
}

class _AddOccupationState extends State<AddOccupation> {
  final TextEditingController _Namecontroller=TextEditingController();
  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16,fontFamily:'Poppins'),
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
          hintText: "Occupation",
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
              if (_validate(name: _Namecontroller.text)){
                setState(() {
                  isLoading=true;
                });
                FirebaseFirestore firebaseFirestore2 = FirebaseFirestore.instance;
                var a = await firebaseFirestore2.collection('Suboccupation').doc('${_Namecontroller.text}').get();
                if(a.exists){
                  setState(() {
                    isLoading=false;
                  });
                  Fluttertoast.showToast(msg: "Occupation already exist!!!");
                }
                if(!a.exists){
                  await firebaseFirestore2.collection('Suboccupation').doc('${_Namecontroller.text}').set(
                      {

                      }).then((value){
                    Fluttertoast.showToast(msg: 'Occupation Added Successfully');
                    Navigator.pop(context);
                  });
                }
              }
            },
            child: const Text(
              "Add",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16,fontFamily:'Poppins'),
            )
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Add Occupation',style: TextStyle(fontSize: 18,fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),),
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
                child: nameField,
              ),
              const SizedBox(
                height: 20,
              ),
              submitButton
            ],
          ),
        ),
      ),
    );
  }
  bool _validate({required String name}) {
    if (name.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Occupation');
      return false;
    }else if (name.length < 2) {
      Fluttertoast.showToast(msg: 'Occupation Must Contains 2 Characters');
      return false;
    } else {
      return true;
    }
  }
}
