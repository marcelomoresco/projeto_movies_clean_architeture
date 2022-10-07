import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'genre_event.dart';
part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreBloc() : super(GenreInitial()) {
    on<GenreEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
