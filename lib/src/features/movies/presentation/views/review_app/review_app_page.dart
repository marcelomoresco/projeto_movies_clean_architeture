import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/cubits/review/review_cubit.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/review_app_widget.dart';

class ReviewAppPage extends StatelessWidget {
  const ReviewAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
