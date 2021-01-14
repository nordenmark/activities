import 'package:flutter/material.dart';

import 'bottom_navbar.dart';
import 'spinner.dart';
import 'tab_item.dart';

class TabScreen extends StatelessWidget {
  final AppBar appBar;
  final Widget body;
  final TabItem tabItem;
  final FloatingActionButton fab;
  final bool isLoading;
  final String isLoadingText;

  const TabScreen(
      {Key key,
      this.appBar,
      @required this.body,
      @required this.tabItem,
      this.fab,
      this.isLoading = false,
      this.isLoadingText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: this.appBar.title,
        brightness: Brightness.dark,
      ),
      body: this.isLoading ? Spinner(text: this.isLoadingText) : this.body,
      floatingActionButton: this.fab,
      bottomNavigationBar: WorkoutsBottomNavigationBar(
        selectedTab: this.tabItem,
      ),
    );
  }
}
