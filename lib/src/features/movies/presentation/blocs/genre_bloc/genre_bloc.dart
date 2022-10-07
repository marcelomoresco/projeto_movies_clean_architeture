import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_genre_list_usecase.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/genre_entity.dart';

part 'genre_event.dart';
part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final GetGenreListUsecase getGenreListUsecase;

  GenreBloc({required this.getGenreListUsecase}) : super(GenreLoadingState()) {
    on<StartGenreEvent>(_startGenreEvent);
  }

  void _startGenreEvent(StartGenreEvent event, Emitter<GenreState> emit) async {
    emit(GenreLoadingState());
    final result = await getGenreListUsecase(NoParams());

    result.fold(
      (failed) => emit(
        const GenreErrorState(
            message: "Erro ao puxar as informações das categorias!"),
      ),
      (genreList) => emit(
        GenreLoadedState(genreList: genreList),
      ),
    );
  }
}
