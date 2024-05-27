import 'package:flutter/material.dart';
import 'package:restau/models/food.dart';
import 'package:restau/models/foodfordb.dart';
import 'package:restau/models/addonfordb.dart';

class NewMenuRestaurant extends ChangeNotifier {
  List<Food> _newMenu = [];

  List<Food> get newMenu => _newMenu;

  void addToNewMenu(FoodForDB foodForDB) {
    final List<Addon> addons = foodForDB.availableAddons
        .map((addonForDB) => Addon(
              name: addonForDB.name,
              price: addonForDB.price,
            ))
        .toList();

    final Food newFood = Food(
      name: foodForDB.name,
      description: foodForDB.description,
      imagePath: foodForDB.imagePath,
      price: foodForDB.price,
      category: foodForDB.category,
      availableAddons: addons,
    );
    _newMenu.add(newFood);
    notifyListeners();
  }

  void removeFromNewMenu(Food food) {
    _newMenu.remove(food);
    notifyListeners();
  }

  void clearNewMenu() {
    _newMenu.clear();
    notifyListeners();
  }
}
