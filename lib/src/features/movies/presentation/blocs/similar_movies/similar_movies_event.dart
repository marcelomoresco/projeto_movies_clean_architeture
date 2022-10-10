// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'similar_movies_bloc.dart';

abstract class SimilarMoviesEvent extends Equatable {
  const SimilarMoviesEvent();

  @override
  List<Object> get props => [];
}

class StartSimilarMoviesEvent extends SimilarMoviesEvent {
  final int movieId;

  const StartSimilarMoviesEvent({
    required this.movieId,
  });

  @override
  List<Object> get props => [movieId];
}
