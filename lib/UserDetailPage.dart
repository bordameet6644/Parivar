import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
class UserDetailPage extends StatefulWidget {
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
  UserDetailPage({required this.Name,required this.MiddleName,required this.SurName,required this.Village,
    required this.BirthDate,required this.Gender,required this.MaritalStatus,required this.Occupation,
    required this.SubOccupation,required this.BloodGroup,required this.MobilrNumber,required this.ProfilePicture});

  @override
  _UserDetailPagePageState createState() => _UserDetailPagePageState();
}

class _UserDetailPagePageState extends State<UserDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title:Text('${widget.Name} ${widget.SurName}',style: TextStyle(fontSize: 18,fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFF2B38B8),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.11,
                color: Color(0xFF2B38B8),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.04,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.grey,
                      backgroundImage: CachedNetworkImageProvider(widget.ProfilePicture),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(FontAwesome5.user_alt),
                                SizedBox(width: 5,),
                                Text(
                                  'Name:',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Icon(FontAwesome5.user_alt),
                                SizedBox(width: 10,),
                                Text(
                                  'Middle Name:',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Icon(FontAwesome5.location_arrow),
                                SizedBox(width: 10,),
                                Text(
                                  'Village:',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Icon(FontAwesome5.phone),
                                SizedBox(width: 10,),
                                const Text(
                                  'Mobile Number:',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Icon(FontAwesome5.users),
                                SizedBox(width: 10,),
                                const Text(
                                  'Gender:',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Icon(FontAwesome5.calendar_day),
                                SizedBox(width: 10,),
                                const Text(
                                  'Birth Date:',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Icon(FontAwesome5.heart),
                                SizedBox(width: 10,),
                                const Text(
                                  'Marital Status:',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Icon(FontAwesome5.briefcase),
                                SizedBox(width: 10,),
                                const Text(
                                  'Occupation:',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Icon(FontAwesome5.briefcase),
                                SizedBox(width: 10,),
                                const Text(
                                  'Sub-Occupation:',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Icon(FontAwesome5.briefcase),
                                SizedBox(width: 10,),
                                const Text(
                                  'BloodGroup:',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width:MediaQuery.of(context).size.width*0.06,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${widget.Name} ${widget.SurName}',style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),),
                          Divider(),
                          Text('${widget.MiddleName}',style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),),
                          Divider(),
                          Text('${widget.Village}',style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),),
                          Divider(),
                          Text('${widget.MobilrNumber}',style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),),
                          Divider(),
                          Text('${widget.Gender}',style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),),
                          Divider(),
                          Text('${widget.BirthDate}',style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),),
                          Divider(),
                          Text('${widget.MaritalStatus}',style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),),
                          Divider(),
                          Text('${widget.Occupation}',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              fontSize: 16
                          ),),
                          Divider(),
                          Text('${widget.SubOccupation}',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              fontSize: 16
                          ),),
                          Divider(),
                          Text('${widget.BloodGroup}',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              fontSize: 16
                          ),),
                        ],
                      )
                    ],
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