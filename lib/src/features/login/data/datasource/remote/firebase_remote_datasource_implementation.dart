import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/data/models/review_model.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../models/user_model.dart';
import 'firebase_remote_datasource.dart';

class FirebaseRemoteDatasourceImplementation
    implements IFirebaseRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  FirebaseRemoteDatasourceImplementation({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollectionRef = firebaseFirestore.collection("users");
    final uid = await getCurrentUId();
    userCollectionRef.doc(uid).get().then((value) {
      final newUser = UserModel(
        uid: uid,
        status: user.status,
        email: user.email,
        name: user.name,
      ).toDocument();
      if (!value.exists) {
        userCollectionRef.doc(uid).set(newUser);
      }
      return;
    });
  }

  @override
  Future<String> getCurrentUId() async => firebaseAuth.currentUser!.uid;

  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserEntity user) async => firebaseAuth
      .signInWithEmailAndPassword(email: user.email!, password: user.password!);

  @override
  Future<void> signOut() async => firebaseAuth.signOut();

  @override
  Future<void> signUp(UserEntity user) async =>
      firebaseAuth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

  @override
  Future<void> sendForgotPassword(UserEntity user) {
    return firebaseAuth.sendPasswordResetEmail(email: user.email!);
  }

  @override
  Future<void> addNewReview(ReviewEntity reviewEntity) async {
    final reviewCollection = firebaseFirestore
        .collection("reviews")
        .doc(reviewEntity.uid)
        .collection("reviews");
    final reviewId = reviewCollection.doc().id;
    reviewCollection.doc(reviewId).get().then((review) {
      final newReview = ReviewModel(
        nameReview: reviewEntity.nameReview,
        uid: reviewEntity.uid,
        reviewId: reviewEntity.reviewId,
        review: reviewEntity.review,
        createAt: reviewEntity.createAt,
      ).toDocument();

      if (!review.exists) {
        reviewCollection.doc(reviewId).set(newReview);
      }
      return;
    });
  }

  @override
  Future<void> deleteReview(ReviewEntity reviewEntity) async {
    final noteCollection = firebaseFirestore
        .collection("reviews")
        .doc(reviewEntity.uid)
        .collection("reviews");

    noteCollection.doc(reviewEntity.reviewId).get().then((note) {
      if (note.exists) {
        noteCollection.doc(reviewEntity.reviewId).delete();
      }
      return;
    });
  }

  @override
  Stream<List<ReviewEntity>> getReviews(String uid) {
    final reviewCollectionRef =
        firebaseFirestore.collection("reviews").doc(uid).collection("reviews");

    return reviewCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => ReviewModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Future<void> updateReview(ReviewEntity review) async {
    Map<String, dynamic> reviewMap = Map();
    final reviewCollectionRef = firebaseFirestore
        .collection("reviews")
        .doc(review.uid)
        .collection("reviews");

    if (review.nameReview != null) reviewMap['nameReview'] = review.nameReview;
    if (review.review != null) reviewMap['review'] = review.review;
    if (review.createAt != null) reviewMap['createAt'] = review.createAt;

    reviewCollectionRef.doc(review.reviewId).update(reviewMap);
  }
}
