import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instant_feedback_system/loginpage/loginpage.dart';
import 'package:instant_feedback_system/student_ui/get_gift_point.dart';
import 'package:instant_feedback_system/student_ui/rewardcollection_student.dart';
import 'package:instant_feedback_system/student_ui/userinfo.dart';

class StudentDashboard extends StatefulWidget {

  final String? userID;
  StudentDashboard(this.userID);

  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  String? userID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STUDENT UI'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                print(uid);

                Navigator.push(context, MaterialPageRoute(builder: (context) => User_Info(uid)));

              },
                child: const Text(
                  'USER INFO',
                  style: TextStyle(fontSize: 18.0,),
                ),
                style: ElevatedButton.styleFrom(fixedSize: const Size(300, 100), primary: Colors.blue),
              ),
            ],
          ),
          Row(children: const [Text('')],),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => GetGiftPoint()));

              },
                child: const Text(
                  'GET GIFT POINT',
                  style: TextStyle(fontSize: 18.0,),
                ),
                 style: ElevatedButton.styleFrom(fixedSize: const Size(300, 100), primary: Colors.blue),
              ),
            ],
          ),
          Row(children: const [Text('')],),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => RewardCollectionStudent(uid)));

              },
                child: const Text(
                  'REWARD COLLECTION',
                  style: TextStyle(fontSize: 18.0,),
                ),
                style: ElevatedButton.styleFrom(fixedSize: const Size(300, 100), primary: Colors.blue),
              ),
            ],
          ),
          Row(children: const [Text('')],),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     ElevatedButton(onPressed: (){
          //       Navigator.push(context, MaterialPageRoute(builder: (context) => StudentDashboard(userID)));
          //
          //     },
          //       child: const Text(
          //         'CLAIM REWARD',
          //         style: TextStyle(fontSize: 18.0,),
          //       ),
          //       style: ElevatedButton.styleFrom(fixedSize: const Size(300, 100), primary: Colors.blue),
          //     ),
          //   ],
          // ),
          Row(children: const [Text('')],),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () async {
                await  FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage(),), (route) => false);
              },
                child: const Text(
                  'LOG OUT',
                  style: TextStyle(fontSize: 18.0,),
                ),
                style: ElevatedButton.styleFrom(fixedSize: const Size(300, 100), primary: Colors.red),
              ),
            ],
          ),


        ],
      ),
    );
  }
}
