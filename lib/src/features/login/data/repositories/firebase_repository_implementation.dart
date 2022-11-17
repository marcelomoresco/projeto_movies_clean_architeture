import 'package:flutter/services.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/domain/entities/user_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';

import '../../domain/repositories/firebase_repository.dart';
import '../datasource/remote/firebase_remote_datasource.dart';

class FirebaseRepositoryImplementation implements FirebaseRepository {
  final IFirebaseRemoteDatasource remoteDatasource;

  const FirebaseRepositoryImplementation({required this.remoteDatasource});

  @override
  Future<void> getCreateCurrentUser(UserEntity user) {
    try {
      return remoteDatasource.getCreateCurrentUser(user);
    } on PlatformException {
      throw Exception("Erro de plataforma");
    } catch (e) {
      throw Exception("Erro de plataforma $e");
    }
  }

  @override
  Future<String> getCurrentUId() {
    try {
      return remoteDatasource.getCurrentUId();
    } on PlatformException {
      throw Exception("Erro de plataforma");
    } catch (e) {
      throw Exception("Erro de plataforma $e");
    }
  }

  @override
  Future<bool> isSignIn() {
    try {
      return remoteDatasource.isSignIn();
    } on PlatformException {
      throw Exception("Erro de plataforma");
    } catch (e) {
      throw Exception("Erro de plataforma $e");
    }
  }

  @override
  Future<void> signIn(UserEntity user) async {
    try {
      return remoteDatasource.signIn(user);
    } on PlatformException {
      throw Exception("Erro de plataforma");
    } catch (e) {
      throw Exception("Erro de plataforma $e");
    }
  }

  @override
  Future<void> signOut() async {
    try {
      return remoteDatasource.signOut();
    } on PlatformException {
      throw Exception("Erro de plataforma");
    } catch (e) {
      throw Exception("Erro de plataforma $e");
    }
  }

  @override
  Future<void> signUp(UserEntity user) async {
    try {
      return remoteDatasource.signUp(user);
    } on PlatformException {
      throw Exception("Erro de plataforma");
    } catch (e) {
      throw Exception("Erro de plataforma $e");
    }
  }

  @override
  Future<void> sendForgotPassword(UserEntity user) {
    try {
      return remoteDatasource.sendForgotPassword(user);
    } on PlatformException {
      throw Exception("Erro de plataforma");
    } catch (e) {
      throw Exception("Erro de plataforma $e");
    }
  }

  @override
  Future<void> addNewReview(ReviewEntity review) async {
    return await remoteDatasource.addNewReview(review);
  }

  @override
  Future<void> deleteReview(ReviewEntity review) async {
    return await remoteDatasource.deleteReview(review);
  }

  @override
  Stream<List<ReviewEntity>> getReview(String uid) {
    return remoteDatasource.getReviews(uid);
  }

  @override
  Future<void> updateReview(ReviewEntity review) async {
    return await remoteDatasource.updateReview(review);
  }
}
