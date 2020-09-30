import 'package:authentication_app_flutter/components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import 'dashboard_screen.dart';

final _firestore = FirebaseFirestore.instance;

class RegistrationScreen extends StatefulWidget {

  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String userName;
  String userEmail;
  String userPhone;
  String userAddress;
  String password;


  Future<String>getCurrentUserId() async{
    String uid = ( _auth.currentUser).uid;
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.deepPurpleAccent,
              Colors.red
            ],
          ),
        ),
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/book.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    userName = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Name'
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    userEmail = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Email'
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    userPhone = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Phone Number'
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  keyboardType: TextInputType.streetAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    userAddress = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Address/Locality'
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Password'
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  title: 'Register',
                  colour: Colors.deepPurple,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: userEmail, password: password);
                      if (newUser != null) {
                        DocumentReference docRef = await _firestore.collection('profile').add({
                          'name': userName,
                          'email': userEmail,
                          'address': userAddress,
                          'phone number': userPhone
                        });
                        print('Id of this doc is: ${docRef.id}');
                        String docId = docRef.id;
                        Navigator.pushNamed(context, DashboardScreen.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
