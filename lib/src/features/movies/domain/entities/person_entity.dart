import 'package:equatable/equatable.dart';

class PersonEntity extends Equatable {
  final String id;
  final String gender;
  final String name;
  final String profilePath;
  final String knowForDepartment;
  final String popularity;

  const PersonEntity(
      {required this.id,
      required this.gender,
      required this.name,
      required this.profilePath,
      required this.knowForDepartment,
      required this.popularity});

  @override
  List<Object?> get props => [
        id,
        gender,
        name,
        profilePath,
        knowForDepartment,
        popularity,
      ];
}
