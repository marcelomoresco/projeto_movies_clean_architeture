import 'package:projeto_movies_clean_arciteture/src/features/login/domain/repositories/firebase_repository.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';

class UpdateReviewUsecase {
  final FirebaseRepository firebaseRepository;

  UpdateReviewUsecase({required this.firebaseRepository});

  Future<void> call(ReviewEntity reviewEntity) async {
    return firebaseRepository.updateReview(reviewEntity);
  }
}
