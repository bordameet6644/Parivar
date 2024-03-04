import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kp_admin/AddCommittee.dart';
import 'package:kp_admin/Database/methods.dart';

class Committee extends StatefulWidget {
  const Committee({Key? key}) : super(key: key);

  @override
  _CommitteeState createState() => _CommitteeState();
}

class _CommitteeState extends State<Committee> {
  Stream<QuerySnapshot>? CommitteeStream;
  Methods md=Methods();

  @override
  void initState() {
    getMembers();
    super.initState();
  }

  getMembers()async{
    md.getCommittee().then((value){
      setState(() {
        CommitteeStream=value;
      });
    });
  }

  Widget MembersList(){
    return StreamBuilder<QuerySnapshot>(
      stream: CommitteeStream,
      builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
        return snapshot.hasData ?ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context,index){
              return messageTile(Name:snapshot.data?.docs[index]['Name'], Place:snapshot.data?.docs[index]['Place'],
                  SurName: snapshot.data?.docs[index]['SurName'], Village: snapshot.data?.docs[index]['Village'],
                   ProfilePicture:snapshot.data?.docs[index]['ProfilePicture']);
            }
        ) : Container();
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final addCommitteeButton = Material(
      child: Container(
        padding: EdgeInsets.only(top: 3,bottom: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFF2b38b8)
        ),
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () async{
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddCommittee()));
            },
            child: const Text(
              "Add Committee",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, color: Colors.white,fontFamily:'Poppins'),
            )
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Committee',style: TextStyle(fontSize: 18,fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),),
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
            addCommitteeButton
          ],
        )
      ),
    );
  }
}

class messageTile extends StatelessWidget{
  final String Name;
  final String SurName;
  final String Village;
  final String Place;
  final String ProfilePicture;
  const messageTile({required this.Name,required this.SurName,required this.Village,required this.Place,required this.ProfilePicture});
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
                      child: Text('Alert',style: TextStyle(color: Colors.black, fontFamily: 'Poppins',))
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
              content: Text('you want to remove this member?',
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
                            print("$Name");
                            FirebaseFirestore.instance.collection("committee").doc("$Name $SurName").delete()
                                .then((value) async{
                              /*String filePath = ProfilePicture.replaceAll(new RegExp(r'https://firebasestorage.googleapis.com/v0/b/dial-in-2345.appspot.com/o/'), '');
                              filePath = filePath.replaceAll(new RegExp(r'%2F'), '/');
                              filePath = filePath.replaceAll(new RegExp(r'(\?alt).*'), '');
                              Reference storageReferance = FirebaseStorage.instance.ref();
                              storageReferance.child(filePath).delete().then((value){
                                Navigator.pop(context);
                              });*/
                              Reference storageReference= await FirebaseStorage.instance.refFromURL(ProfilePicture);
                              storageReference.delete().then((value){
                                Navigator.pop(context);
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
                  backgroundImage: CachedNetworkImageProvider(ProfilePicture),
                ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$Name $SurName', style: TextStyle( color: Colors.black, fontFamily: 'poppins',fontSize: 16,fontWeight:  FontWeight.w600),),
                    Text('$Place', style: TextStyle( color: Colors.black, fontFamily: 'poppins',fontSize: 14,fontWeight:  FontWeight.w600),),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }
}
