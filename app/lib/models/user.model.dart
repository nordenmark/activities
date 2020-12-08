class User {
  final int id;
  final String email;
  final String name;

  User({this.id, this.email, this.name});

  factory User.fromJson(dynamic json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'email': this.email,
      'name': this.name,
    };
  }
}
