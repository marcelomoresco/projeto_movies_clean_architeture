import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/cast_entity.dart';

import '../../../domain/usecases/get_cast_list_usecase.dart';

part 'cast_movie_event.dart';
part 'cast_movie_state.dart';

class CastMovieBloc extends Bloc<CastMovieEvent, CastMovieState> {
  final GetCastListUsecase getCastListUsecase;
  CastMovieBloc({
    required this.getCastListUsecase,
  }) : super(CastMovieInitialState()) {
    on<GetCastMovieEvent>(_onGetCastMovieEvent);
  }
  void _onGetCastMovieEvent(
      GetCastMovieEvent event, Emitter<CastMovieState> emit) async {
    emit(CastMovieLoadingState());
    final result = await getCastListUsecase(event.movieId);

    result.fold(
      (failure) => emit(
        const CastMovieErrorState(errorMessage: "Erro ao consultar cast!"),
      ),
      (castList) => emit(
        CastMovieLoadedState(casts: castList),
      ),
    );
  }
}
