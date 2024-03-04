import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kp_admin/AddEvents.dart';
import 'package:kp_admin/Database/methods.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
class Events extends StatefulWidget {
  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  Stream<QuerySnapshot>? EventStream;
  Methods md=Methods();

  @override
  void initState() {
    getEvents();
    super.initState();
  }

  getEvents()async{
    md.getEvents().then((value){
      setState(() {
        EventStream=value;
      });
    });
  }

  Widget EventsList(){
    return StreamBuilder<QuerySnapshot>(
      stream: EventStream,
      builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
        return snapshot.hasData ?ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context,index){
              return messageTile(Name:snapshot.data?.docs[index]['Name'], Photo:snapshot.data?.docs[index]['Photo'],
                Date: snapshot.data?.docs[index]['Date'], Time: snapshot.data?.docs[index]['Time'],
                Description:snapshot.data?.docs[index]['Description'],Address: snapshot.data?.docs[index]['Address'],);
            }
        ) : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final addEventButton = Material(
      child: Container(
        padding: EdgeInsets.only(top: 3,bottom: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFF2b38b8)
        ),
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () async{
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddEvents()));
            },
            child: const Text(
              "Add Event",
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
        title: const Text('Events',style: TextStyle(fontSize: 18,fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFF2B38B8),
        centerTitle: true,
        elevation: 5,
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Flexible(child: EventsList()),
            addEventButton
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
  final String Address;
  final String Photo;
  final String Time;
  const messageTile({required this.Name,required this.Date,required this.Description,required this.Address,required this.Photo,required this.Time});
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
                            FirebaseFirestore.instance.collection("Events").doc("$Name").delete()
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
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            decoration:BoxDecoration(
              color: Colors.white,
              borderRadius:BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(FontAwesome5.calendar_check,size: MediaQuery.of(context).size.width*0.1,),
                    SizedBox(width: 10,),
                    Column(
                      children: [
                        Text('$Name',style: TextStyle( fontFamily: 'poppins',color: Colors.black,fontSize: 16,fontWeight:  FontWeight.bold),),
                        Text('$Date $Time', style: const TextStyle( fontFamily: 'poppins',color: Colors.black,fontSize: 14),),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.15,
                  width: MediaQuery.of(context).size.width*0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: CachedNetworkImageProvider(Photo),
                      )
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
