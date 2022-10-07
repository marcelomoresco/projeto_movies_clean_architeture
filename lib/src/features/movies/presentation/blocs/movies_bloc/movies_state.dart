part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();
  
  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}
