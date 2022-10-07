import '../entities/user_entity.dart';
import '../repositories/firebase_repository.dart';

class SignUpUsecase {
  final FirebaseRepository firebaseRepository;

  SignUpUsecase({required this.firebaseRepository});

  Future<void> call(UserEntity user) async {
    return firebaseRepository.signUp(user);
  }
}
