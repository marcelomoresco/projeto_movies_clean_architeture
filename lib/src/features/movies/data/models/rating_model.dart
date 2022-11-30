import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/rating_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';

class RatingModel extends RatingEntity {
  const RatingModel({
    required int id,
    required String originalTitle,
    required String overview,
    String? posterPath,
    String? backdropPath,
    required String title,
    required int rating,
  }) : super(
          id: id,
          originalTitle: originalTitle,
          overview: overview,
          posterPath: posterPath,
          backdropPath: backdropPath,
          title: title,
          rating: rating,
        );

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json['id'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      title: json['title'],
      rating: json['rating'],
      backdropPath: json['backdrop_path'],
      posterPath: json['poster_path'],
    );
  }
}
