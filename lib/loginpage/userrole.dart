import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instant_feedback_system/cleaner_ui/cleanerdashboard.dart';
import 'package:instant_feedback_system/loginpage/loginpage.dart';
import 'package:instant_feedback_system/management_ui/managementdashboard.dart';
import 'package:instant_feedback_system/student_ui/studentdashboard.dart';


class GetUserRole extends StatelessWidget {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  var role= "";
  final String userID;

   GetUserRole(this.userID);


  @override
  Widget build(BuildContext context) {

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(userID).get(),
      builder:
      (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){

        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(backgroundColor: Colors.blue,));
        }

        if(snapshot.connectionState == ConnectionState.done){
          Map<String, dynamic> data = snapshot.data!.data() as Map< String, dynamic >;
        role = data['role'];


        if(role == 'STUDENT')
          {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Are you Student?'),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){
                    // print(userID);

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudentDashboard(userID)));

                  },
                    child: const Text(
                      'YES',
                      style: TextStyle(fontSize: 18.0,),
                    ),
                    style: ElevatedButton.styleFrom(fixedSize: const Size(300, 100), primary: Colors.blue),
                  ),
                ],
              ),

                Row(children: [const Text('')],),
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
          if(role == 'CLEANER')
          {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Are you Cleaner?'),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CleanerDashboard(userID)));

                      },
                        child: const Text(
                          'YES',
                          style: TextStyle(fontSize: 18.0,),
                        ),
                        style: ElevatedButton.styleFrom(fixedSize: const Size(300, 100), primary: Colors.blue),
                      ),
                    ],
                  ),

                  Row(children: [const Text('')],),
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

          if(role == 'MANAGEMENT')
          {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Are you Management?'),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ManagementDashboard(userID)));

                      },
                        child: const Text(
                          'YES',
                          style: TextStyle(fontSize: 18.0,),
                        ),
                        style: ElevatedButton.styleFrom(fixedSize: const Size(300, 100), primary: Colors.blue),
                      ),
                    ],
                  ),

                  Row(children: [const Text('')],),
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

      return const Text("loading");
  },
    );
  }




}

