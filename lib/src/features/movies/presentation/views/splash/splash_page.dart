import 'package:flutter/material.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/presentation/views/login/sign_in_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void _onLoading() async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const SignInPage(),
      ),
    );
  }

  @override
  void initState() {
    _onLoading();
    super.initState();
  }

  Widget build(BuildContext context) {
    final sizePhone = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: sizePhone.height,
        width: sizePhone.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Text("Talk Movie"),
            //Lottie.asset("assets/movie.json"),
          ],
        ),
      ),
    );
  }
}
