import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instant_feedback_system/loginpage/loginpage.dart';

class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String dropdownValue = 'STUDENT';


  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference reward_student = FirebaseFirestore.instance.collection('reward_student');
  CollectionReference reward_cleaner = FirebaseFirestore.instance.collection('reward_cleaner');
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;


  var textName ='';
  var textIc ='';
  var data1 ='';
  var textRole ='';
  var email = '';
  var role = '';
  var password =  '';
  var confirmPassword = '';
  var uid = '';
  int Pgift = 100;


  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final textNameController = TextEditingController();
  final textIcController = TextEditingController();
  final textRoleController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> addUser_student(){

    final String UserId =FirebaseAuth.instance.currentUser!.uid;
    print(UserId);
    uid = UserId;
    textName =textNameController.text;
    textIc =textIcController.text;
    return users.doc(uid).set({
      'Name': textName,
      'IC number' : textIc,
      'role' : data1,
      'uid' : uid,
      'Pgift' : Pgift,
    }).then((value) => print("user added"))
        .catchError((error) => print("Failed to add user"));
  }

  Future<void> addFirstReward(){

    final String UserId =FirebaseAuth.instance.currentUser!.uid;

    print(UserId);
    uid = UserId;
    textName =textNameController.text;
    textIc =textIcController.text;
    return reward_student.doc(uid).set({
      's_reward': 'BOOK COUPON',
      'reward_reference' : 'UMS-FKJ-#00001-RM5',
      'uid' : uid,
      'Pgift_used' : 0,
    }).then((value) => print("first reward added added"))
        .catchError((error) => print("Failed to add reward"));
  }

  Future<void> addFirstReward_Cleaner(){

    final String UserId =FirebaseAuth.instance.currentUser!.uid;

    print(UserId);
    uid = UserId;
    textName =textNameController.text;
    textIc =textIcController.text;
    return reward_cleaner.doc(uid).set({
      'c_reward': 'CLASS TRAINING',
      'reference_number' : 'UMS-FKJ-CS-#00001-RM5',
      'uid' : uid,
      'Pgift_used' : 0,
    }).then((value) => print("first reward added added"))
        .catchError((error) => print("Failed to add reward"));
  }

  Future<void> addUser_management(){

    final String UserId =FirebaseAuth.instance.currentUser!.uid;
    print(UserId);
    uid = UserId;
    textName =textNameController.text;
    textIc =textIcController.text;
    return users.doc(uid).set({
      'Name': textName,
      'IC number' : textIc,
      'role' : data1,
      'uid' : uid,
    }).then((value) => print("user added"))
        .catchError((error) => print("Failed to add user"));
  }



  registration() async{
    if(password == confirmPassword){
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        print (userCredential);


        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text('Registered Successfully , Please Sign In',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        );
        if(data1 == 'STUDENT' ){
          addFirstReward();
          addUser_student();
        }

        if(data1 == 'MANAGEMENT'){
          addUser_management();
        }

        if(data1 == 'CLEANER'){
          addFirstReward_Cleaner();
          addUser_student();
        }

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const LoginPage(),),);

      } on FirebaseAuthException catch(error){
        if(error.code=='weak-password'){
          print (' Password is too weak ');

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.black26,
            content: Text('Password is too weak',
              style: TextStyle(fontSize: 20.0, color: Colors.amberAccent),
            ),
          ),
          );

        }
        else if(error.code == 'email-already-in-use'){
          print ('Account is already exist ');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.black26,
            content: Text('Account is already exist',
              style: TextStyle(fontSize: 20.0, color: Colors.amberAccent),
            ),
          ),
          );
        }



      }

    }
    else{
      print ('Password and Confirm Password does not match');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.black26,
        content: Text('Password and Confirm Password does not match',
          style: TextStyle(fontSize: 20.0, color: Colors.amberAccent),
        ),
      ),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(30.0),
                //child: Image.asset("images/signup.png"),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'EMAIL: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.black26, fontSize: 15.0),


                  ),
                  controller: emailController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter email';
                    }
                    else if (!value.contains('@')){
                      return 'Please enter a valid email';

                    }
                    return null;
                  },
                ),

              ),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: ' PASSWORD: ',
                    labelStyle: TextStyle(fontSize:  20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.black26,
                        fontSize: 15),
                  ),
                  controller: passwordController,
                  validator: (value){
                    if( value == null || value.isEmpty){
                      return 'Please enter Password';
                    }
                    return null;

                  },
                ),

              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: ' CONFIRM PASSWORD: ',
                    labelStyle: TextStyle(fontSize:  20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.black26,
                        fontSize: 15),
                  ),
                  controller: confirmPasswordController,
                  validator: (value){
                    if( value == null || value.isEmpty){
                      return 'Please enter Confirm Password';
                    }
                    return null;

                  },
                ),


              ),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'FULL NAME: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.black26, fontSize: 15.0),


                  ),
                  controller: textNameController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter Name';
                    }

                    return null;
                  },
                ),

              ),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'NUMBER IC: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.black26, fontSize: 15.0),


                  ),
                  controller: textIcController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter Age';
                    }
                    return null;
                  },
                ),

              ),

              const SizedBox(height: 15,),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [const Text('USER ROLE: ',)],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(

                    value: dropdownValue,
                    style: const TextStyle(color: Colors.blue,fontSize: 20),
                    onChanged: (String? newValue){
                      setState(() {
                        dropdownValue = newValue!;
                        data1 = dropdownValue;


                      });
                    },
                    items: <String>['STUDENT','MANAGEMENT','CLEANER']
                        .map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),

                  )],
              ),

              const SizedBox(height: 15,),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){
                      if(_formKey.currentState!.validate()){

                      }
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          email = emailController.text;
                          password = passwordController.text;
                          confirmPassword = confirmPasswordController.text;
                          data1 = dropdownValue;

                        });
                        registration();
                      }
                    },
                      child: const Text('SignUP',
                        style: TextStyle(fontSize: 18.0),),
                    )
                  ],
                ),

              ),




              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('already have account ? '),
                    TextButton(onPressed: (){
                      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => const LoginPage(),
                        transitionDuration: const Duration(seconds: 0),),);

                    },
                      child: const Text('login'),),
                  ],

                ),


              ),
            ],

          ),

        ),


      ),

    );
  }
}
