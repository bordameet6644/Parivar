import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kp_admin/Database/methods.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kp_admin/UserDetailPage.dart';

class FindMember extends StatefulWidget {
  const FindMember({Key? key}) : super(key: key);

  @override
  _FindMemberState createState() => _FindMemberState();
}

class _FindMemberState extends State<FindMember> {
  TextEditingController searchController = TextEditingController();
  Stream<QuerySnapshot>? MemberStream;
  Methods md=Methods();
  initiateSearch(String name)async{
    md.getMember(name).then((value){
      setState(() {
        MemberStream=value;
      });
    });
  }

  Search(String query)async{
      MemberStream=await FirebaseFirestore.instance.collection('All Users').where('FullName',arrayContains: query).snapshots();
      setState(() { });
  }

  Widget MembersList(){
    return StreamBuilder<QuerySnapshot>(
      stream: MemberStream,
      builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context,index){
              return messageTile(Name:snapshot.data?.docs[index]['Name'], MiddleName:snapshot.data?.docs[index]['MiddleName'],
                  SurName: snapshot.data?.docs[index]['SurName'], Village: snapshot.data?.docs[index]['Village'],
                  BirthDate: snapshot.data?.docs[index]['BirthDate'], Gender: snapshot.data?.docs[index]['Gender'],
                  MaritalStatus: snapshot.data?.docs[index]['Marital Status'], Occupation: snapshot.data?.docs[index]['Occupation'],
                  SubOccupation: snapshot.data?.docs[index]['SubOccupation'], BloodGroup:snapshot.data?.docs[index]['BloodGroup'] ,
                  MobilrNumber:snapshot.data?.docs[index]['MobileNumber'], ProfilePicture:snapshot.data?.docs[index]['ProfilePicture']);
            }
        ) : Container() ;
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Find Member',style: TextStyle(fontSize: 18,fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFF2B38B8),
        centerTitle: true,
        elevation: 5,
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child:Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20,right: 10,left: 10,bottom: 10),
              child: TextField(
                style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16,fontFamily:'Poppins'),
                autofocus: false,
                keyboardType: TextInputType.name,
                controller: searchController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Search Name Here',
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
                    suffixIcon:GestureDetector(
                      child: Icon(Icons.search),
                      onTap: (){
                        initiateSearch(searchController.text.trim());
                        },
                    )
                ),
              ),
            ),
            Flexible(child: MembersList()),
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
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UserDetailPage(Name: Name, MiddleName: MiddleName, SurName: SurName, Village: Village, BirthDate: BirthDate, Gender: Gender, MaritalStatus: MaritalStatus, Occupation: Occupation, SubOccupation: SubOccupation, BloodGroup: BloodGroup, MobilrNumber: MobilrNumber, ProfilePicture: ProfilePicture)));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15,right: 15,top: 15),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
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
                    Text('$Name $SurName', style: TextStyle( color: Colors.black, fontFamily: 'Poppins',fontSize: 16,fontWeight:  FontWeight.w600),),
                    Text('$MobilrNumber', style: const TextStyle( color: Colors.black, fontFamily: 'Poppins',fontSize: 14,fontWeight:  FontWeight.w600),),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }
}
