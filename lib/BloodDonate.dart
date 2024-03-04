import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kp_admin/Database/methods.dart';
import 'package:kp_admin/AskForBlood.dart';

class BloodDonate extends StatefulWidget {
  const BloodDonate({Key? key}) : super(key: key);

  @override
  _BloodDonateState createState() => _BloodDonateState();
}

class _BloodDonateState extends State<BloodDonate> {
  Stream<QuerySnapshot>? BloodStream;
  Methods md=Methods();
  Stream<DocumentSnapshot>? profileStream;

  @override
  void initState() {
    getBlood();
    super.initState();
  }

  getBlood()async{
    md.getBloodDetails().then((value){
      setState(() {
        BloodStream=value;
      });
    });
  }

  Widget MembersList(){
    return StreamBuilder<QuerySnapshot>(
      stream: BloodStream,
      builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
        return snapshot.hasData ?ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context,index){
              return messageTile(Name:snapshot.data?.docs[index]['Name'], MiddleName:snapshot.data?.docs[index]['MiddleName'],
                  SurName: snapshot.data?.docs[index]['SurName'], BloodGroup: snapshot.data?.docs[index]['BloodGroup'],
                  Date: snapshot.data?.docs[index]['Date'],MobileNumber: snapshot.data?.docs[index]['MobileNumber']);
            }
        ): Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final askForBloodButton = Material(
      child: Container(
        padding: EdgeInsets.only(top: 3,bottom: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFF2b38b8)
        ),
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () async{
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AskForBlood()));
            },
            child: const Text(
              "Ask for help",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16,fontFamily:'Poppins'),
            )
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Blood Donate',style: TextStyle(fontSize: 18,fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFF2B38B8),
        centerTitle: true,
        elevation: 5,
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child:Column(
          children: [
            SizedBox(height: 10,),
            Flexible(child: MembersList()),
            askForBloodButton
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
  final String BloodGroup;
  final String Date;
  final String MobileNumber;
  const messageTile({required this.Name,required this.MiddleName,required this.SurName,required this.BloodGroup,required this.Date,required this.MobileNumber});
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
            content: Text('you want to remove this blood request?',
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
                          print("$Name $MiddleName $SurName");
                          FirebaseFirestore.instance.collection("Blood Donate").doc("$Name $MiddleName $SurName").delete()
                              .then((value) {
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
                Container(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage:AssetImage('assets/blood.png'),
                        radius: 40,
                        backgroundColor: Colors.red,
                        child: Text(' ',style: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.transparent,
                          child: Text('$BloodGroup',style: TextStyle(color: Colors.black,fontFamily: 'Poppins',fontSize: 18,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$Name $MiddleName $SurName', style: TextStyle( color: Colors.black, fontFamily: 'Poppins',fontSize: 15,fontWeight:  FontWeight.bold),),
                    Text('$Date', style: TextStyle( color: Colors.black, fontFamily: 'Poppins',fontSize: 14,fontWeight:  FontWeight.w600),),
                    Text('$MobileNumber', style: TextStyle( color: Colors.black, fontFamily: 'Poppins',fontSize: 14,fontWeight:  FontWeight.w600),),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }
}
