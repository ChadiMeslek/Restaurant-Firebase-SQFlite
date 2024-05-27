import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:restau/models/foodfordb.dart';
import 'package:restau/models/addonfordb.dart';

class RestaurantDatabase {
  static Database? _database;

  RestaurantDatabase._();

  static final RestaurantDatabase instance = RestaurantDatabase._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'restaurant.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE foods(id INTEGER PRIMARY KEY, name TEXT, description TEXT, imagePath TEXT, price REAL, category TEXT, addons TEXT)",
        );
        db.execute(
          "CREATE TABLE addons(id INTEGER PRIMARY KEY, name TEXT, price REAL)",
        );
      },
    );
  }

  Future<void> insertFood(FoodForDB food) async {
    final db = await database;
    await db.insert(
      'foods',
      food.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<FoodForDB>> getAllFoods() async {
    final db = await database;
    final List<Map<String, dynamic>> foodMaps = await db.query('foods');

    return List.generate(foodMaps.length, (i) {
      return FoodForDB.fromMap(foodMaps[i]);
    });
  }

  Future<void> updateFood(FoodForDB food) async {
    final db = await database;
    await db.update(
      'foods',
      food.toMap(),
      where: 'id = ?',
      whereArgs: [food.id],
    );
  }

  Future<void> deleteFood(int id) async {
    final db = await database;
    await db.delete(
      'foods',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Similar methods for Addons
}
