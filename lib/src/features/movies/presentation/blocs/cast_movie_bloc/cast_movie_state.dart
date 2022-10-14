part of 'cast_movie_bloc.dart';

abstract class CastMovieState extends Equatable {
  const CastMovieState();

  @override
  List<Object> get props => [];
}

class CastMovieInitialState extends CastMovieState {}

class CastMovieLoadingState extends CastMovieState {}

class CastMovieLoadedState extends CastMovieState {
  final List<CastEntity> casts;

  const CastMovieLoadedState({required this.casts});

  @override
  List<Object> get props => [casts];
}

class CastMovieErrorState extends CastMovieState {
  final String errorMessage;

  const CastMovieErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
