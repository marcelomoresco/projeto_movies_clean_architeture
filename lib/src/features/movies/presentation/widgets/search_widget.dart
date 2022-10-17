import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/blocs/search_bloc/search_bloc.dart';
import 'package:projeto_movies_clean_arciteture/src/features/movies/presentation/widgets/text_form_field_search.dart';

class SearchWidget extends StatelessWidget {
  TextEditingController searchController;
  SearchWidget({Key? key, required this.searchController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width * .7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Form(
            key: _formKey,
            child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo Obrigatório";
                  } else {
                    return null;
                  }
                },
                controller: searchController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    prefixIcon: Icon(Icons.search),
                    hintText: "Pesquise seus filmes")),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          height: 60,
          width: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<SearchBloc>().add(
                      GetMoviesBySearch(
                        query: searchController.text.trim(),
                      ),
                    );
                print(searchController.text.trim());
              } else {
                const snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("Campo Inválido. Preencha o campo!",
                      style: TextStyle(color: Colors.white)),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
