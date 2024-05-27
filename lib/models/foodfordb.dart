import 'package:restau/models/addonfordb.dart';
import 'package:restau/models/food.dart';

class FoodForDB {
  final int id; // Add an ID field for database operations
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final FoodCategory category;
  List<AddonForDB> availableAddons;

  FoodForDB({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.availableAddons,
  });

  // Convert a FoodForDB object into a Map<String, dynamic> for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'price': price,
      'category': category.toString(), // Convert enum to string
      'addons': availableAddons.map((addon) => addon.toMap()).toList(),
    };
  }

  // Construct a FoodForDB object from a Map<String, dynamic> retrieved from the database
  factory FoodForDB.fromMap(Map<String, dynamic> map) {
    return FoodForDB(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imagePath: map['imagePath'],
      price: map['price'],
      category: FoodCategory.values
          .firstWhere((e) => e.toString() == map['category']),
      availableAddons: List<AddonForDB>.from(
          map['addons'].map((addonMap) => AddonForDB.fromMap(addonMap))),
    );
  }
}
