import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Constants/textstyle_constant.dart';
import 'package:e_commerce/Screens/cart_page.dart';
import 'package:e_commerce/services/FirebaseAuth_Services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  // for displaying the back Arrow
  final bool hasBackArrow;
  final bool hasBackground;

  //for setting the title values
  final String title;
  final bool hasTitle;

   CustomActionBar(
      {Key key,
      this.hasBackArrow,
      this.title,
      this.hasTitle,
      this.hasBackground})
      : super(key: key);


  //getting the user id. from the firebase_services Package
  FirebaseServices _firebaseServices = FirebaseServices();

  // a new reference for adding to cart indicator
  final CollectionReference _usersRef =
  FirebaseFirestore.instance.collection('Users');

  //================  Getting the User(Another Option)===========
  // User _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // setting the default value for the back arrow  to be invisible
    bool _hasBackArrow = hasBackArrow ?? false;

    // setting the default value for the  title to be visible
    bool _hasTitle = hasTitle ?? true;

    bool _hasBackground = hasBackground ?? true;




    return Container(
      decoration: BoxDecoration(
          gradient: _hasBackground
              ? const LinearGradient(colors: [
                  Colors.white,
                  Colors.white,
                ], begin: Alignment(0, 0), end: Alignment(0, 1))
              : null),
      padding: const EdgeInsets.only(
        top: 56.0,
        bottom: 42.0,
        left: 24.0,
        right: 24.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)

            // Displaying the back Arrow
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(7.0),
                ),
                alignment: Alignment.center,

                // child: Image(
                // image:  AssetImage(
                //     ''
                //   )
                // ),

                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          if (_hasTitle)
            Text(
              // if title is null display the action bar
              title ?? 'Action Bar',
              style: Constant.boldHeading,
            ),
          // Add to cart indicator
          GestureDetector(
            onTap: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
            },
            child: Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(7.0),
                ),
                alignment: Alignment.center,
                child: StreamBuilder(
                    // stream: _usersRef.doc(_user.uid), when using Users _user
                    stream: _usersRef.doc(_firebaseServices.getUserId())
                        .collection('Cart')
                        .snapshots(),
                    builder: (context, snapshot) {
                      // to display the number of items in the cart
                      int _totalItems = 0;

                      if(snapshot.connectionState == ConnectionState.active){
                        //getting the list-Length of items in the cart
                        List _documents = snapshot.data.docs;
                        _totalItems = _documents.length;

                      }
                  return
                 Text( '$_totalItems'?? '0',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white));
                })),
          ),
        ],
      ),
    );
  }
}
