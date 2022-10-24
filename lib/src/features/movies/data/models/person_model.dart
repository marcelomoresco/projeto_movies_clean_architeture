import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/person_entity.dart';

class PersonModel extends PersonEntity {
  const PersonModel({
    required int id,
    required String name,
    String? profilePath,
    required String knowForDepartment,
  }) : super(
          id: id,
          name: name,
          profilePath: profilePath,
          knowForDepartment: knowForDepartment,
        );

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json["id"],
      name: json["name"],
      profilePath: json["profile_path"],
      knowForDepartment: json["known_for_department"],
    );
  }
}
