// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class RatingEntity extends Equatable {
  final int id;
  final String originalTitle;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final String title;
  final int rating;

  const RatingEntity({
    required this.id,
    required this.originalTitle,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.title,
    required this.rating,
  });

  @override
  List<Object?> get props => [
        id,
        originalTitle,
        overview,
        posterPath,
        backdropPath,
        title,
        rating,
      ];
}
