part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetMoviesBySearch extends SearchEvent {
  final String query;

  const GetMoviesBySearch({required this.query});

  @override
  List<Object> get props => [query];
}
