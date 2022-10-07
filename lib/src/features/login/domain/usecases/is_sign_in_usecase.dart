import '../repositories/firebase_repository.dart';

class IsSignInUsecase {
  final FirebaseRepository firebaseRepository;

  IsSignInUsecase({required this.firebaseRepository});

  Future<bool> call() async {
    return firebaseRepository.isSignIn();
  }
}
