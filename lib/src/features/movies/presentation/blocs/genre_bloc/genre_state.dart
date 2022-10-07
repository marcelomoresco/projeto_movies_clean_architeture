part of 'genre_bloc.dart';

abstract class GenreState extends Equatable {
  const GenreState();
  
  @override
  List<Object> get props => [];
}

class GenreInitial extends GenreState {}
