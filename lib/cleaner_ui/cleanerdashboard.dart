import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instant_feedback_system/cleaner_ui/rewardcollectioncleaner.dart';
import 'package:instant_feedback_system/cleaner_ui/task_toilet.dart';
import 'package:instant_feedback_system/cleaner_ui/userinfo_cleaner.dart';
import 'package:instant_feedback_system/loginpage/loginpage.dart';

class CleanerDashboard extends StatefulWidget {

  final String? userID;
  CleanerDashboard(this.userID);

  @override
  _CleanerDashboardState createState() => _CleanerDashboardState();
}

class _CleanerDashboardState extends State<CleanerDashboard> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  String? userID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CLEANER UI'),

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                print(userID);

                Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfoCleaner(uid)));

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
                Navigator.push(context, MaterialPageRoute(builder: (context) => TaskToilet(uid)));

              },
                child: const Text(
                  'TASK AVAILABLE',
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
                print('uid0132');

                print(uid);

                print("ok $userID");

                Navigator.push(context, MaterialPageRoute(builder: (context) => RewardCollectionCleaner0(uid)));

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
          //       Navigator.push(context, MaterialPageRoute(builder: (context) => CleanerDashboard(userID)));
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
          Row(children: const [Text('')],),
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
