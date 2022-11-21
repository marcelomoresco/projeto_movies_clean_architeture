import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/cubits/review/review_cubit.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/review_app_widget.dart';

class ReviewAppPage extends StatefulWidget {
  const ReviewAppPage({super.key});

  @override
  State<ReviewAppPage> createState() => _ReviewAppPageState();
}

class _ReviewAppPageState extends State<ReviewAppPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    context.read<ReviewCubit>().getReviews(uid: firebaseAuth.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocConsumer<ReviewCubit, ReviewState>(
        listener: (context, state) {
          if (state is ReviewDeleteSuccessState) {
          } else if (state is ReviewUpdateSuccessState) {}
        },
        builder: (context, state) {
          if (state is ReviewLoadedState) {
            return ReviewAppWidget(reviews: state.reviews);
          } else if (state is ReviewLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ReviewErrorState) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return const Center(
              child: Text("Algo deu muito errado!"),
            );
          }
        },
      ),
    );
  }
}
