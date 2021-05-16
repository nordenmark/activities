import 'package:app/models/workout.model.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/custom_input.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/tag_cloud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

typedef OnSaveCallback = Function(
    {@required DateTime date, @required String activity});
typedef OnDeleteCallback = Function(Workout workout);

class WorkoutForm extends HookWidget {
  final OnSaveCallback onSave;
  final Iterable<String> activitySuggestions;
  final Workout workout;
  final OnDeleteCallback onDelete;

  WorkoutForm(
      {@required this.activitySuggestions,
      @required this.onSave,
      @required this.workout,
      this.onDelete});

  @override
  Widget build(BuildContext context) {
    var initialDate = this.workout == null ? DateTime.now() : this.workout.date;
    var initialActivity = this.workout == null ? '' : this.workout.activity;

    final dateController = useTextEditingController(
        text: DateFormat('y-MM-dd').format(initialDate));
    final activityController = useTextEditingController(text: initialActivity);

    return ListView(
      children: [
        ListTile(
            leading:
                const Icon(MaterialCommunityIcons.calendar_month, size: 30),
            title: CustomInput(
                controller: dateController,
                label: 'Date',
                onTap: () async {
                  // Below line stops keyboard from appearing
                  FocusScope.of(context).requestFocus(new FocusNode());

                  DateTime dateTime = await showDatePicker(
                      context: context,
                      locale: const Locale('sv', 'SE'),
                      initialDate: this.workout == null
                          ? DateTime.now()
                          : this.workout.date,
                      firstDate: DateTime.now().subtract(Duration(days: 1000)),
                      lastDate: DateTime.now().add(Duration(days: 2)));

                  if (dateTime != null) {
                    // Update visual value
                    dateController.text =
                        DateFormat('y-MM-dd').format(dateTime);
                  }
                })),
        ListTile(
          leading: const Icon(
            MaterialCommunityIcons.table_tennis,
            size: 30,
          ),
          title: CustomInput(label: 'Activity', controller: activityController),
        ),
        ListTile(
          title: CustomText('Activity suggestions', type: TextType.H5),
        ),
        ListTile(
          title: TagCloud(
              tags: this.activitySuggestions,
              onSelected: (activity) {
                activityController.text = activity;
              }),
        ),
        ListTile(
          title: Button(
              label: this.workout == null
                  ? 'Create new workout'
                  : 'Update workout',
              onPressed: () {
                if (dateController.text.isEmpty ||
                    activityController.text.isEmpty) {
                  _showWarning(context);
                  return;
                }

                this.onSave(
                    date: DateTime.parse(dateController.text),
                    activity: activityController.text);
              }),
        ),
        ListTile(
            title: Button(
          type: ButtonType.DANGER,
          label: 'Delete workout',
          onPressed: this.workout == null || this.onDelete == null
              ? null
              : () {
                  this.onDelete(this.workout);
                },
        ))
      ],
    );
  }

  _showWarning(BuildContext context) {
    final snackBar = SnackBar(content: Text('Oops! Missing date or activity!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
