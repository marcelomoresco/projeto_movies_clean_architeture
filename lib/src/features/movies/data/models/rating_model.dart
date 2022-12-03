import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/rating_entity.dart';

class RatingModel extends RatingEntity {
  RatingModel({
    required int id,
    required int rating,
  }) : super(
          id: id,
          rating: rating,
        );

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json['id'],
      rating: json['rating'],
    );
  }
}
