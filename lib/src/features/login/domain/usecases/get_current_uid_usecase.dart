import '../repositories/firebase_repository.dart';

class GetCurrentUIdUsecase {
  final FirebaseRepository firebaseRepository;

  GetCurrentUIdUsecase({required this.firebaseRepository});

  Future<String> call() async {
    return firebaseRepository.getCurrentUId();
  }
}
