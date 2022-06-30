import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instant_feedback_system/student_ui/updatePgift.dart';

class GetGiftPoint extends StatefulWidget {
  const GetGiftPoint({Key? key}) : super(key: key);

  @override
  State<GetGiftPoint> createState() => _GetGiftPointState();
}

class _GetGiftPointState extends State<GetGiftPoint> {

  final CollectionReference _task = FirebaseFirestore.instance.collection('task');
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final String userID = FirebaseAuth.instance.currentUser!.uid;


  final textdata3Controller = TextEditingController();

  var FBconfirm_number_student ='';
  var ORconfirm_number_student ='';
  int current_Pgift = 0;
  int Old_Pgift = 0;

  Future<void> UpdatePgift_db() {
    return users
        .doc('$userID')
        .update({
      'Pgift' : current_Pgift,})
        .then((value) => print ("User update"))
        .catchError((error) => print("Failed to update user status : $error"));

  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future:_task.doc('FKJ-A-0-1').get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            FBconfirm_number_student = data['confirm_number_student'];



            return Scaffold(
              appBar: AppBar(
                title: const Text('FILL UP THE NUMBER'),
              ),
              body: Form(child: Padding(padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal:25.0),
                child: ListView(
                  children: [


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('FILL THE BLANK TO GET THE GIFT POINT',style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                      ],),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('REFER THE IFS SCREEN',style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                      ],),
                    const SizedBox(height: 60.0,),


                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        autofocus: false,
                        obscureText: false,
                        decoration: const InputDecoration(
                          labelText: 'NUMBER ON SCREEN: ',
                          hintText: 'ENTER THE NUMBER',
                          labelStyle: TextStyle(fontSize:  20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.black26,
                              fontSize: 15),
                        ),
                        controller: textdata3Controller,
                        validator: (value){
                          if( value == null || value.isEmpty){
                            return 'Please enter a value';
                          }
                          return null;
                        },),
                    ),
                    const SizedBox(height: 5.0,),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed:(){
                            //UpdatePgift_db();
                            ORconfirm_number_student = textdata3Controller.text;
                            if(FBconfirm_number_student == ORconfirm_number_student){
                              print('ok $FBconfirm_number_student = $ORconfirm_number_student');

                              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePgift(userID: userID)));


                            }else{
                              print('not ok -> $FBconfirm_number_student != $ORconfirm_number_student');

                            }
                          }, child: const Text('GET THE REWARD',
                          style: TextStyle(fontSize: 18.0,),
                        ),
                          style: ElevatedButton.styleFrom(fixedSize: const Size(300,50), primary: Colors.blue ),
                        ),

                      ],
                    ),

                  ],
                ),
              )),
            );


          }

          return const Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white,));

        }
    );
  }
}
