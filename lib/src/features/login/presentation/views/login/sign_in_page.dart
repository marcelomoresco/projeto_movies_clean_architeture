import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/presentation/blocs/user_cubit/user_cubit.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/views/home/home_page.dart';
import 'package:provider/provider.dart';

import '../../../../movies/presentation/views/initial/initial_page.dart';
import '../../../domain/entities/user_entity.dart';
import '../forgot/forgot_password_page.dart';
import '../register/sign_up_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // controllers

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldGlobalKey =
      GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool isVisible = false;

  toggleIsVisible() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void submitSignIn() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      context.read<UserCubit>().submitSignIn(
              user: UserEntity(
            email: _emailController.text,
            password: _passwordController.text,
          ));
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const InitialPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Erro ao tentar login",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldGlobalKey,
      body: _bodyWidget(),
    );
  }

  _bodyWidget() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 530,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.black),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie_movie.json'),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 250,
          child: Container(
            height: 450,
            width: MediaQuery.of(context).size.width - 40,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.38),
                    spreadRadius: 5,
                    blurRadius: 15,
                  )
                ]),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _emailController,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            //errorText: _errorEmailText,
                            prefixIcon: const Icon(Icons.email),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade500),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade500),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "E-mail",
                            hintStyle: const TextStyle(fontSize: 14)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: isVisible ? false : true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          //errorText: _errorPasswordText,
                          prefixIcon: const Icon(Icons.password),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade500),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade500),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          hintText: "Senha",
                          hintStyle: const TextStyle(fontSize: 14),
                          suffixIcon: GestureDetector(
                            onTap: toggleIsVisible,
                            child: const Icon(Icons.visibility_off_outlined),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const ForgotPasswordPage();
                          }));
                        },
                        child: Text(
                          "Esqueceu a senha?",
                          style: TextStyle(
                            color: Colors.blue[500],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          spreadRadius: 5,
                          blurRadius: 15,
                        )
                      ]),
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      submitSignIn();
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.scale,
                        dialogType: DialogType.success,
                        title: 'Login Concluído',
                        desc: 'Agora você consegue ver os melhores filmes!',
                        headerAnimationLoop: false,
                        btnOkOnPress: () {},
                      ).show();
                    },
                    child: GestureDetector(
                      child: const Text("Login",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Ainda não tem conta?"),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignUpPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Registrar Agora",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 250,
                  child: ElevatedButton.icon(
                      icon: const Icon(Icons.g_mobiledata_outlined,
                          color: Colors.red),
                      onPressed: () {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.scale,
                          dialogType: DialogType.info,
                          title: 'Em Manutenção',
                          desc:
                              'Será feito o login com google nas proximas versões',
                          headerAnimationLoop: false,
                          btnOkOnPress: () {},
                        ).show();
                        /*final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();*/
                      },
                      label: const Text("Registre-se com o Gmail",
                          style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          minimumSize: const Size(double.infinity, 50))),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
