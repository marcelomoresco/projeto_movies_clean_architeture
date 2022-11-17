import 'package:projeto_movies_clean_arciteture/src/features/login/domain/repositories/firebase_repository.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';

class DeleteReviewUsecase {
  final FirebaseRepository firebaseRepository;

  DeleteReviewUsecase({
    required this.firebaseRepository,
  });

  Future<void> call(ReviewEntity reviewEntity) async {
    return firebaseRepository.deleteReview(reviewEntity);
  }
}
