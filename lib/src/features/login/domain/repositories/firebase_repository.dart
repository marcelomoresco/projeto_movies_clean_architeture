import '../entities/user_entity.dart';

abstract class FirebaseRepository {
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
  Future<void> sendForgotPassword();
  Future<String> getCurrentUId();
  Future<void> getCreateCurrentUser(UserEntity user);
}
