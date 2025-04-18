import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/fav_provider.dart';
import 'widgets_v2/post_card.dart';

class FavPage extends StatelessWidget {
  const FavPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favs = Provider.of<FavProvider>(context).favs;

    return Scaffold(
      appBar: AppBar(title: const Text('Fav Post')),
      body: ListView.builder(
        itemCount: favs.length,
        itemBuilder: (context, index) => PostCard(post: favs[index]),
      ),
    );
  }
}
