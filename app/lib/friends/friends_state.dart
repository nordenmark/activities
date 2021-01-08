import 'package:app/models/friend.model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
class FriendsState extends Equatable {
  final List<Friend> friends;
  final bool isLoading;

  FriendsState({this.friends, this.isLoading});

  const FriendsState.initial()
      : friends = const [],
        isLoading = false;

  @override
  List<Object> get props => [friends, isLoading];

  FriendsState copyWith({List<Friend> friends, bool isLoading}) {
    return FriendsState(
        friends: friends ?? this.friends,
        isLoading: isLoading ?? this.isLoading);
  }
}
