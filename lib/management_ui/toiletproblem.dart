import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ToiletProblem extends StatefulWidget {
  final String? userID;
  ToiletProblem(this.userID);


  @override
  _ToiletProblemState createState() => _ToiletProblemState();
}

class _ToiletProblemState extends State<ToiletProblem> {

  CollectionReference task_toilet = FirebaseFirestore.instance.collection('task');

  var cleaning_status = "";
  var current_condition = "";
  var past_total_feedback = "";
  var pic_cleaner = "";
  int total_feedback = 6;
  var device_name = "";
  int alerted_device = 1;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: task_toilet.doc('FKJ-A-0-1').get(),
    builder:
    (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
    if (snapshot.hasError) {
    return const Text("Something went wrong");
    }

    if (snapshot.hasData && !snapshot.data!.exists) {
    return const Text("Document does not exist");
    }

    if (snapshot.connectionState == ConnectionState.done) {
      Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
      cleaning_status = data['cleaning_status'];
      pic_cleaner = data['pic_cleaner'];
      device_name = data['device'];

      return Scaffold(appBar: AppBar(
        title: const Text('TOILET PROBLEM'),
      ),
          body: SingleChildScrollView(

            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCard(2),
                const SizedBox(height: 12,),
              ],

            ),
          )
      );
    }



    return const Center(
        child: CircularProgressIndicator(backgroundColor: Colors.blue,));

    }

    );

  }
  Widget buildCard(int index) =>
      Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // if(cleaning_status != 'in progress'){
                //
                //
                // }


              },
              child: Text('LOCATION\t\t\t\t\t\t: $device_name \nSTATUS\t\t: $cleaning_status \nPERSON IN CHARGE: $pic_cleaner ',
              style: const TextStyle(
                  fontSize: 18.0),), style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300,100),primary: Colors.blue),),
          ],
        ),
      ],
    );





}
