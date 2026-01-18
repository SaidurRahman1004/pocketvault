import 'package:path/path.dart';
import 'package:pocketvault/data/models/media_item_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../../../data/models/shopping_item_model.dart';

class DatabaseHelper {
  //Singleton Pattern For single Global instance
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static DatabaseHelper get instance => _instance;
  static Database? _database; //database instance for store database
  // Database getter for finding database
  Future<Database> get database async {
    //check if database is already created
    if (_database != null) return _database!;
    //if not create new database then return it initialize database
    _database = await _initDatabase();
    return _database!;
  }

  //initialize database //Creating Database
  Future<Database> _initDatabase() async {
    //Get Application Document Directory for find safe memory location into phone to store database
    final documentsDirectory = await getApplicationDocumentsDirectory();
    //create path for database file Name pocketvault.db //Use join to create path
    final path = join(documentsDirectory.path, 'pocketvault.db');
    //open database and return it ,_onCreate: if not exist create new
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //1st Time Caall Whean DAtabafe is created //Create Database Table
  Future<void> _onCreate(Database db, int version) async {
    var sql = '''
          
    CREATE TABLE shopping_items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        isBought INTEGER NOT NULL
    )

    ''';

    await db.execute(sql);

    //Media Item Table
    var mediaSql = '''
    
    CREATE TABLE media_items(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    type TEXT NOT NULL,
    status TEXT NOT NULL,
    rating INTEGER NOT NULL,
    review TEXT NOT NULL
    
    
    )
    ''';
    await db.execute(mediaSql);
  }

  ///CURD Shoping
  //Create
  Future<int> addShoppingItem(ShoppingItem item) async {
    //get database,Sure Database wa created
    final db = await instance.database;
    //insert item into database
    return await db.insert('shopping_items', item.toMap());
  }

  //Read All
  Future<List<ShoppingItem>> getAllShoppingItems() async {
    ////get database,Sure Database wa created
    Database db = await instance.database;
    //get all items from database and orderd by id desc
    var items = await db.query('shopping_items', orderBy: 'id DESC');
    //convert map to object and return list of items ,if database was empty return empty list
    List<ShoppingItem> itemList = items.isNotEmpty
        ? items.map((c) => ShoppingItem.fromMap(c)).toList()
        : [];
    return itemList;
  }

  //Update
  Future<int> updateShoppingItem(ShoppingItem item) async {
    //get database,Sure Database wa created
    Database db = await instance.database;
    //update item in database
    return await db.update(
      'shopping_items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  //Delete
  Future<int> deleteShoppingItem(int id) async {
    //get database,Sure Database wa created
    Database db = await instance.database;
    //Delete item in database
    return await db.delete('shopping_items', where: 'id = ?', whereArgs: [id]);
  }

  //CURD MEDia
  //Post add Item
  Future<int> addMediaItem(MediaItem item) async {
    //get database,Sure Database wa created
    final db = await instance.database;
    //insert item into database
    return await db.insert('media_items', item.toMap());
  }

  //Featch All Items From DB
  Future<List<MediaItem>> getAllMediaItems() async {
    //get database,Sure Database wa created
    Database db = await instance.database;
    //get all items from database and orderd by id desc
    var items = await db.query('media_items', orderBy: 'id DESC');
    //convert map to object and return list of items ,if database was empty return empty list
    List<MediaItem> itemList = items.isNotEmpty
        ? items.map((c) {
            return MediaItem.fromMap(c);
          }).toList()
        : [];
    return itemList;
  }

  //Update Media Item
  Future<int> updateMediaItem(MediaItem item) async {
    //get database,Sure Database wa created
    Database db = await instance.database;
    //update item in database
    return db.update(
      'media_items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  //Delete Media Item
  Future<int> deleteMediaItem(int id) async {
    //get database,Sure Database wa created
    Database db = await instance.database;
    //Delete item in database
    return await db.delete('media_items', where: 'id = ?', whereArgs: [id]);
  }
}
