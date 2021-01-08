import 'package:app/models/workout.model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
class WorkoutsState extends Equatable {
  final List<Workout> workouts;
  final bool isLoading;

  WorkoutsState({this.workouts, this.isLoading});

  const WorkoutsState.initial()
      : workouts = const [],
        isLoading = false;

  @override
  List<Object> get props => [workouts, isLoading];

  WorkoutsState copyWith({List<Workout> workouts, bool isLoading}) {
    return WorkoutsState(
        workouts: workouts ?? this.workouts,
        isLoading: isLoading ?? this.isLoading);
  }
}
