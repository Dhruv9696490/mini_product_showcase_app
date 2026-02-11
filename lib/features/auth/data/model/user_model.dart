

import 'package:mini_product_showcase_app/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.email, required super.name});
   Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
    );
  }
}
