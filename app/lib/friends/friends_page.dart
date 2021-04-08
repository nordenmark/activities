import 'package:app/auth/auth_controller.dart';
import 'package:app/friends/friends_controller.dart';
import 'package:app/models/friend.model.dart';
import 'package:app/models/user.model.dart';
import 'package:app/models/workout.model.dart';
import 'package:app/widgets/line_chart.dart';
import 'package:app/widgets/spinner.dart';
import 'package:app/widgets/tab_item.dart';
import 'package:app/widgets/tab_screen.dart';
import 'package:app/widgets/year_selector.dart';
import 'package:app/workouts/workouts_controller.dart';
import 'package:app/workouts/workouts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final selectedYearProvider = StateProvider<int>((ref) => DateTime.now().year);

// @TODO get target from settings
final targetProvider = StateProvider<int>((ref) {
  final selectedYear = ref.watch(selectedYearProvider).state;

  return selectedYear == 2020 ? 130 : 156;
});

final friendsWorkoutsProvider =
    FutureProvider.family.autoDispose<List<Workout>, int>((ref, year) {
  final workoutsService = ref.read(workoutsServiceProvider);

  return workoutsService.getForFriends().then((workouts) {
    return workouts.where((workout) => workout.date.year == year).toList();
  });
});

class FriendsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final selectedYear = useProvider(selectedYearProvider).state;
    final target = useProvider(targetProvider).state;
    final currentUser = useProvider(authControllerProvider).user;
    final forFriends = useProvider(friendsWorkoutsProvider(selectedYear));

    if (forFriends.data == null) {
      return TabScreen(
          appBar: AppBar(title: Text('FRIENDS')),
          tabItem: TabItem.friends,
          body: Spinner());
    }

    final List<Workout> workouts =
        useProvider(workoutsForYearProvider(selectedYear));
    final List<Workout> friendsWorkouts = forFriends.data.value;
    final List<Friend> friends = useProvider(friendsControllerProvider).friends;

    final chartData = Map<String, List<LineChartPoint>>();

    friends.forEach((friend) {
      chartData[friend.name] =
          _getChartDataForUser(selectedYear, friend.name, friendsWorkouts);
    });

    chartData[currentUser.name] =
        _getChartDataForUser(selectedYear, currentUser.name, workouts);

    return TabScreen(
        appBar: AppBar(title: Text('FRIENDS')),
        tabItem: TabItem.friends,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              YearSelector(
                selectedYear: selectedYear,
                onSelected: (int year) {
                  context.read(selectedYearProvider).state = year;
                },
              ),
              Expanded(
                  child: LineChart(
                      data: chartData, maxValue: 200, target: target)),
            ],
          ),
        ));
  }

  List<LineChartPoint> _getChartDataForUser(
      int year, String user, List<Workout> workouts) {
    List<LineChartPoint> list = [];

    DateTime from = DateTime.utc(year, 1, 1);
    DateTime pointer = from;

    int counter = 0;

    while (pointer.year == from.year) {
      counter += getCountForDate(pointer, workouts);

      list.add(LineChartPoint(
        date: pointer,
        count: counter,
      ));

      pointer = pointer.add(Duration(days: 1));
    }

    return list;
  }

  int getCountForDate(DateTime date, List<Workout> workouts) {
    int count = 0;

    workouts.forEach((workout) {
      if (DateFormat('y-MM-dd').format(workout.date) ==
          DateFormat('y-MM-dd').format(date)) {
        count++;
      }
    });

    return count;
  }
}
