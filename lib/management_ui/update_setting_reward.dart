import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateSettingReward extends StatefulWidget {

  final String? reward_name;
  UpdateSettingReward({this.reward_name});



  @override
  State<UpdateSettingReward> createState() => _UpdateSettingRewardState();
}

class _UpdateSettingRewardState extends State<UpdateSettingReward> {

  final CollectionReference reward_standard = FirebaseFirestore.instance.collection('reward_standard');

  String? reward_name;

  final textdata3Controller = TextEditingController();
  final textdata4Controller = TextEditingController();
  var value = "";
  var unit = "";
  var Pgift = "";



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reward_name = widget.reward_name;

  }
  Future<void> UpdateSetting_RewardFirebase() {
    value = textdata3Controller.text;
    unit = textdata4Controller.text;
    return reward_standard
        .doc('$reward_name')
        .update({
      'value' : value,
      'unit' : unit,})
        .then((value) => print ("User update"))
        .catchError((error) => print("Failed to update user status : $error"));

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future:reward_standard.doc(reward_name).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            print(reward_standard);
            print("userID");
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            value = data['value'];
            unit = data['unit'];
            Pgift = data['Pgift'];

            return Scaffold(
                appBar: AppBar(
                  title: const Text('UPDATE REWARD SETTING'),
                ),

                body: Form(child: Padding(padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal:25.0),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('REWARD TO CHANGE : $reward_name',style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                        ],),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('VALUE PER COUPON : RM $value',style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                        ],),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('UNIT LEFT : $unit',style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                        ],),
                      const SizedBox(height: 60.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('FILL TO CHANGE',style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
                        ],),

                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          autofocus: false,
                          obscureText: false,
                          decoration: const InputDecoration(
                            labelText: ' VALUE PER COUPON : ',
                            hintText: 'ENTER THE VALUE',
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


                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          autofocus: false,
                          obscureText: false,
                          decoration: const InputDecoration(
                            labelText: ' UNIT PER COUPON : ',
                            hintText: 'ENTER THE UNIT',
                            labelStyle: TextStyle(fontSize:  20.0),
                            border: OutlineInputBorder(),
                            errorStyle:
                            TextStyle(color: Colors.black26,
                                fontSize: 15),
                          ),
                          controller: textdata4Controller,
                          validator: (value){
                            if( value == null || value.isEmpty){
                              return 'Please enter a value';
                            }
                            return null;
                          },),
                      ),
                      const SizedBox(height: 20.0,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed:UpdateSetting_RewardFirebase, child: const Text('UPDATE REWARD SETTING',
                            style: TextStyle(fontSize: 18.0,),
                          ),
                            style: ElevatedButton.styleFrom(fixedSize: const Size(300,50), primary: Colors.blue ),
                          ),

                        ],
                      ),

                    ],
                  ),
                ))
            );


          }

          return const Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white,));

        }
    );



  }
}
