import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {

  final int selectedTab;
  final Function(int) tabPressed;

  const BottomTabs({Key key, this.selectedTab, this.tabPressed}) : super(key: key);
  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {

  //setting it for the navigation
     int _selected = 0;

  @override
  Widget build(BuildContext context) {
    _selected = widget.selectedTab ?? 0;
    return Container(
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(0.07),
            spreadRadius: 1.0,
            blurRadius: 30.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabsBtn(
            imagePath: 'images/icons/icons_home.png',
            isTabSelected: _selected == 0 ? true : false,
            onPressed: (){
             widget.tabPressed(0);
            },
          ),
          BottomTabsBtn(
            imagePath: 'images/icons/icons_cart.png',
            isTabSelected: _selected == 1 ? true : false,
            onPressed: (){
              widget.tabPressed(1);
            },
          ),
          BottomTabsBtn(
            imagePath: 'images/icons/icons_favourite.png',
            isTabSelected: _selected == 2 ? true : false,
            onPressed: (){
              widget.tabPressed(2);
            },
          ),
          BottomTabsBtn(
            imagePath: 'images/icons/icon_logout.png',
            isTabSelected: _selected == 3 ? true : false,
            onPressed: (){
            FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}

class BottomTabsBtn extends StatelessWidget {
  final String imagePath;
  // bool for the  selected navbar.
  final bool isTabSelected;
  // onclick listener for the tab navigation
  final Function onPressed;

  const BottomTabsBtn({Key key, this.imagePath, this.isTabSelected, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
// if there is no value to selected in the navBar return false
    bool _isTabSelected = isTabSelected ?? false;

    return  GestureDetector(
      onTap: onPressed,
      child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 28),
          decoration: BoxDecoration(
            border:Border(
              top: BorderSide(
                // if this tab is selected show the accent color else transparent.
                color: _isTabSelected ? Theme.of(context).colorScheme.secondary : Colors.transparent,
                width: 2,
              )

            )
          ),
          child: Image(
            image: AssetImage(imagePath ?? 'images/icons/icon_logout.png'),
            width: 23,
            height: 23,

            //if the icon tab is selected color = orange  else color = black
            color:  _isTabSelected ? Theme.of(context).colorScheme.secondary: Colors.black54 ,
          ),

      ),
    );
  }
}
