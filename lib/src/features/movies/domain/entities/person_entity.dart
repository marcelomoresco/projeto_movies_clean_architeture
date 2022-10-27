import 'package:equatable/equatable.dart';

class PersonEntity extends Equatable {
  final int id;
  final String name;
  final String? profilePath;
  final String knowForDepartment;

  const PersonEntity({
    required this.id,
    required this.name,
    this.profilePath,
    required this.knowForDepartment,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        profilePath,
        knowForDepartment,
      ];
}
