import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';

import '../entities/user_entity.dart';

abstract class FirebaseRepository {
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
  Future<void> sendForgotPassword(UserEntity user);
  Future<String> getCurrentUId();
  Future<void> getCreateCurrentUser(UserEntity user);
  Future<void> addNewReview(ReviewEntity review);
  Future<void> updateReview(ReviewEntity review);
  Future<void> deleteReview(ReviewEntity review);
  Stream<List<ReviewEntity>> getReview(String uid);
}
