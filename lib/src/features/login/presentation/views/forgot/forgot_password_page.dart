import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/domain/entities/user_entity.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/presentation/blocs/user_cubit/user_cubit.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/presentation/views/login/sign_in_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _emailController = TextEditingController();

  void submitForgotPassword() {
    if (_emailController.text.isNotEmpty) {
      context.read<UserCubit>().sendForgotPassword(
            user: UserEntity(
              email: _emailController.text,
            ),
          );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Senha enviada com sucesso",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const SignInPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Erro ao tentar login",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
