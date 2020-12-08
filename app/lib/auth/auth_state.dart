import 'package:app/auth/tokens.dart';
import 'package:app/models/user.model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
class AuthState extends Equatable {
  final User user;
  final Token accessToken;
  final Token refreshToken;

  AuthState({this.user, this.accessToken, this.refreshToken});

  const AuthState.initial()
      : user = null,
        accessToken = null,
        refreshToken = null;

  AuthState copyWith({User user, Token accessToken, Token refreshToken}) {
    return AuthState(
        user: user ?? this.user,
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken);
  }

  bool get isLoggedIn => this.user != null;

  int get secondsToTokenExpire =>
      this.accessToken.expiresAt.difference(DateTime.now()).inSeconds;

  @override
  List<Object> get props => [user, accessToken, refreshToken];
}
