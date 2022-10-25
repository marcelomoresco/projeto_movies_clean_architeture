import 'package:projeto_movies_clean_arciteture/src/features/login/domain/repositories/firebase_repository.dart';

import '../entities/user_entity.dart';

class ForgotPasswordUsecase {
  final FirebaseRepository firebaseRepository;

  ForgotPasswordUsecase({required this.firebaseRepository});

  Future<void> call(UserEntity user) async {
    return firebaseRepository.sendForgotPassword(user);
  }
}
