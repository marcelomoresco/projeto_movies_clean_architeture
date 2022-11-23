import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/cubits/review/review_cubit.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/modal_create_edit_review.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/review_app_widget.dart';

class ReviewAppPage extends StatelessWidget {
  const ReviewAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 3,
        title: const Text("Reviews"),
        centerTitle: true,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Veja os reviews do nosso app e deixe seu review",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 24,
            ),
            GestureDetector(
              onTap: () {
                ModalCardEditCreateReview(isEdit: false)
                    .modalBottomSheet(context);
              },
              child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.yellow,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(Icons.star, color: Colors.green, size: 48),
                      Text("Deixe seu review agora mesmo",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ))
                    ],
                  )),
            ),
            BlocConsumer<ReviewCubit, ReviewState>(
              listener: (context, state) {},
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
          ],
        ),
      ),
    );
  }
}
