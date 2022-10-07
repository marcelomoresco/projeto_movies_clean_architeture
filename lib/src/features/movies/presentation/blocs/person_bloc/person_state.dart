part of 'person_bloc.dart';

abstract class PersonState extends Equatable {
  const PersonState();
  
  @override
  List<Object> get props => [];
}

class PersonInitial extends PersonState {}
