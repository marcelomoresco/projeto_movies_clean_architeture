// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class StartMoviesEvent extends MoviesEvent {
  final int movieId;
  final String query;

  const StartMoviesEvent(
    this.movieId,
    this.query,
  );

  @override
  List<Object> get props => [
        movieId,
        query,
      ];
}
