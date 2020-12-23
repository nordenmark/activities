import 'package:app/challenges/challenges_page.dart';
import 'package:app/challenges/single_challenge_page.dart';
import 'package:app/root/tab_item.dart';
import 'package:app/settings/settings_page.dart';
import 'package:app/utils/styles.dart';
import 'package:app/workouts/dashboard_page.dart';
import 'package:app/workouts/single_workout_page.dart';
import 'package:app/workouts/workouts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

final selectedTabProvider = StateProvider<TabItem>((ref) => TabItem.challenges);

class HomeScreen extends HookWidget {
  final Map<TabItem, String> tabLabels = {
    TabItem.dashboard: 'DASHBOARD',
    TabItem.workouts: 'WORKOUTS',
    TabItem.challenges: 'CHALLENGES',
    TabItem.more: 'MORE',
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.dashboard: (context) {
        return DashboardPage();
      },
      TabItem.workouts: (context) {
        return WorkoutsPage();
      },
      TabItem.challenges: (_) {
        return ChallengesPage();
      },
      TabItem.more: (_) {
        return SettingsPage();
      }
    };
  }

  Map<TabItem, WidgetBuilder> get fabBuilders {
    return {
      TabItem.dashboard: (_) => null,
      TabItem.workouts: (context) {
        return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SingleWorkoutPage()));
            });
      },
      TabItem.challenges: (context) {
        return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SingleChallengePage()));
            });
      },
      TabItem.more: (_) => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = useProvider(selectedTabProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(this.tabLabels[selectedTab.state]),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          return this.widgetBuilders[selectedTab.state](context);
        },
      ),
      floatingActionButton: fabBuilders[selectedTab.state](context),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Styles.appPrimaryColor,
        unselectedItemColor: Styles.appDiscreteColor,
        items: [
          _buildItem(TabItem.dashboard),
          _buildItem(TabItem.workouts),
          _buildItem(TabItem.challenges),
          _buildItem(TabItem.more),
        ],
        currentIndex: TabItem.values.indexOf(selectedTab.state),
        onTap: (int index) {
          selectedTab.state = TabItem.values[index];
        },
      ),
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
