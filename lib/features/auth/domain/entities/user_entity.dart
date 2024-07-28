import 'package:comments_app_assignment/features/auth/data/models/user_model.dart';

class UserEntity {
  final String? uid;
  final String? username;
  final String? email;
  final String? password;

  UserEntity({
    this.uid,
    this.username,
    this.email,
    this.password,
  });

  UserModel toModel() {
    return UserModel(
      uid: uid,
      username: username,
      email: email,
      password: password,
    );
  }

  static UserEntity fromModel(UserModel model) {
    return UserEntity(
      uid: model.uid,
      username: model.username,
      email: model.email,
      password: model.password,
    );
  }

  UserEntity copyWith({
    String? uid,
    String? username,
    String? mobileNumber,
    String? email,
    String? password,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
