import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/person_entity.dart';

class PersonModel extends PersonEntity {
  const PersonModel({
    required int id,
    required String gender,
    required String name,
    required String profilePath,
    required String knowForDepartment,
    required double popularity,
  }) : super(
          id: id,
          gender: gender,
          name: name,
          profilePath: profilePath,
          knowForDepartment: knowForDepartment,
          popularity: popularity,
        );

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json["id"],
      gender: json["gender"].toString(),
      name: json["name"],
      profilePath: json["profile_path"],
      knowForDepartment: json["known_for_department"],
      popularity: json["popularity"],
    );
  }
}
