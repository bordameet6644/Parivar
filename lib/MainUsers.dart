import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kp_admin/Database/methods.dart';

import 'FamilyMembers.dart';
class MainUsers extends StatefulWidget {
  const MainUsers({Key? key}) : super(key: key);

  @override
  State<MainUsers> createState() => _MainUsersState();
}

class _MainUsersState extends State<MainUsers> {
  Stream<QuerySnapshot>? UserStream;
  Methods md=Methods();

  @override
  void initState() {
    getMembers();
    super.initState();
  }

  getMembers()async{
    md.getMainUsers().then((value){
      setState(() {
        UserStream=value;
      });
    });
  }

  Widget MembersList(){
    return StreamBuilder<QuerySnapshot>(
      stream: UserStream,
      builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
        return snapshot.hasData ?ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context,index){
              if(snapshot.data?.docs[index]['Profile']=='Done'){
                return messageTile(Name:snapshot.data?.docs[index]['Name'], MiddleName:snapshot.data?.docs[index]['MiddleName'],
                    SurName: snapshot.data?.docs[index]['SurName'], Village: snapshot.data?.docs[index]['Village'],
                    BirthDate: snapshot.data?.docs[index]['BirthDate'], Gender: snapshot.data?.docs[index]['Gender'],
                    MaritalStatus: snapshot.data?.docs[index]['Marital Status'], Occupation: snapshot.data?.docs[index]['Occupation'],
                    SubOccupation: snapshot.data?.docs[index]['SubOccupation'], BloodGroup:snapshot.data?.docs[index]['BloodGroup'] ,
                    MobilrNumber:snapshot.data?.docs[index]['MobileNumber'], ProfilePicture:snapshot.data?.docs[index]['ProfilePicture']);
              }
              else{
                return messageTile2(Name:snapshot.data?.docs[index]['Name'], MobileNumber:snapshot.data?.docs[index]['MobileNumber']);
              }
            }
        ) : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Main Users',style: TextStyle(fontSize: 18,fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFF2B38B8),
        centerTitle: true,
        elevation: 5,
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Flexible(child: MembersList()),
            //addCommitteeButton
          ],
        ),
      ),
    );
  }
}
class messageTile extends StatelessWidget{
  final String Name;
  final String MiddleName;
  final String SurName;
  final String Village;
  final String BirthDate;
  final String Gender;
  final String MaritalStatus;
  final String Occupation;
  final String SubOccupation;
  final String BloodGroup;
  final String MobilrNumber;
  final String ProfilePicture;
  const messageTile({required this.Name,required this.MiddleName,required this.SurName,required this.Village,required this.BirthDate,required this.Gender,required this.MaritalStatus,required this.Occupation,required this.SubOccupation,required this.BloodGroup,required this.MobilrNumber,required this.ProfilePicture});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async{
        final snapshot = await FirebaseFirestore.instance.collection('users').doc(MobilrNumber).collection('Family').get();
        if ( snapshot.size == 0 ) {
          print('it does not exist');
          showDialog(
              context:context,
              builder:(context)=>AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                backgroundColor: Colors.white,
                title: Stack(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        alignment: Alignment.topCenter,
                        child: Text('Alert',style: TextStyle(color: Colors.black, fontFamily: 'Poppins',),)
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed:(){
                            Navigator.pop(context);
                          },
                          icon:Icon(Icons.cancel,color: Colors.red,)
                      ),
                    ),
                  ],
                ),
                content: Text('you want to remove this main user?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Poppins',)),
                actions: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 10,bottom: 20),
                    child: Material(
                      elevation: 9,
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xFFC48587),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: const Color(0xFF2B38B8),
                        ),
                        child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width*0.3,
                            onPressed: () async{
                              FirebaseFirestore.instance.collection("users").doc("$MobilrNumber").delete()
                                  .then((value) async{
                                    FirebaseFirestore.instance.collection('All Users').doc("$Name $MiddleName $SurName").delete()
                                        .then((value) async{
                                      Reference storageReference=await FirebaseStorage.instance.refFromURL(ProfilePicture);
                                      storageReference.delete().then((value){
                                        Navigator.pop(context);
                                          });
                                        });
                                      });
                                    },
                            child: const Text(
                              "YES",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Poppins',),
                            )),
                      ),
                    ),
                  ),
                ],
              )
          );
        }else{
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FamilyMembers(number: MobilrNumber)));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15,right: 15,top: 15),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            decoration:BoxDecoration(
              color: Color(0xFFDBDEF3),
              borderRadius:BorderRadius.all(Radius.circular(17)),
            ),
            child: Row(
              children: [
                SizedBox(width: 5,),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  backgroundImage:CachedNetworkImageProvider(
                    "$ProfilePicture",
                  ),
                  //NetworkImage(ProfilePicture),
                ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$Name $SurName', style: TextStyle( color: Colors.black, fontFamily: 'poppins',fontSize: 16,fontWeight:  FontWeight.w600),),
                    Text('$MobilrNumber', style: TextStyle( color: Colors.black, fontFamily: 'poppins',fontSize: 14,fontWeight:  FontWeight.w600),),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }
}


class messageTile2 extends StatelessWidget{
  final String MobileNumber;
  final String Name;
  messageTile2({required this.Name,required this.MobileNumber});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showDialog(
            context:context,
            builder:(context)=>AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              backgroundColor: Colors.white,
              title: Stack(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 10,bottom: 10),
                      alignment: Alignment.topCenter,
                      child: Text('Alert',style: TextStyle(color: Colors.black, fontFamily: 'Poppins',),)
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed:(){
                          Navigator.pop(context);
                        },
                        icon:Icon(Icons.cancel,color: Colors.red,)
                    ),
                  ),
                ],
              ),
              content: Text('you want to remove this main user?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Poppins',)),
              actions: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10,bottom: 20),
                  child: Material(
                    elevation: 9,
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFFC48587),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: const Color(0xFF2B38B8),
                      ),
                      child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width*0.3,
                          onPressed: () async{
                            FirebaseFirestore.instance.collection("users").doc("$MobileNumber").delete()
                                .then((value) async{
                                Navigator.pop(context);
                            });
                          },
                          child: const Text(
                            "YES",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Poppins',),
                          )),
                    ),
                  ),
                ),
              ],
            )
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15,right: 15,top: 15),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            decoration:BoxDecoration(
              color: Color(0xFFDBDEF3),
              borderRadius:BorderRadius.all(Radius.circular(17)),
            ),
            child: Row(
              children: [
                SizedBox(width: 5,),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$Name', style: TextStyle( color: Colors.black, fontFamily: 'poppins',fontSize: 16,fontWeight:  FontWeight.w600),),
                    Text('$MobileNumber', style: TextStyle( color: Colors.black, fontFamily: 'poppins',fontSize: 14,fontWeight:  FontWeight.w600),),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }
  
}