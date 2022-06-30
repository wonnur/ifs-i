import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instant_feedback_system/loginpage/forgotpass.dart';
import 'package:instant_feedback_system/loginpage/ic_auth.dart';
import 'package:instant_feedback_system/loginpage/signup.dart';
import 'package:instant_feedback_system/loginpage/userrole.dart';

class LoginPage extends StatefulWidget {


  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  var role = "";
  String uid = '';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();



  userLogin() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      final String userID = FirebaseAuth.instance.currentUser!.uid;


      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GetUserRole(userID)));

    }on FirebaseAuthException catch(error){
      if(error.code == 'user-not-found'){
        // print('No user found for that name');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text('No user found for that email',
          style: TextStyle(fontSize:18.0, color: Colors.amber),),
        ),
        );
      }
      else if(error.code == 'wrong-password'){
        // print('Wrong password provided by the user ');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text('Wrong password provided by the user',
          style: TextStyle(fontSize: 18.0, color: Colors.amber),),

        ),
        );
      }
    }

  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGIN PAGE'),
      ),
      backgroundColor: Colors.white,
      body: Form(

        key: _formKey,
        child:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
          child: ListView(
              children : [

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(color: Colors.black,
                        fontSize: 15,),
                    ),
                    controller: emailController,
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return 'please enter email';
                      }
                      else if(!value.contains('@')){
                        return 'Please enter a valid email';

                      }
                      return null;
                    },
                  ),

                ),
                const SizedBox(height: 20.0,),
                Container(

                  //padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
                  child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(color: Colors.black,
                        fontSize: 15,),
                    ),
                    controller: passwordController,
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return 'please enter password';
                      }

                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: (){
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            email = emailController.text;
                            password = passwordController.text;

                          });
                          userLogin();

                        }
                      },
                        child: const Text(
                          'Login',
                          style:  TextStyle(fontSize:18.0),
                        ),
                      ),
                      // TextButton(onPressed: (){
                      //   Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPass(),
                      //   ),
                      //   );
                      //
                      // },
                      //   child: const Text(
                      //     'Forget password ?',
                      //     style: TextStyle(fontSize: 12.0),
                      //   ),
                      // ),

                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Do not have account?'),
                      TextButton(onPressed: (){
                        Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context,a,b) => SignUp(), transitionDuration: const Duration(seconds: 0)), (route) => false);
                      },
                        child: const Text('SignUp'),
                      ),
                    ],
                  ),
                ),
              ]
          ),
        ),

      ),

    );
  }
}



