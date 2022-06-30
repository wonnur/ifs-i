import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instant_feedback_system/cleaner_ui/cleanerdashboard.dart';
import 'package:instant_feedback_system/student_ui/studentdashboard.dart';


class UpdatePgift extends StatefulWidget {

  final String? userID;
  UpdatePgift({this.userID});

  @override
  State<UpdatePgift> createState() => _UpdatePgiftState();
}

class _UpdatePgiftState extends State<UpdatePgift> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;


  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  String? userID;

  int current_Pgift = 0;
  int Old_Pgift = 0;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userID = widget.userID;

  }
  Future<void> UpdatePgift_firebase() {
    return users
        .doc('$userID')
        .update({
      'Pgift' : current_Pgift,})
        .then((value) => print ("User update"))
        .catchError((error) => print("Failed to update user status : $error"));

  }
  // _openStudentDashboard(){
  //   Navigator.pop(context, MaterialPageRoute(builder: (context) => StudentDashboard(userID)));
  // }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<DocumentSnapshot>(
        future:users.doc(userID).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            Old_Pgift = data['Pgift'];
            current_Pgift = Old_Pgift + 20;
            print(current_Pgift);
            UpdatePgift_firebase();

            return Scaffold(
              appBar: AppBar(
                title: const Text('CONGRATULATION'),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Text('YOU HAVE GOT 20 GIFT POINT\nPLEASE GIVE RATING IN NEXT TIME'
                      ,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                    ],),

                  Row(children: const [Text('')],),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context) => StudentDashboard(uid)));

                      },
                        child: const Text(
                          'OK',
                          style: TextStyle(fontSize: 18.0,),
                        ),
                        style: ElevatedButton.styleFrom(fixedSize: const Size(300, 50), primary: Colors.blue),
                      ),
                    ],
                  ),

                ],
              ),

            );

            // _openStudentDashboard();

          }

          return const Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white,));

        }
    );

  }
}

