import 'package:path/path.dart';
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
          
    Create TABLE shopping_items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        isBought INTEGER NOT NULL
    )

    ''';
    await db.execute(sql);
  }
}
