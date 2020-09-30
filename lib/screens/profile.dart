import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'registration_screen.dart';

User loggedInUser;
FirebaseFirestore _firestore = FirebaseFirestore.instance;//Firestore
CollectionReference docRef = _firestore.collection('profile');


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
   // getUserById();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }


  //getUserById() {
    // final usersRef = FirebaseFirestore.instance.collection('profile').doc();
    // String myId = usersRef.id;
    // print('id is: $myId');
  //}
    final usersRef = FirebaseFirestore.instance.collection('profile').id;

  Stream<DocumentSnapshot> provideDocumentFieldStream() {
    return FirebaseFirestore.instance
        .collection('profile')
        .doc(usersRef)
        .snapshots();
  } //'t0OcV7AYQPfkf3AMvPyW'

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Expanded(
            child: Center(
              child: Card(
                elevation: 10.0,
                margin: EdgeInsets.only(
                    left: 15.0, right: 15.0, bottom: 50.0, top: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.white,
                        Colors.pinkAccent,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Expanded(
                      child: Column(
                        children: <Widget>[
                          Flexible(
                            child: Card(
                              elevation: 10.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(58.0),
                              ),
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage:
                                    AssetImage("images/prof.png"),
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                            width: 170.0,
                            child: Divider(
                              color: Colors.white,
                              thickness: 1.5,
                            ),
                          ),
                          StreamBuilder<DocumentSnapshot>(//StreamBuilder<DocumentSnapshot>
                            stream: provideDocumentFieldStream(),
                            // stream: _firestore.collection('profile').snapshots(),
                            // ignore: missing_return
                            builder: (context, snapshot) {
                              final userDocument = snapshot.data;
                              Query userQuery = docRef.where('email', isEqualTo: loggedInUser.email);

                              if (snapshot.hasData) {
                                return Column(
                                  children: [
                                    Card(
                                      elevation: 10.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 25.0),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.email,
                                          color: Colors.pinkAccent,
                                        ),
                                        title: Text(
                                          loggedInUser.email,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.pinkAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 10.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 25.0),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.person,
                                          color: Colors.pinkAccent,
                                        ),
                                        title: Text(
                                          'name',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.pinkAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 10.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 25.0),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.location_on,
                                          color: Colors.pinkAccent,
                                        ),
                                        title: Text(
                                          'userAddress',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.pinkAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 10.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 25.0),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.phone,
                                          color: Colors.pinkAccent,
                                        ),
                                        title: Text(
                                          'userPhone',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.pinkAccent,
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

