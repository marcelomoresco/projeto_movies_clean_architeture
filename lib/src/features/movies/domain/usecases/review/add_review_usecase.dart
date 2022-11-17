import 'package:projeto_movies_clean_arciteture/src/features/login/domain/repositories/firebase_repository.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';

class AddReviewUsecase {
  final FirebaseRepository firebaseRepository;

  AddReviewUsecase({required this.firebaseRepository});

  Future<void> call(ReviewEntity review) async {
    return firebaseRepository.addNewReview(review);
  }
}
