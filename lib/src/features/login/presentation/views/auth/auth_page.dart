import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/presentation/blocs/auth_cubit/auth_cubit.dart';

import '../../../../movies/presentation/views/initial/initial_page.dart';
import '../login/sign_in_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return const InitialPage();
        }
        if (state is UnAuthenticated) {
          return const SignInPage();
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
