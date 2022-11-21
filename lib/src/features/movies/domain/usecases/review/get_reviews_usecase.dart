import 'package:projeto_movies_clean_arciteture/src/features/login/domain/repositories/firebase_repository.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/domain/entities/review_entity.dart';

class GetReviewsUsecase {
  final FirebaseRepository firebaseRepository;

  GetReviewsUsecase({required this.firebaseRepository});

  Stream<List<ReviewEntity>> call(String uid) {
    return firebaseRepository.getReview(uid);
  }
}
