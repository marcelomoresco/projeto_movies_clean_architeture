// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class RatingEntity extends Equatable {
  final int id;
  final double rating;

  const RatingEntity({
    required this.id,
    required this.rating,
  });

  @override
  List<Object?> get props => [
        id,
        rating,
      ];
}
