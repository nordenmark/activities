import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

enum TabItem { dashboard, workouts, challenges, friends, more }

class TabItemData {
  const TabItemData({@required this.title, @required this.icon, activeIcon})
      : activeIcon = activeIcon ?? icon;

  final String title;
  final IconData icon;
  final IconData activeIcon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.dashboard: TabItemData(
      title: 'Dashboard',
      icon: MaterialCommunityIcons.flag_variant_outline,
      activeIcon: MaterialCommunityIcons.flag_variant,
    ),
    TabItem.workouts: TabItemData(
      title: 'Workouts',
      icon: MaterialCommunityIcons.run,
      activeIcon: MaterialCommunityIcons.run_fast,
    ),
    TabItem.challenges: TabItemData(
      title: 'Challenges',
      icon: MaterialCommunityIcons.dumbbell,
    ),
    TabItem.friends: TabItemData(
        title: 'Friends', icon: MaterialCommunityIcons.account_group),
    TabItem.more: TabItemData(
      title: 'More',
      icon: MaterialCommunityIcons.menu,
    ),
  };
}
