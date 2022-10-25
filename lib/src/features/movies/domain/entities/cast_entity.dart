import 'package:equatable/equatable.dart';

class CastEntity extends Equatable {
  final String name;
  final String? profilePath;
  final String character;

  const CastEntity({
    required this.name,
    this.profilePath,
    required this.character,
  });

  @override
  List<Object?> get props => [
        name,
        profilePath,
        character,
      ];
}
