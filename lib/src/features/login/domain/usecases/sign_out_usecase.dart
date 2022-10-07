import '../repositories/firebase_repository.dart';

class SignOutUsecase {
  final FirebaseRepository firebaseRepository;

  SignOutUsecase({required this.firebaseRepository});

  Future<void> call() async {
    return firebaseRepository.signOut();
  }
}
