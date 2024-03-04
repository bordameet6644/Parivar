import 'package:cloud_firestore/cloud_firestore.dart';

class Methods{
  Future getFamily(String userPhoneNum) async{
    return await FirebaseFirestore.instance.collection('users').doc(userPhoneNum).collection('Family').snapshots();
  }
  Future getUserProfileStatus(String userPhoneNum) async{
    return await FirebaseFirestore.instance.collection('users').doc(userPhoneNum).snapshots();
  }
  Future getUserProfile(String userPhoneNum) async{
    return await FirebaseFirestore.instance.collection('users').doc(userPhoneNum).get();
  }
  Future getmatrimony(String gender)async{
    return await FirebaseFirestore.instance.collection('Matrimony').doc(gender).collection(gender).snapshots();
  }
  Future getCommittee() async{
    return await FirebaseFirestore.instance.collection('committee').snapshots();
  }
  Future getBloodDetails() async{
    return await FirebaseFirestore.instance.collection('Blood Donate').snapshots();
  }
  Future getEvents() async{
    return await FirebaseFirestore.instance.collection('Events').orderBy('Date').snapshots();
  }
  Future getMember(String name) async{
    return await FirebaseFirestore.instance.collection('All Users').where('caseSearch',arrayContains: name).snapshots();
  }
  Future getMainUsers()async{
    return await FirebaseFirestore.instance.collection('users').snapshots();
  }
  Future getAllUsers()async{
    return await FirebaseFirestore.instance.collection('All Users').snapshots();
  }
  Future getPosts()async{
    return await FirebaseFirestore.instance.collection('Posts').orderBy('Date',descending: true).orderBy('Time',descending: true).snapshots();
  }
}