import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:email_validator/email_validator.dart';
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
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final bool _isLoading = false;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _confirmEmailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool isVisible = false;

  toggleIsVisible() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void submitSignUp() {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      context.read<UserCubit>().submitSignUp(
            user: UserEntity(
              email: _emailController.text,
              password: _passwordController.text,
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
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
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
                  children: [],
                ),
              ),
            ),
          ),
          Positioned(
            top: 230,
            child: Container(
              height: 460,
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
              child: Form(
                key: _formKey,
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
                                "Cadastre-se!",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _nameController,
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                //errorText: _errorEmailText,
                                prefixIcon: const Icon(Icons.person),
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
                                hintText: "Nome",
                                hintStyle: const TextStyle(fontSize: 14)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Por favor insira um nome ";
                              } else if (value.length < 4) {
                                return "Insira um nome ate 4 caracteres";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Por favor insira um E-mail ";
                              } else if (!value.contains("@") ||
                                  !value.contains(".")) {
                                return "Insira um E-mail valido";
                              } else if (!EmailValidator.validate(value)) {
                                return "E-mail não existe";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: isVisible ? false : true,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                //errorText: _errorEmailText,
                                prefixIcon: const Icon(Icons.password),
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
                                hintText: "Senha",
                                hintStyle: const TextStyle(fontSize: 14)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Por favor isnira uma senha ";
                              } else if (value.length < 7) {
                                return "Insira uma senha de pelo menos 7 caracteres";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: isVisible ? false : true,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  //errorText: _errorEmailText,
                                  prefixIcon: const Icon(Icons.password),
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
                                  hintText: "Confirmar senha",
                                  hintStyle: const TextStyle(fontSize: 14)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Insira uma senha de pelo menos 7 caracteres";
                                } else if (value.length < 7) {
                                  return "Por favor insira uma senha ";
                                } else if (value != _passwordController.text) {
                                  return "Sennha incompatível";
                                }
                                return null;
                              }),
                        ]),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
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
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  submitSignUp();
                                  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.scale,
                                    dialogType: DialogType.success,
                                    title: 'Registro Concluído',
                                    desc:
                                        'Agora você consegue ver os melhores filmes apenas indo até o login!',
                                    headerAnimationLoop: false,
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                                  ).show();
                                } else {
                                  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.scale,
                                    dialogType: DialogType.error,
                                    title: 'Erro ao se registrar',
                                    desc:
                                        'Verifique os campos e tente novamente!',
                                    headerAnimationLoop: false,
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                                  ).show();
                                }
                              },
                              child: GestureDetector(
                                child: const Text("Registre Agora",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
