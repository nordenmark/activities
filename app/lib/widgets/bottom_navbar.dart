import 'package:app/challenges/challenges_page.dart';
import 'package:app/settings/settings_page.dart';
import 'package:app/utils/styles.dart';
import 'package:app/workouts/dashboard_page.dart';
import 'package:app/workouts/workouts_page.dart';
import 'package:flutter/material.dart';

import 'tab_item.dart';

class WorkoutsBottomNavigationBar extends StatelessWidget {
  final TabItem selectedTab;

  WorkoutsBottomNavigationBar({Key key, @required this.selectedTab})
      : super(key: key);

  final Map<TabItem, Widget> widgetsMap = {
    TabItem.dashboard: DashboardPage(),
    TabItem.workouts: WorkoutsPage(),
    TabItem.challenges: ChallengesPage(),
    TabItem.more: SettingsPage(),
  };

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Styles.appPrimaryColor,
      unselectedItemColor: Styles.appDiscreteColor,
      items: [
        _buildItem(TabItem.dashboard),
        _buildItem(TabItem.workouts),
        _buildItem(TabItem.challenges),
        _buildItem(TabItem.more),
      ],
      currentIndex: TabItem.values.indexOf(this.selectedTab),
      onTap: (int index) {
        // Route push
        if (this.selectedTab == TabItem.values[index]) {
          return;
        }

        print("on tap! ${TabItem.values[index]}");
        Navigator.of(context).pushReplacement(PageRouteBuilder(
            transitionDuration: Duration(seconds: 0),
            pageBuilder: (context, _, __) =>
                this.widgetsMap[TabItem.values[index]]));
        // selectedTab.state = TabItem.values[index];
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];

    return BottomNavigationBarItem(
      icon: Icon(
        itemData.icon,
      ),
      activeIcon: Icon(
        itemData.activeIcon,
      ),
      label: itemData.title,
    );
  }
}
