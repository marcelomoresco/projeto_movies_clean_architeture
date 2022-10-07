// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesLoadingState extends MoviesState {}

class MoviesLoadedState extends MoviesState {
  final List<MoviesEntity> movies;
  const MoviesLoadedState({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];
}

class MoviesErrorState extends MoviesState {
  final String errorMessage;
  const MoviesErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
