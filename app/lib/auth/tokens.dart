import 'package:flutter/widgets.dart';

class Token {
  final String jwt;
  DateTime expiresAt;

  Token({@required this.jwt, DateTime expiresAt, int expiresIn}) {
    this.expiresAt =
        expiresAt ?? DateTime.now().add(Duration(seconds: expiresIn));
  }

  Map<String, dynamic> toJson() {
    return {
      'jwt': this.jwt,
      'expiresAt': this.expiresAt.toIso8601String(),
    };
  }

  bool get isValid => this.expiresAt.isAfter(DateTime.now());

  String get suffix => this.jwt.substring(this.jwt.length - 8);

  factory Token.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('expiresAt')) {
      return Token(
          jwt: json['jwt'], expiresAt: DateTime.parse(json['expiresAt']));
    } else {
      return Token(jwt: json['jwt'], expiresIn: json['expiresIn']);
    }
  }
}
