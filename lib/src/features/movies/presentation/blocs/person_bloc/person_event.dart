part of 'person_bloc.dart';

abstract class PersonEvent extends Equatable {
  const PersonEvent();

  @override
  List<Object> get props => [];
}

class StartPersonEvent extends PersonEvent {
  const StartPersonEvent();

  @override
  List<Object> get props => [];
}
