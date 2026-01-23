import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pocketvault/core/api/api_service.dart';

import '../../../core/database/database_helper.dart';
import '../../../data/models/shopping_item_model.dart';

class ShoppingProvider extends ChangeNotifier {
  //Database Helper Instance
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  //Store All Shoping Items from Database
  List<ShoppingItem> _shoppingItems = [];

  List<ShoppingItem> get shoppingItems => _shoppingItems;
  bool isLoading = false;

  //All Item Load From Database and store in _shoppingItems
  Future<void> loadItems() async {
    //sqflite
    /*
    //get all items from database and store in items in _shoppingItems
    final items = await _dbHelper.getAllShoppingItems();
    //Store items in _shoppingItems
    _shoppingItems = items;
    notifyListeners();
    
     */
    //load data from Api
    isLoading = true;
    notifyListeners();
    try {
      final response = await ApiService.get('shopping-items');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _shoppingItems = data
            .map((item) => ShoppingItem.fromMap(item))
            .toList();
      } else {
        _shoppingItems = [];
      }
    } catch (e) {
      _shoppingItems = [];
    }
    isLoading = false;
    notifyListeners();
  }

  //add item
  Future<void> addItem(ShoppingItem item) async {
    /*
    //sqflite
    await _dbHelper.addShoppingItem(item);
    //after adding load _shoppingItems
    loadItems();

     */
    try {
      final response = await ApiService.post('shopping-items', item.toMap());
      if (response.statusCode == 201) {
        await loadItems();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //toggle  item for isBought
  Future<void> toggleBoughtStatus(ShoppingItem item) async {
    /*
    //sqflite
    item.isBought = !item.isBought;
    //update item in database
    await _dbHelper.updateShoppingItem(item);
    //after toggle update load _shoppingItems
    loadItems();

     */
    final originalStatus = item.isBought;
    item.isBought = !item.isBought; //state change
    try{
      final response = await ApiService.put('shopping-items', item.id!, item.toMap());
      if(response.statusCode != 200){
        item.isBought = originalStatus;
        notifyListeners();
      }else{
        notifyListeners();
      }

    }catch(e){
      item.isBought = originalStatus;
      notifyListeners();
    }


  }

  //delete
  Future<void> deleteItem(int id) async {
    /*
    //sqflite
    await _dbHelper.deleteShoppingItem(id);
    await loadItems(); //after deleting load _shoppingItems

     */

    try {
      final response = await ApiService.delete('shopping-items', id);

      if (response.statusCode == 204) {
        _shoppingItems.removeWhere((item) => item.id == id);
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
