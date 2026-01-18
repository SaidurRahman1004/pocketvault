import 'package:flutter/cupertino.dart';

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

  Future<void> loadMediaItems() async {
    //get all items from database and store in items in _mediaItems
    final items = await _dbHelper.getAllMediaItems();
    //Store items in _mediaItems
    _mediaItems = items;
    //Notify Listeners
    notifyListeners();
  }
  //Add item
  Future<void> addMediaItem(MediaItem item) async{
    //add item to database
    await _dbHelper.addMediaItem(item);
    //after adding load _mediaItems
    await loadMediaItems();
  }

  //Update Item
  Future<void> updateMediaItem(MediaItem item) async{
    //update item to database
    await _dbHelper.updateMediaItem(item);
    //after update load _mediaItems
    await loadMediaItems();
  }

  //Delete
  Future<void> deleteMediaItem(int id) async{
    //delete item to database
    await _dbHelper.deleteMediaItem(id);
    //delete update load _mediaItems
    await loadMediaItems();
  }
}
