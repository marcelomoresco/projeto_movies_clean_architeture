import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_current_uid_usecase.dart';
import '../../../domain/usecases/is_sign_in_usecase.dart';
import '../../../domain/usecases/sign_out_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUIdUsecase getCurrentUIdUsecase;
  final IsSignInUsecase isSignInUsecase;
  final SignOutUsecase signOutUsecase;

  AuthCubit({
    required this.getCurrentUIdUsecase,
    required this.isSignInUsecase,
    required this.signOutUsecase,
  }) : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      final isSignIn = await isSignInUsecase.call();

      if (isSignIn) {
        final uid = await getCurrentUIdUsecase.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUIdUsecase.call();
      emit(Authenticated(uid: uid));
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> signOut() async {
    try {
      await signOutUsecase.call();
      emit(UnAuthenticated());
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }
}
