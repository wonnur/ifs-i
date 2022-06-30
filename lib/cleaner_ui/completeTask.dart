import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instant_feedback_system/cleaner_ui/cleanerdashboard.dart';

class CompleteTask extends StatefulWidget {

  final String? device_name;
  CompleteTask({this.device_name});

  @override
  State<CompleteTask> createState() => _CompleteTaskState();
}

class _CompleteTaskState extends State<CompleteTask> {

  final CollectionReference _task = FirebaseFirestore.instance.collection('task');
  final String userID = FirebaseAuth.instance.currentUser!.uid;


  int total_feedback = 0;
  var current_condition ="";
  var device ="";
  var pic_cleaner ="";
  var cleaning_status ="";
  var confirmJob = "";


  Future<void> _TakeJob(){
    confirmJob = "completed";

    return _task.doc('$device_name').update({
      'cleaning_status' : confirmJob,
    }).then((value) => print('job has been update'))
        .catchError((error) => print("Failed to update job"));

  }

  String? device_name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    device_name = widget.device_name;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future:_task.doc("FKJ-A-0-1").get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            print(device_name);
            print("userID");
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            current_condition = data['current_condition'];
            total_feedback = data['total_feedback'];
            pic_cleaner = data['pic_cleaner'];

            return Scaffold(
              appBar: AppBar(
                title:  Text('$device_name'),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Row(
                      mainAxisAlignment : MainAxisAlignment.center,
                      children:  [Text('TOILET: $device_name \nCURRENT CONDITION: $current_condition\nTOTAL FEEDBACK: $total_feedback', style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),]
                  ),

                  const SizedBox(height: 12,width: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [ElevatedButton(
                      onPressed: (){
                        print(device_name);
                        _TakeJob();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CleanerDashboard(userID)));

                      },
                      child: const Text('I HAD FINISH THE JOB'),
                      style: ElevatedButton.styleFrom(fixedSize: const Size(300,50), primary: Colors.blue),),],
                  )

                ],

              ),
            );
          }

          return const Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white,));

        }
    );
  }
}
