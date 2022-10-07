// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'person_bloc.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object> get props => [];
}

class PersonLoadingState extends PersonState {}

class PersonLoadedState extends PersonState {
  final List<PersonEntity> personList;

  const PersonLoadedState({
    required this.personList,
  });

  @override
  List<Object> get props => [personList];
}

class PersonErrorState extends PersonState {
  final String error;

  const PersonErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
