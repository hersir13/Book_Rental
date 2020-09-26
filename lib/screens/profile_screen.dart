import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: FutureBuilder(
        future: _getCurrentUserData(),
        builder: (ctx, futureSnapshot2) {
          if (futureSnapshot2.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Container(
              height: 400,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(5, 5), // changes position of shadow
                  ),
                  BoxShadow(
                    color: Colors.green[50],
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(-5, -5), // changes position of shadow
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(5, 5), // changes position of shadow
                              ),
                              BoxShadow(
                                color: Colors.grey[200],
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(
                                    -5, -5), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              image: NetworkImage(
                                futureSnapshot2.data.data()['image_url'],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ],
                  ),
                  if (!isEdit)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          futureSnapshot2.data.data()['username'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  if (isEdit)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Edit mode on',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        futureSnapshot2.data.data()['email'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isEdit = !isEdit;
          });
        },
        child: Icon(Icons.edit),
        backgroundColor: Colors.green[900],
      ),
    );
  }

  Future<DocumentSnapshot> _getCurrentUserData() async {
    // ignore: deprecated_member_use
    // ignore: await_only_futures
    User user = await FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    print(userData.data());
    return userData;
  }
}
