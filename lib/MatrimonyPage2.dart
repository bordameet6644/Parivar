import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kp_admin/Database/methods.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'AddMatrimony.dart';

class MatrimonyPage2 extends StatefulWidget {
  String gender;
  MatrimonyPage2({required this.gender});

  @override
  _MatrimonyPage2State createState() => _MatrimonyPage2State();
}

class _MatrimonyPage2State extends State<MatrimonyPage2> {
  Stream<QuerySnapshot>? matrimonyStream;
  Methods md = Methods();

  void initState() {
    getMembers();
    super.initState();
  }

  getMembers() async {
    md.getmatrimony('${widget.gender}').then((value) {
      setState(() {
        matrimonyStream = value;
      });
    });
  }

  Widget MembersList() {
    return StreamBuilder<QuerySnapshot>(
      stream: matrimonyStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  return messageTile(
                      Name: snapshot.data?.docs[index]['Name'],
                      SurName: snapshot.data?.docs[index]['SurName'],
                      Village: snapshot.data?.docs[index]['Village'],
                      MiddleName: snapshot.data?.docs[index]['MiddleName'],
                      ProfilePicture: snapshot.data?.docs[index]
                          ['ProfilePicture'],
                      SubOccupation: snapshot.data?.docs[index]['Name'],
                      Occupation: snapshot.data?.docs[index]['Occupation'],
                      BirthDate: snapshot.data?.docs[index]['BirthDate'],
                      Age: snapshot.data?.docs[index]['Age'],
                      PhoneNumber: snapshot.data?.docs[index]['PhoneNumber'],
                      gender: widget.gender);
                })
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final addButton = Material(
      child: Container(
        padding: EdgeInsets.only(top: 3, bottom: 3),
        decoration: BoxDecoration(
          color: Color(0xFF2B38B8),
        ),
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddMatrimony(gender: widget.gender)));
            },
            child: Text(
              "Add ${widget.gender}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, color: Colors.white, fontFamily: 'Poppins'),
            )),
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: Text(
          '${widget.gender}',
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF2B38B8),
        centerTitle: true,
        elevation: 5,
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Flexible(child: MembersList()),
            addButton
          ],
        ),
      ),
    );
  }
}

class messageTile extends StatelessWidget {
  final String Name;
  final String SurName;
  final String MiddleName;
  final String Age;
  final String BirthDate;
  final String Occupation;
  final String SubOccupation;
  final String PhoneNumber;
  final String Village;
  final String ProfilePicture;
  final String gender;
  const messageTile(
      {required this.Name,
      required this.SurName,
      required this.Village,
      required this.MiddleName,
      required this.ProfilePicture,
      required this.SubOccupation,
      required this.Occupation,
      required this.BirthDate,
      required this.Age,
      required this.PhoneNumber,
      required this.gender});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  backgroundColor: Colors.white,
                  title: Stack(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          alignment: Alignment.topCenter,
                          child: Text('Alert',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                              ))),
                      Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.red,
                            )),
                      ),
                    ],
                  ),
                  content: Text('you want to remove this person?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      )),
                  actions: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10, bottom: 20),
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
                              minWidth: MediaQuery.of(context).size.width * 0.3,
                              onPressed: () async {
                                FirebaseFirestore.instance
                                    .collection("Matrimony")
                                    .doc("$gender")
                                    .collection('$gender')
                                    .doc('$Name $MiddleName $SurName')
                                    .delete()
                                    .then((value) async {
                                  Reference storageReference =
                                      await FirebaseStorage.instance
                                          .refFromURL(ProfilePicture);
                                  storageReference.delete().then((value) {
                                    Navigator.pop(context);
                                  });
                                });
                              },
                              child: const Text(
                                "YES",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              color: Color(0xFFDBDEF3),
              borderRadius: BorderRadius.all(Radius.circular(17)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  backgroundImage: CachedNetworkImageProvider(ProfilePicture),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$Name $SurName',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$Village',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
