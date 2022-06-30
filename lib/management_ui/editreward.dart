// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class EditReward extends StatefulWidget {
//
//
//   @override
//   State<EditReward> createState() => _EditRewardState();
// }
//
// class _EditRewardState extends State<EditReward> {
//   final CollectionReference reward_standard = FirebaseFirestore.instance.collection('reward_standard');
//
//   var reference_number ="";
//   var Pgift ="";
//   var value ="";
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<DocumentSnapshot>(
//         future:reward_standard.doc(settingReward).get(),
//         builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
//           if (snapshot.hasError) {
//             return const Text("Something went wrong");
//           }
//
//           if (snapshot.hasData && !snapshot.data!.exists) {
//             print(device_name);
//             print("userID");
//             return const Text("Document does not exist");
//           }
//
//           if (snapshot.connectionState == ConnectionState.done) {
//             Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//             current_condition = data['current_condition'];
//             total_feedback = data['total_feedback'];
//             pic_cleaner = data['pic_cleaner'];
//
//             return Scaffold(
//               appBar: AppBar(
//                 title: const Text('SELECT WORKER'),
//               ),
//               body: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//
//                   Row(
//                       mainAxisAlignment : MainAxisAlignment.center,
//                       children:  [Text('TOILET: $device_name \nCURRENT CONDITION: $current_condition\nTOTAL FEEDBACL: $total_feedback', style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),]
//                   ),
//
//                   const SizedBox(height: 12,width: 20,),
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [ElevatedButton(
//                       onPressed: _TakeJob,
//                       child: const Text('TAKE THIS JOB'),
//                       style: ElevatedButton.styleFrom(fixedSize: const Size(300,50), primary: Colors.blue),),],
//                   )
//
//                 ],
//
//               ),
//             );
//           }
//
//           return const Center(
//               child: CircularProgressIndicator(backgroundColor: Colors.white,));
//
//         }
//     );
//
//   }
// }
