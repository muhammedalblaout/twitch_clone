import '../entites/user.dart';

class UserModel extends User {
  UserModel({
    required super.name,
    required super.email,
    required super.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,

    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? ' ',
      name: map['name'] ?? " ",
      email: map['email'] ?? " ",
    );
  }
}
