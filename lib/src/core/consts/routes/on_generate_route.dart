import 'package:flutter/material.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/views/details/movie_detail_page.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/views/home/home_page.dart';

import '../../../features/login/presentation/views/login/sign_in_page.dart';
import '../../../features/login/presentation/views/register/sign_up_page.dart';
import '../../../features/movies/domain/entities/movies_entity.dart';
import '../apps/app_conts.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.signInPage:
        return materialBuilder(
          widget: const SignInPage(),
        );
      case PageConst.signUpPage:
        return materialBuilder(
          widget: const SignUpPage(),
        );

      case PageConst.homeMoviePage:
        return materialBuilder(
          widget: HomePage(),
        );
      case PageConst.movieDetailsPage:
        return materialBuilder(
          widget: MovieDetailPage(
            movie: args as MoviesEntity,
          ),
        );
      default:
        return materialBuilder(widget: const ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error Page"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: const Center(child: Text("Erro!")),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
