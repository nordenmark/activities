import 'package:app/models/challenge.model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class ChallengesState extends Equatable {
  final List<Challenge> challenges;
  final bool isLoading;

  ChallengesState({this.challenges, this.isLoading});

  const ChallengesState.initial()
      : challenges = const [],
        isLoading = false;

  @override
  List<Object> get props => [challenges, isLoading];

  ChallengesState copyWith({List<Challenge> challenges, bool isLoading}) {
    return ChallengesState(
        challenges: challenges ?? this.challenges,
        isLoading: isLoading ?? this.isLoading);
  }
}
