import 'package:e_commerce/Constants/textstyle_constant.dart';
import 'package:e_commerce/Screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'login.dart';

//=====================This page controls the  database nav========================
// ignore: use_key_in_widget_constructors
class LandPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}',
                    style: Constant.regularHeading),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            //============= Login Check Start =================
            // added a stream builder to check the login stage
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, streamsnapshot) {
                  if (streamsnapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text('Error: ${streamsnapshot.error}',
                            style: Constant.regularHeading),
                      ),
                    );
                  }
                  //if connection state is active- do a user login check using the if statement
                  if (streamsnapshot.connectionState ==
                      ConnectionState.active) {
                    //Get the user
                    User _user = streamsnapshot.data;
                    // if user is == null, user not logged in return to login page
                    if (_user == null) {
                      return Login();
                    } else {
                      //go to the home page
                      return const Homepage();
                    }
                  }
                  //============= Login Check End =================

                  //checking the auth state
                  return Scaffold(
                    // ignore: avoid_unnecessary_containers
                    body: Container(
                      child: const Center(
                        child:
                            Text('Welcome ...', style: Constant.regularHeading),
                      ),
                    ),
                  );
                });
          }

          return Scaffold(
            // ignore: avoid_unnecessary_containers
            body: Container(
              child: const Center(
                child:
                    Text('Initializing App..', style: Constant.regularHeading),
              ),
            ),
          );
        });
  }
}
