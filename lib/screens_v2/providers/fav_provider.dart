import 'package:flutter/material.dart';
import '../models/post_model.dart'; // แก้ path ให้ถูกต้อง

class FavProvider with ChangeNotifier {
  final List<Post> _favoritePosts = [];

  // ✅ สร้าง getter ชื่อ favs
  List<Post> get favs => _favoritePosts;

  void add(Post post) {
    if (!_favoritePosts.contains(post)) {
      _favoritePosts.add(post);
      notifyListeners();
    }
  }

  void remove(Post post) {
    _favoritePosts.remove(post);
    notifyListeners();
  }

  bool isFavorite(Post post) {
    return _favoritePosts.contains(post);
  }
}
