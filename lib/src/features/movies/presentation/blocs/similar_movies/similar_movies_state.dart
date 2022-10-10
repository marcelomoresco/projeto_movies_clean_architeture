// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'similar_movies_bloc.dart';

abstract class SimilarMoviesState extends Equatable {
  const SimilarMoviesState();

  @override
  List<Object> get props => [];
}

class SimilarMoviesInitialState extends SimilarMoviesState {}

class SimilarMoviesLoadingState extends SimilarMoviesState {}

class SimilarMoviesLoadedState extends SimilarMoviesState {
  final List<MoviesEntity> moviesList;

  const SimilarMoviesLoadedState({
    required this.moviesList,
  });

  @override
  List<Object> get props => [moviesList];
}

class SimilarMoviesErrorState extends SimilarMoviesState {
  final String errorMessage;

  const SimilarMoviesErrorState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
