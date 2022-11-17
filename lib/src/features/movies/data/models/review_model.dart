import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  ReviewModel({
    final String? reviewId,
    final String? review,
    final Timestamp? createAt,
    final String? uid,
  }) : super(
          reviewId: reviewId,
          review: review,
          createAt: createAt,
          uid: uid,
        );

  factory ReviewModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return ReviewModel(
      reviewId: documentSnapshot.get('reviewId'),
      review: documentSnapshot.get('review'),
      uid: documentSnapshot.get('uid'),
      createAt: documentSnapshot.get('createAt'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "uid": uid,
      "createAt": createAt,
      "review": review,
      "reviewId": reviewId
    };
  }
}
