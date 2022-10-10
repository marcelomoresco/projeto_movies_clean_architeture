// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitialState extends MovieDetailState {}

class MovieDetailLoadingState extends MovieDetailState {}

class MovieDetailLoadedState extends MovieDetailState {
  final MoviesDetailsEntity movieDetails;

  const MovieDetailLoadedState({
    required this.movieDetails,
  });

  @override
  List<Object> get props => [movieDetails];
}

class MovieDetailErrorState extends MovieDetailState {
  final String errorMessage;
  const MovieDetailErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
