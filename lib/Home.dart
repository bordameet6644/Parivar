import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kp_admin/FindMember.dart';
import 'package:kp_admin/Matrimony.dart';
import 'package:kp_admin/Posts.dart';
import 'package:kp_admin/committee.dart';
import 'AllUsers.dart';
import 'Events.dart';
import 'AddOccupation.dart';
import 'AddUser.dart';
import 'BloodDonate.dart';
import 'MainUsers.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Kathiyara Parivar',style: TextStyle(fontSize: 16,fontFamily: 'Poppins',color: Color(0xFF2B38B8),fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 5,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(30),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30
            ),
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddUser()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2B38B8),
                    image: DecorationImage(
                      opacity: 160,
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesome5.plus,size: MediaQuery.of(context).size.height*0.06,color: Colors.white,),
                          SizedBox(height: 10,),
                          Text(
                            'Add User',
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ],
                      )
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddOccupation()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2B38B8),
                    image: DecorationImage(
                      opacity: 160,
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesome5.briefcase,size: MediaQuery.of(context).size.height*0.06,color: Colors.white,),
                          SizedBox(height: 10,),
                          Text(
                            'Add Occupation',
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ],
                      )
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Committee()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2B38B8),
                    image: DecorationImage(
                      opacity: 160,
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesome5.award,size: MediaQuery.of(context).size.height*0.06,color: Colors.white,),
                          SizedBox(height: 10,),
                          Text(
                            'Add Committee',
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ],
                      )
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Events()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2B38B8),
                    image: DecorationImage(
                      opacity: 160,
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesome5.calendar_plus,size: MediaQuery.of(context).size.height*0.06,color: Colors.white,),
                          SizedBox(height: 10,),
                          Text(
                            'Add Events',
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ],
                      )
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> BloodDonate()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2B38B8),
                    image: DecorationImage(
                      opacity: 160,
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesome5.heart,size: MediaQuery.of(context).size.height*0.06,color: Colors.white,),
                          SizedBox(height: 10,),
                          Text(
                            'Ask For Blood',
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ],
                      )
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Posts()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2B38B8),
                    image: DecorationImage(
                      opacity: 160,
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesome5.edit,size: MediaQuery.of(context).size.height*0.06,color: Colors.white,),
                          SizedBox(height: 10,),
                          Text(
                            'Add Post',
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ],
                      )
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Matrimony()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2B38B8),
                    image: DecorationImage(
                      opacity: 160,
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesome5.ring,size: MediaQuery.of(context).size.height*0.06,color: Colors.white,),
                          SizedBox(height: 10,),
                          Text(
                            'Add Matrimony',
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ],
                      )
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MainUsers()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2B38B8),
                    image: DecorationImage(
                      opacity: 160,
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesome5.user_check,size: MediaQuery.of(context).size.height*0.06,color: Colors.white,),
                          SizedBox(height: 10,),
                          Text(
                            'Main Users',
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ],
                      )
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AllUsers()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2B38B8),
                    image: DecorationImage(
                      opacity: 160,
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesome5.users,size: MediaQuery.of(context).size.height*0.06,color: Colors.white,),
                          SizedBox(height: 10,),
                          Text(
                            'All User',
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ],
                      )
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FindMember()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2B38B8),
                    image: DecorationImage(
                      opacity: 160,
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesome5.search_plus,size: MediaQuery.of(context).size.height*0.06,color: Colors.white,),
                          SizedBox(height: 10,),
                          Text(
                            'Find Member',
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ],
                      )
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
