import 'package:app/models/workout.model.dart';
import 'package:app/root/tab_item.dart';
import 'package:app/settings/settings_tab.dart';
import 'package:app/utils/styles.dart';
import 'package:app/widgets/spinner.dart';
import 'package:app/workouts/dashboard_page.dart';
import 'package:app/workouts/single_workout_page.dart';
import 'package:app/workouts/workouts_page.dart';
import 'package:app/workouts/workouts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

final selectedTabProvider = StateProvider<TabItem>((ref) => TabItem.dashboard);

class HomeScreen extends HookWidget {
  final Map<TabItem, String> tabLabels = {
    TabItem.dashboard: 'DASHBOARD',
    TabItem.workouts: 'WORKOUTS',
    TabItem.challenges: 'CHALLENGES',
    TabItem.more: 'MORE',
  };

  Map<TabItem, WidgetBuilder> widgetBuilders(List<Workout> workouts) {
    return {
      TabItem.dashboard: (context) {
        return DashboardPage(workouts: workouts);
      },
      TabItem.workouts: (context) {
        return WorkoutsPage(workouts: workouts);
      },
      TabItem.challenges: (_) {
        return Text('Challenges');
      },
      TabItem.more: (_) {
        return SettingsTab();
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
      TabItem.challenges: (_) => null,
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
          return watch(workoutsControllerProvider.state).when(
              data: (workouts) =>
                  this.widgetBuilders(workouts)[selectedTab.state](context),
              loading: () => Center(child: Spinner()),
              error: (e, stack) => Text(e.toString()));
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
