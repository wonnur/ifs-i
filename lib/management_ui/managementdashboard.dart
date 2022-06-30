import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instant_feedback_system/loginpage/loginpage.dart';
import 'package:instant_feedback_system/management_ui/select_edit_reward.dart';
import 'package:instant_feedback_system/management_ui/toiletproblem.dart';

class ManagementDashboard extends StatefulWidget {

  final String? userID;
  ManagementDashboard(this.userID);

  @override
  _ManagementDashboardState createState() => _ManagementDashboardState();
}

class _ManagementDashboardState extends State<ManagementDashboard> {

  @override
  String? userID;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MANAGEMENT UI'),

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ToiletProblem(userID)));

              },
                child: Text(
                  'TOILET PROBLEM',
                  style: TextStyle(fontSize: 18.0,),
                ),
                style: ElevatedButton.styleFrom(fixedSize: const Size(300, 100), primary: Colors.blue),
              ),
            ],
          ),
          Row(children: [Text('')],),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SelectSettingReward()));

              },
                child: Text(
                  'EDIT REWARD',
                  style: TextStyle(fontSize: 18.0,),
                ),
                style: ElevatedButton.styleFrom(fixedSize: const Size(300, 100), primary: Colors.blue),
              ),
            ],
          ),
          Row(children: [Text('')],),
          Row(children: [Text('')],),
          Row(children: [Text('')],),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () async {
                await  FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage(),), (route) => false);
              },
                child: Text(
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
