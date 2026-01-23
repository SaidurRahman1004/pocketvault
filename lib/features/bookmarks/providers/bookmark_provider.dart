import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../core/api/api_service.dart';
import '../../../core/database/database_helper.dart';
import '../../../data/models/bookmark_model.dart';

class BookmarkProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  List<Bookmark> _bookmarkItems = [];

  List<Bookmark> get bookmarkItems => _bookmarkItems;
  bool isLoading = false;

  Future<void> loadBookMarkItems() async {
    /*
    _bookmarkItems = await _dbHelper.getAllBookmarks();
    notifyListeners();

     */
    isLoading = true;
    notifyListeners();
    try {
      final response = await ApiService.get('bookmarks');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _bookmarkItems = data.map((item) => Bookmark.fromMap(item)).toList();
      } else {
        _bookmarkItems = [];
      }
    } catch (e) {
      _bookmarkItems = [];
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> addBookMarkItem(Bookmark bookmark) async {
    /*
    //Sqflite

    await _dbHelper.addBookmark(bookmark);
    await loadBookMarkItems();

     */
    try {
      final response = await ApiService.post('bookmarks', bookmark.toMap());
      if (response.statusCode == 201) {
        await loadBookMarkItems();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteBookMark(int id) async {
    /*
    //sqflite
    await _dbHelper.deleteBookmark(id);
    await loadBookMarkItems();

     */
    try {
      final response = await ApiService.delete('bookmarks', id);
      if (response.statusCode == 204) {
        _bookmarkItems.removeWhere((item) => item.id == id);
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
