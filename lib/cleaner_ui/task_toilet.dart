import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instant_feedback_system/cleaner_ui/completeTask.dart';
import 'dart:async';

import 'package:instant_feedback_system/cleaner_ui/open_task.dart';


class TaskToilet extends StatefulWidget {

  final String? userID;
  TaskToilet(this.userID);


  @override
  State<TaskToilet> createState() => _TaskToiletState();
}

class _TaskToiletState extends State<TaskToilet> {
  final CollectionReference _task = FirebaseFirestore.instance.collection('task');

  var cleaning_status = '';
  var device_name = '';
  var pic_cleaner= '';

  String? userID;


  @override
  Widget build(BuildContext context) {

    return FutureBuilder<DocumentSnapshot>(
        future:_task.doc("FKJ-A-0-1").get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            print(userID);
            print("userID");
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            cleaning_status = data['cleaning_status'];
            device_name = data['device'];
            pic_cleaner = data['pic_cleaner'];

            return Scaffold(appBar: AppBar(
              title: const Text('USER TASK'),
            ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [ElevatedButton(
                          onPressed: (){
                            if(cleaning_status == 'no progress'){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => OpenTask(device_name: device_name)));
                            } else if(cleaning_status == 'in progress'){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteTask(device_name: device_name)));
                            }

                          },
                          child: Text('$device_name \n$cleaning_status \n$pic_cleaner '),
                          style: ElevatedButton.styleFrom(fixedSize: const Size(300.0, 100.0), primary: Colors.blue),
                        ),

                        const SizedBox(height: 12,width: 20,),
                      ],

                    ),
                  ],
                )
            );
          }

          return const Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white,));




    }
    );

  }


}
