// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_similar_moives.dart';

import '../../../domain/entities/movies_entity.dart';

part 'similar_movies_event.dart';
part 'similar_movies_state.dart';

class SimilarMoviesBloc extends Bloc<SimilarMoviesEvent, SimilarMoviesState> {
  final GetSimilarMoviesUsecase getSimilarMoviesUsecase;

  SimilarMoviesBloc({
    required this.getSimilarMoviesUsecase,
  }) : super(SimilarMoviesInitialState()) {
    on<StartSimilarMoviesEvent>(_onStartSimilarMovies);
  }

  void _onStartSimilarMovies(
      StartSimilarMoviesEvent event, Emitter<SimilarMoviesState> emit) async {
    emit(SimilarMoviesLoadingState());
    final result = await getSimilarMoviesUsecase(event.movieId);
    result.fold(
      (failure) => emit(
        const SimilarMoviesErrorState(
            errorMessage: "Falha ao encontrar filmes similares!"),
      ),
      (moviesList) => emit(
        SimilarMoviesLoadedState(moviesList: moviesList),
      ),
    );
  }
}
