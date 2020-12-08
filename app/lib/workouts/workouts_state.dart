import 'package:app/models/workout.model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
class WorkoutsState extends Equatable {
  final List<Workout> workouts;

  WorkoutsState({this.workouts});

  const WorkoutsState.initial() : workouts = const [];

  @override
  List<Object> get props => [workouts];

  WorkoutsState copyWith({List<Workout> workouts}) {
    return WorkoutsState(workouts: workouts ?? this.workouts);
  }
}
