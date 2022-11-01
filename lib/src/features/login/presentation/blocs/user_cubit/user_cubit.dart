import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/domain/usecases/forgot_password_usecase.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/get_create_current_user_usecase.dart';
import '../../../domain/usecases/sign_in_usecase.dart';
import '../../../domain/usecases/sign_out_usecase.dart';
import '../../../domain/usecases/sign_up_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignInUsecase signInUsecase;
  final SignUpUsecase signUpUsecase;
  final SignOutUsecase signOutUsecase;
  final GetCreateCurrentUserUsecase getCreateCurrentUserUsecase;
  final ForgotPasswordUsecase forgotPasswordUsecase;

  UserCubit({
    required this.signInUsecase,
    required this.signUpUsecase,
    required this.signOutUsecase,
    required this.forgotPasswordUsecase,
    required this.getCreateCurrentUserUsecase,
  }) : super(UserInitial());

  Future<void> submitSignIn({required UserEntity user}) async {
    emit(UserLoadingState());
    try {
      await signInUsecase.call(user);
      emit(UserLoadedState());
    } catch (_) {
      emit(UserFailureState());
    }
  }

  Future<void> sendForgotPassword({required UserEntity user}) async {
    emit(UserLoadingState());
    try {
      await forgotPasswordUsecase.call(user);
      emit(UserLoadedState());
    } catch (_) {
      emit(UserFailureState());
    }
  }

  Future<void> submitSignUp({required UserEntity user}) async {
    emit(UserLoadingState());
    try {
      await signUpUsecase.call(user);
      await getCreateCurrentUserUsecase.call(user);
      emit(UserLoadedState());
    } catch (_) {
      emit(UserFailureState());
    }
  }
}
