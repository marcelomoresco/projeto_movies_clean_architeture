// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'upcoming_movies_bloc.dart';

abstract class UpcomingMoviesState extends Equatable {
  const UpcomingMoviesState();

  @override
  List<Object> get props => [];
}

class UpcomingMoviesInitialState extends UpcomingMoviesState {}

class UpcomingMoviesLoadingState extends UpcomingMoviesState {}

class UpcomingMoviesLoadedState extends UpcomingMoviesState {
  final List<MoviesEntity> moviesList;

  const UpcomingMoviesLoadedState({
    required this.moviesList,
  });

  @override
  List<Object> get props => [moviesList];
}

class UpcomingMoviesErrorState extends UpcomingMoviesState {
  final String message;
  const UpcomingMoviesErrorState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
