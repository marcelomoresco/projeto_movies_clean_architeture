// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SimilarMoviesEntity extends Equatable {
  final int id;
  final String backdrop_path;
  final String original_title;
  final String overview;
  final String poster_path;

  const SimilarMoviesEntity({
    required this.id,
    required this.backdrop_path,
    required this.original_title,
    required this.overview,
    required this.poster_path,
  });

  @override
  List<Object?> get props => [
        id,
        backdrop_path,
        original_title,
        overview,
        poster_path,
      ];
}
