import 'package:comments_app_assignment/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepositoryInterface {
  Future<void> signInUser(UserEntity user);
  Future<UserEntity> rgisterUser(UserEntity user);
  Future<bool> isSignedIn();
  Future<void> logout();
  Stream<List<UserEntity>> getCurrentUserData(String uid);
  Future<String> getCurrentUserUid();
}
