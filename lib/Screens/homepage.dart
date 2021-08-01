import 'package:e_commerce/Constants/textstyle_constant.dart';
import 'package:e_commerce/tabs/search_tab.dart';
import 'package:e_commerce/tabs/homepage_tab.dart';
import 'package:e_commerce/tabs/saved_tab.dart';
import 'package:e_commerce/widgets/bottom_tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();

}

class _HomepageState extends State<Homepage> {
  PageController _tabsPageController;
  int _selectTab = 0;

  @override
  void initState() {
   _tabsPageController = PageController();
    super.initState();
  }
 @override
  void dispose() {
    _tabsPageController;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Container(
            child: Expanded(
              child: PageView(
                controller: _tabsPageController,
                onPageChanged:(num){
                    _selectTab = num;
                } ,
                children: [
                  //Navigation Tabs

                 HomeTab(),

                  Search_tab(),

                 SavedTab( ),

                ],
              ),
            )

          ),


         BottomTabs  (
            selectedTab: _selectTab,


           tabPressed: (num){

              _tabsPageController.animateToPage
                (num, duration: Duration(milliseconds: 300), curve: Curves.easeOutCubic);

           },
          ),
         ],
      ),
    ));
  }
}
