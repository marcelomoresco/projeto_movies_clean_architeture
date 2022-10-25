import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/cast_entity.dart';

class CastModel extends CastEntity {
  const CastModel({
    required String name,
    String? profilePath,
    required String character,
  }) : super(
          name: name,
          profilePath: profilePath,
          character: character,
        );

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json["name"],
      profilePath: json["profilePath"],
      character: json["character"],
    );
  }
}
