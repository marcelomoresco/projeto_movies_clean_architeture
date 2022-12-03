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

  factory ReviewModel.fromSnapshot(Map<String, dynamic> json) {
    return ReviewModel(
      nameReview: json['nameReview'],
      reviewId: json['reviewId'],
      review: json['review'],
      uid: json['uid'],
      createAt: json['createAt'],
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
