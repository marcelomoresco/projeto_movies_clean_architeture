import '../../../domain/entities/user_entity.dart';

abstract class IFirebaseRemoteDatasource {
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
  Future<void> sendForgotPassword(UserEntity user);
  Future<String> getCurrentUId();
  Future<void> getCreateCurrentUser(UserEntity user);
}
