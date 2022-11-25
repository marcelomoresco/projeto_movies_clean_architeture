import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    final String? nameReview,
    final String? reviewId,
    final String? review,
    final Timestamp? createAt,
    final String? uid,
  }) : super(
          nameReview: nameReview,
          reviewId: reviewId,
          review: review,
          createAt: createAt,
          uid: uid,
        );

  factory ReviewModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return ReviewModel(
      nameReview: documentSnapshot.get('nameReview'),
      reviewId: documentSnapshot.get('reviewId'),
      review: documentSnapshot.get('review'),
      uid: documentSnapshot.get('uid'),
      createAt: documentSnapshot.get('createAt'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "nameReview": nameReview,
      "uid": uid,
      "createAt": createAt,
      "review": review,
      "reviewId": reviewId
    };
  }
}
