import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kp_admin/Database/methods.dart';
import 'package:kp_admin/MatrimonyPage2.dart';
//import 'package:kathiriya_parivar/Screens/MatrimonyPage2.dart';

class Matrimony extends StatefulWidget {
  const Matrimony({Key? key}) : super(key: key);

  @override
  _MatrimonyState createState() => _MatrimonyState();
}

class _MatrimonyState extends State<Matrimony> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Matrimony',style: TextStyle(fontSize: 18,fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFF2B38B8),
        centerTitle: true,
        elevation: 5,
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child:Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MatrimonyPage2(gender:'Boy')));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.15,
                          width: MediaQuery.of(context).size.width*0.50,
                          decoration: BoxDecoration(
                            color: Color(0xFFDBDEF3),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                //offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //Icon(FontAwesome5.user_tie,size: 45,),
                              Image.asset(
                                'assets/Boy.png',
                                height: MediaQuery.of(context).size.height*0.1,
                              ),
                              SizedBox(height: 3,),
                              Text(
                                'Boy',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF2B38B8),
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              SizedBox(height: 30,),
              GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MatrimonyPage2(gender:'Girl')));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.15,
                          width: MediaQuery.of(context).size.width*0.50,
                          decoration: BoxDecoration(
                            color: Color(0xFFDBDEF3),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                //offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/girl.png',
                                height: MediaQuery.of(context).size.height*0.1,
                              ),
                              SizedBox(height: 3,),
                              Text(
                                'Girl',
                                style: TextStyle(
                                    fontSize: 19,
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF2B38B8),
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
            ],
          ),
        ),
      ),
    );
  }
}
