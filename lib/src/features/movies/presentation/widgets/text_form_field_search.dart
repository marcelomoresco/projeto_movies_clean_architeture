import 'package:flutter/material.dart';

class TextFieldSearch extends StatelessWidget {
  final TextEditingController searchController;

  const TextFieldSearch({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
          fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold),
      controller: searchController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(30.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(30.0)),
        contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
        hintText: "Pesquise seus filmes",
        hintStyle: TextStyle(
            fontSize: 15.0,
            color: Colors.grey[400],
            fontWeight: FontWeight.w500),
        labelStyle: TextStyle(
            fontSize: 15.0,
            color: Colors.grey[400],
            fontWeight: FontWeight.w500),
      ),
      autocorrect: false,
    );
  }
}
