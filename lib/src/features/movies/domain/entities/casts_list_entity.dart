import 'package:equatable/equatable.dart';

import 'cast_entity.dart';

class CastList extends Equatable {
  final List<CastEntity>? cast;

  const CastList({required this.cast});

  @override
  List<Object?> get props => [cast];
}
