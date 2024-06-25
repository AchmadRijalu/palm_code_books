import 'package:flutter/material.dart';

class FavoriteBookView extends StatefulWidget {
  const FavoriteBookView({super.key});

  @override
  State<FavoriteBookView> createState() => _FavoriteBookViewState();
}

class _FavoriteBookViewState extends State<FavoriteBookView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites Book"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Text("halo"),
      ),
    );
  }
}
