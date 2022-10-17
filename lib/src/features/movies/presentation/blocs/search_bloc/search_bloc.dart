import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/movies_entity.dart';
import '../../../domain/usecases/get_movies_by_search_usecase.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetMoviesBySearchUsecase getMoviesBySearchUsecase;
  SearchBloc({
    required this.getMoviesBySearchUsecase,
  }) : super(SearchInitialState()) {
    on<GetMoviesBySearch>(_onGetMoviesBySearch);
  }

  void _onGetMoviesBySearch(
      GetMoviesBySearch event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    print("CHEGOU -------- ${event.query}");
    final result = await getMoviesBySearchUsecase(event.query);
    result.fold(
      (failure) => emit(const SearchErrorState(
        errorMessage: "Erro ao pesquisar filmes!",
      )),
      (moviesList) => emit(SearchLoadedState(moviesList: moviesList)),
    );
  }
}
