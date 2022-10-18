import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/presentation/views/login/sign_in_page.dart';

import '../../../domain/entities/user_entity.dart';
import '../../blocs/user_cubit/user_cubit.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  void submitSignUp() {
    if (_usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      context.read<UserCubit>().submitSignUp(
            user: UserEntity(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Registro feito com sucesso",
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
    return Scaffold(
      key: _globalKey,
    );
  }
}
