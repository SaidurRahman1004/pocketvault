import 'package:flutter/material.dart';
import '../../../core/database/database_helper.dart';
import '../../../data/models/bookmark_model.dart';


class BookmarkProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  List<Bookmark> _bookmarkItems = [];
  List<Bookmark> get bookmarkItems => _bookmarkItems;

  Future<void> loadBookMarkItems() async {
    _bookmarkItems = await _dbHelper.getAllBookmarks();
    notifyListeners();
  }

  Future<void> addBookMarkItem(Bookmark bookmark) async {
    await _dbHelper.addBookmark(bookmark);
    await loadBookMarkItems();
  }


  Future<void> deleteBookMark(int id) async {
    await _dbHelper.deleteBookmark(id);
    await loadBookMarkItems();
  }
}