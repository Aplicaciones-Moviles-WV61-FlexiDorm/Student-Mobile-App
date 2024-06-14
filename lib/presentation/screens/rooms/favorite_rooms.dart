import 'package:flutter/material.dart';

class FavoriteRooms extends StatelessWidget {
  static const String name = "favorite_rooms";
  const FavoriteRooms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
      ),
      body: const Center(
        child: Text("Favorite Rooms"),
      ),
    );
  }
}