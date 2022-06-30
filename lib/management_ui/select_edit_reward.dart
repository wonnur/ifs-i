import 'package:flutter/material.dart';
import 'package:instant_feedback_system/management_ui/update_setting_reward.dart';

class SelectSettingReward extends StatefulWidget {


  @override
  State<SelectSettingReward> createState() => _SelectSettingRewardState();
}

class _SelectSettingRewardState extends State<SelectSettingReward> {
  var reward_name = '';

  _OpenUpdateSettingReward(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateSettingReward(reward_name : reward_name)));


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SELECT SETTING TO EDIT'),),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              reward_name = 'BOOK COUPON';
              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateSettingReward(reward_name : reward_name)));},
              child: const Text(
                'BOOK COUPON',
                style: TextStyle(fontSize: 18.0,),
              ),
              style: ElevatedButton.styleFrom(fixedSize: const Size(300, 100), primary: Colors.blue),
            ),
          ],
        ),

        Row(children: const [Text('')],),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              reward_name = 'FOOD COUPON';
              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateSettingReward(reward_name : reward_name)));
              },
              child: const Text(
                'FOOD COUPON',
                style: TextStyle(fontSize: 18.0,),
              ),
              style: ElevatedButton.styleFrom(fixedSize: const Size(300, 100), primary: Colors.blue),
            ),
          ],
        ),
        Row(children: const [Text('')],),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){

              reward_name = 'CLASS TRAINING';
              print(reward_name);
              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateSettingReward(reward_name : reward_name)));
            },
              child: const Text(
                'CLASS TRAINING',
                style: TextStyle(fontSize: 18.0,),
              ),
              style: ElevatedButton.styleFrom(fixedSize: const Size(300, 100), primary: Colors.blue),
            ),
          ],
        ),
        Row(children: const [Text('')],),

      ],
    ),);

  }
}

