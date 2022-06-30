import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RewardCollectionStudent extends StatelessWidget {
  CollectionReference reward_student = FirebaseFirestore.instance.collection('reward_student');

  final String? userID;
  RewardCollectionStudent(this.userID);

  int Pgift_used = 0;
  var s_reward = "";
  var reward_reference = "";

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<DocumentSnapshot>(
        future: reward_student.doc(userID).get(),
        builder:
        (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            print(userID);
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          s_reward = data['s_reward'];
          reward_reference = data['reward_reference'];
          Pgift_used = data['Pgift_used'];

          return Scaffold(appBar: AppBar(
            title: const Text('REWARD COLLECTION'),
          ),
            body: SingleChildScrollView(

              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildCard(1),
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
  Widget buildCard(int index) => ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Container(
      color: Colors.grey.shade200,
      width: double.infinity,
      height: 150,
      child: Center(child: Text('$s_reward \n$reward_reference \n$Pgift_used point was used')),
    ),
  );

}