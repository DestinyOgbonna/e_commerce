import 'package:e_commerce/tabs/search_tab.dart';
import 'package:e_commerce/tabs/homepage_tab.dart';
import 'package:e_commerce/tabs/saved_tab.dart';
import 'package:e_commerce/widgets/bottom_tabs.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);

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
          Expanded(
            child: PageView(
              controller: _tabsPageController,
              // ignore: avoid_types_as_parameter_names
              onPageChanged: (num) {
                _selectTab = num;
              },
              children: [
                //Navigation Tabs

                HomeTab(),

                const Search_tab(),

                SavedTab(),
              ],
            ),
          ),
          BottomTabs(
            selectedTab: _selectTab,

            // ignore: avoid_types_as_parameter_names
            tabPressed: (num) {
              _tabsPageController.animateToPage(num,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic);
            },
          ),
        ],
      ),
    ));
  }
}
