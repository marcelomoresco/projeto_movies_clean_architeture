import 'package:projeto_movies_clean_arciteture/src/features/login/domain/entities/user_entity.dart';

import '../../domain/repositories/firebase_repository.dart';
import '../datasource/remote/firebase_remote_datasource.dart';

class FirebaseRepositoryImplementation implements FirebaseRepository {
  final IFirebaseRemoteDatasource remoteDatasource;

  const FirebaseRepositoryImplementation({required this.remoteDatasource});

  @override
  Future<void> getCreateCurrentUser(UserEntity user) {
    return remoteDatasource.getCreateCurrentUser(user);
  }

  @override
  Future<String> getCurrentUId() {
    return remoteDatasource.getCurrentUId();
  }

  @override
  Future<bool> isSignIn() {
    return remoteDatasource.isSignIn();
  }

  @override
  Future<void> sendForgotPassword() {
    return remoteDatasource.sendForgotPassword();
  }

  @override
  Future<void> signIn(UserEntity user) async {
    return remoteDatasource.signIn(user);
  }

  @override
  Future<void> signOut() async {
    return remoteDatasource.signOut();
  }

  @override
  Future<void> signUp(UserEntity user) async {
    return remoteDatasource.signUp(user);
  }
}
