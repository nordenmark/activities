import 'package:app/widgets/tab_item.dart';
import 'package:app/widgets/tab_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'single_workout_page.dart';
import 'workout_activities.dart';
import 'workout_graph.dart';
import 'workout_list.dart';

class WorkoutsPage extends HookWidget {
  WorkoutsPage();

  final _duration = const Duration(milliseconds: 300);
  final _curve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> selectedPage = useState(0);

    PageController pageController =
        usePageController(initialPage: selectedPage.value);

    return TabScreen(
      appBar: AppBar(
          title: FutureBuilder(
              future: Future.value(true),
              builder: (BuildContext context, AsyncSnapshot<void> snap) {
                if (!snap.hasData) {
                  return Text('');
                }

                return WorkoutsPageAppBar(
                  titles: [
                    'List',
                    'Graph',
                    'Activities',
                  ],
                  onPageSelected: (int index) {
                    selectedPage.value = index;
                    pageController.animateToPage(index,
                        curve: this._curve, duration: this._duration);
                  },
                  pageController: pageController,
                );
              })),
      body: PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (int index) {
            selectedPage.value = index;
          },
          children: [
            WorkoutList(),
            WorkoutGraph(),
            WorkoutActivities(),
          ]),
      fab: selectedPage.value != 0
          ? null
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SingleWorkoutPage()));
              }),
      tabItem: TabItem.workouts,
    );
  }
}

class WorkoutsPageAppBar extends AnimatedWidget {
  final List<String> titles;
  final ValueChanged<int> onPageSelected;
  final PageController pageController;

  WorkoutsPageAppBar({this.titles, this.onPageSelected, this.pageController})
      : super(listenable: pageController);

  @override
  Widget build(BuildContext context) {
    double xPosition = this.pageController.page - 1;

    return Column(
      children: [
        Row(children: this.getAppBarMenuItems()),
        SizedBox(height: 2),
        Align(
          // @TODO -1 , 0, 1
          alignment: Alignment(xPosition, 1.0),
          child: FractionallySizedBox(
              widthFactor: 1 / 3,
              child: FractionallySizedBox(
                  widthFactor: 1 / 2,
                  child: Container(height: 1, color: Colors.white))),
        ),
      ],
    );
  }

  List<Widget> getAppBarMenuItems() {
    return this
        .titles
        .asMap()
        .entries
        .map((entry) => Expanded(
            child: InkWell(
                onTap: () {
                  this.onPageSelected(entry.key);
                },
                child: Text(
                  entry.value,
                  textAlign: TextAlign.center,
                ))))
        .toList();
  }
}
