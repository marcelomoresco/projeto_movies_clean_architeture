// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'genre_bloc.dart';

abstract class GenreState extends Equatable {
  const GenreState();

  @override
  List<Object> get props => [];
}

class GenreLoadingState extends GenreState {}

class GenreLoadedState extends GenreState {
  final List<GenreEntity> genreList;
  const GenreLoadedState({
    required this.genreList,
  });

  @override
  List<Object> get props => [genreList];
}

class GenreErrorState extends GenreState {
  final String message;

  const GenreErrorState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
