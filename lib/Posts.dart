import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kp_admin/Database/methods.dart';

import 'AddPost.dart';
class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  Stream<QuerySnapshot>? PostStream;
  Methods md=Methods();

  @override
  void initState() {
    getPosts();
    super.initState();
  }

  getPosts()async{
    md.getPosts().then((value){
      setState(() {
        PostStream=value;
      });
    });
  }

  Widget EventsList(){
    return StreamBuilder<QuerySnapshot>(
      stream: PostStream,
      builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
        return snapshot.hasData ?ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context,index){
              return messageTile(Name:snapshot.data?.docs[index]['Name'], Photo:snapshot.data?.docs[index]['Image'],
                Date: snapshot.data?.docs[index]['Date'], Time: snapshot.data?.docs[index]['Time'],
                Description:snapshot.data?.docs[index]['Description'],Id: snapshot.data?.docs[index].reference.id.toString(),
                Position:snapshot.data?.docs[index]['Position']);
            }
        ) : Container();
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final seePostsButton = Material(
      child: Container(
        padding: EdgeInsets.only(top: 3,bottom: 3),
        decoration: BoxDecoration(
            color: const Color(0xFF2b38b8)
        ),
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () async{
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddPost()));
            },
            child: const Text(
              "Add Posts",
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
        title:Text('Posts',style: TextStyle(fontSize: 18,fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFF2B38B8),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Flexible(child: EventsList()),
            seePostsButton
          ],
        ),
      ),
    );
  }
}
class messageTile extends StatelessWidget{
  final String Name;
  final String Date;
  final String Description;
  final String Time;
  final String Photo;
  final String? Id;
  final String? Position;
  const messageTile({required this.Name,required this.Date,required this.Description,required this.Time,required this.Photo,required this.Id,required this.Position});
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
              content: Text('you want to remove this event?',
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
                            FirebaseFirestore.instance.collection("Posts").doc("$Id").delete()
                                .then((value) async{
                              Reference storageReference= await FirebaseStorage.instance.refFromURL(Photo);
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
      child:Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          //padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
          decoration:BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.4,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: CachedNetworkImageProvider(Photo),
                        )
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.4,
                    alignment: Position=='topLeft'? Alignment.topLeft
                        :Position=='topRight'? Alignment.topRight
                        :Position=='bottomLeft'? Alignment.bottomLeft
                        :Position=='bottomRight'? Alignment.bottomRight
                        :Alignment.center,
                    padding: EdgeInsets.only(left: 10,right: 18,top: 10,bottom: 15),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
