import 'package:flutter/cupertino.dart';

import '../../../core/database/database_helper.dart';
import '../../../data/models/shopping_item_model.dart';

class ShoppingProvider extends ChangeNotifier {
  //Database Helper Instance
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  //Store All Shoping Items from Database
  List<ShoppingItem> _shoppingItems = [];

  List<ShoppingItem> get shoppingItems => _shoppingItems;

  //All Item Load From Database and store in _shoppingItems
  Future<void> loadItems() async {
    //get all items from database and store in items in _shoppingItems
    final items = await _dbHelper.getAllShoppingItems();
    //Store items in _shoppingItems
    _shoppingItems = items;
    notifyListeners();
  }

  //add item
  Future<void> addItem(ShoppingItem item) async {
    await _dbHelper.addShoppingItem(item);
    //after adding load _shoppingItems
    loadItems();
  }

  //toggle  item for isBought
  Future<void> toggleBoughtStatus(ShoppingItem item) async {
    item.isBought = !item.isBought;
    //update item in database
    await _dbHelper.updateShoppingItem(item);
    //after toggle update load _shoppingItems
    loadItems();
  }

  //delete
  Future<void> deleteItem(int id) async {
    await _dbHelper.deleteShoppingItem(id);
    await loadItems(); //after deleting load _shoppingItems
  }
}
