import 'package:app/models/challenge.model.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/centered_form.dart';
import 'package:app/widgets/custom_input.dart';
import 'package:app/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

class AddChallengeForm extends HookWidget {
  final bool isLoading;
  final Function(Challenge) onSubmit;

  AddChallengeForm({Key key, this.isLoading, @required this.onSubmit})
      : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DateTime fromDate = DateTime.now();
    String fromDateString = DateFormat('y-MM-dd').format(fromDate);

    DateTime toDate = fromDate.add(Duration(days: 30));
    String toDateString = DateFormat('y-MM-dd').format(toDate);

    final nameController = useTextEditingController();
    final fromDateController = useTextEditingController(text: fromDateString);
    final toDateController = useTextEditingController(text: toDateString);

    List<Widget> formElements = [
      CustomInput(
          label: 'Challenge name',
          icon: FlutterIcons.dumbbell_mco,
          controller: nameController,
          validator: (value) =>
              value.toString().isNotEmpty ? null : 'A name is required'),
      CustomInput(
          label: 'Start date',
          icon: FlutterIcons.calendar_mco,
          controller: fromDateController,
          validator: (value) => DateTime.tryParse(value) == null
              ? 'Invalid start date given'
              : null,
          onTap: () async {
            // Below line stops keyboard from appearing
            FocusScope.of(context).requestFocus(new FocusNode());

            DateTime dateTime = await showDatePicker(
                context: context,
                locale: const Locale('sv', 'SE'),
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(Duration(days: 1000)),
                lastDate: DateTime.now().add(Duration(days: 2)));

            if (dateTime != null) {
              fromDateController.text = DateFormat('y-MM-dd').format(dateTime);
            }
          }),
      CustomInput(
          label: 'End date',
          icon: FlutterIcons.calendar_mco,
          controller: toDateController,
          validator: (value) {
            var date = DateTime.tryParse(value);

            if (date == null) {
              return 'Invalid end date given';
            }

            var fromDate = DateTime.tryParse(fromDateController.text);

            if (fromDate == null || fromDate.isAfter(date)) {
              return 'End date needs to be after start date';
            }

            return null;
          },
          onTap: () async {
            // Below line stops keyboard from appearing
            FocusScope.of(context).requestFocus(new FocusNode());

            DateTime dateTime = await showDatePicker(
                context: context,
                locale: const Locale('sv', 'SE'),
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(Duration(days: 1000)),
                lastDate: DateTime.now().add(Duration(days: 2)));

            if (dateTime != null) {
              toDateController.text = DateFormat('y-MM-dd').format(dateTime);
            }
          }),
      Button(
          label: 'Submit',
          onPressed: this.isLoading
              ? null
              : () {
                  if (!this._formKey.currentState.validate()) {
                    return;
                  }

                  var challenge = Challenge(
                      fromDate: DateTime.parse(fromDateController.text),
                      toDate: DateTime.parse(toDateController.text),
                      name: nameController.text);

                  this.onSubmit(challenge);
                }),
    ];

    if (this.isLoading) {
      formElements.add(Spinner(text: 'Creating...'));
    }

    return CenteredForm(
      formKey: _formKey,
      children: formElements,
    );
  }
}
