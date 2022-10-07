part of 'genre_bloc.dart';

abstract class GenreEvent extends Equatable {
  const GenreEvent();

  @override
  List<Object> get props => [];
}

class StartGenreEvent extends GenreEvent {
  const StartGenreEvent();

  @override
  List<Object> get props => [];
}
