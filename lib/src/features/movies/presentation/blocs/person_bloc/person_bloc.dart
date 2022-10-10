import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/person_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/usecases/get_trending_person_usecase.dart';

import '../../../../../core/usecases/usecase.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final GetTrendingPersonUsecase getTrendingPersonUsecase;

  PersonBloc({required this.getTrendingPersonUsecase})
      : super(PersonLoadingState()) {
    on<StartPersonEvent>(_startPersonLoadEvent);
  }

  void _startPersonLoadEvent(
      StartPersonEvent event, Emitter<PersonState> emit) async {
    emit(PersonLoadingState());
    final result = await getTrendingPersonUsecase(NoParams());
    print("CHEGOU AQUI BLOC PERSON");
    result.fold(
      (failed) => emit(
        const PersonErrorState(
            error: "Erro ao fazer requisição para atores da semana!"),
      ),
      (personList) => emit(
        PersonLoadedState(personList: personList),
      ),
    );
  }
}
