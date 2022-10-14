import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    on<GetMoviesBySearch>(_onGetMoviesBySearch);
  }

  void _onGetMoviesBySearch(
      GetMoviesBySearch event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
  }
}
