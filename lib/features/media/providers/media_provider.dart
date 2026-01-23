import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../core/api/api_service.dart';
import '../../../core/database/database_helper.dart';
import '../../../data/models/media_item_model.dart';

class MediaProvider extends ChangeNotifier {
  //Singleton Pattern For single Global instance
  static final MediaProvider _instance = MediaProvider._internal();

  factory MediaProvider() => _instance;

  MediaProvider._internal();

  static MediaProvider get instance => _instance;

  //Instance of DatabaseHelper
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  //_mediaItems For Store Media Items from Database
  List<MediaItem> _mediaItems = [];

  List<MediaItem> get mediaItems => _mediaItems;
  bool isLoading = false;

  Future<void> loadMediaItems() async {
    /*
    //get all items from database and store in items in _mediaItems
    final items = await _dbHelper.getAllMediaItems();
    //Store items in _mediaItems
    _mediaItems = items;
    //Notify Listeners
    notifyListeners();

     */
    isLoading = true;
    notifyListeners();
    try {
      final response = await ApiService.get('media-items');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _mediaItems = data.map((item) => MediaItem.fromMap(item)).toList();
      } else {
        _mediaItems = [];
      }
    } catch (e) {
      _mediaItems = [];
    }
    isLoading = false;
    notifyListeners();
  }

  //Add item
  Future<void> addMediaItem(MediaItem item) async {
    /*
    //add item to database
    await _dbHelper.addMediaItem(item);
    //after adding load _mediaItems
    await loadMediaItems();

     */
    try {
      final response = await ApiService.post('media-items', item.toMap());
      if (response.statusCode == 201) {
        final dynamic data = jsonDecode(response.body);
        _mediaItems.add(MediaItem.fromMap(data));
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //Update Item
  Future<void> updateMediaItem(MediaItem item) async {
    /*
    //update item to database
    await _dbHelper.updateMediaItem(item);
    //after update load _mediaItems
    await loadMediaItems();

   */
    try {
      final response = await ApiService.put(
        'media-items',
        item.id!,
        item.toMap(),
      );
      if (response.statusCode == 200) {
        int index = _mediaItems.indexWhere((element) => element.id == item.id);
        if (index != -1) {
          _mediaItems[index] = item;
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //Delete
  Future<void> deleteMediaItem(int id) async {
    /*
    //delete item to database
    await _dbHelper.deleteMediaItem(id);
    //delete update load _mediaItems
    await loadMediaItems();
  }

     */
    try {
      final response = await ApiService.delete('media-items', id);
      if (response.statusCode == 204) {
        _mediaItems.removeWhere((item) => item.id == id);
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
