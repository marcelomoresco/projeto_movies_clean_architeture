part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<MoviesEntity> moviesList;

  const SearchLoadedState({required this.moviesList});

  @override
  List<Object> get props => [moviesList];
}

class SearchErrorState extends SearchState {
  final String errorMessage;

  const SearchErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
