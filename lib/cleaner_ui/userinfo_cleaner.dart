import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserInfoCleaner extends StatelessWidget {

  final String? userID;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  UserInfoCleaner(this.userID);



  var name = "";
  var IcNumber = "";
  int Pgift = 0;
  var role = "";

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(userID).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          print(userID);
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          print(userID);

          role = data['role'];
          name = data['Name'];
          Pgift = data['Pgift'];

          return Scaffold(
            appBar: AppBar(
              title: Text('USER PROFILE'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('NAME :'
                    ,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                  ],),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('$name'
                    ,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),),
                  ],),
                Row(children: [Text('')],),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('ROLE :'
                    ,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                  ],),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('$role'
                    ,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),),
                  ],),
                Row(children: [Text('')],),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('POINT GIFT :'
                    ,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                  ],),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('$Pgift'
                    ,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),),
                  ],),
                Row(children: [Text('')],),


              ],
            ),

          );
        }

        return Center(
            child: CircularProgressIndicator(backgroundColor: Colors.blue,));      },
    );
  }
}
