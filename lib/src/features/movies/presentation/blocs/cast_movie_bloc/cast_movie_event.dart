part of 'cast_movie_bloc.dart';

abstract class CastMovieEvent extends Equatable {
  const CastMovieEvent();

  @override
  List<Object> get props => [];
}

class GetCastMovieEvent extends CastMovieEvent {
  final int movieId;
  const GetCastMovieEvent({required this.movieId});
  @override
  List<Object> get props => [movieId];
}
