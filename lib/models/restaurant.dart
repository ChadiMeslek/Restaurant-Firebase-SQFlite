import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restau/models/cart_item.dart';
import 'package:restau/models/food.dart';

class Restaurant extends ChangeNotifier {
  // list of food menu

  final List<Food> _menu = [
    // burgers
    Food(
      name: "Aloha Burger",
      description: "A delicious burger with pineapple and teriyaki sauce.",
      imagePath: "lib/images/burgers/aloha_burger.png",
      price: 40.0, // Moroccan Dirham
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra cheese", price: 10.0),
        Addon(name: "Extra Sauce", price: 5.0),
        Addon(name: "Avocado", price: 15.0)
      ],
    ),
    Food(
      name: "BBQ Burger",
      description: "A smoky BBQ burger with caramelized onions and BBQ sauce.",
      imagePath: "lib/images/burgers/bbq_burger.png",
      price: 35.0,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra cheese", price: 10.0),
        Addon(name: "Extra Sauce", price: 5.0),
        Addon(name: "Avocado", price: 15.0)
      ],
    ),
    Food(
      name: "Blue Moon Burger",
      description: "A unique burger with blue cheese and bacon.",
      imagePath: "lib/images/burgers/bluemoon_burger.png",
      price: 45.0,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra cheese", price: 5.0),
        Addon(name: "Avocado", price: 10.0),
      ],
    ),
    Food(
      name: "Cheeseburger",
      description: "A classic cheeseburger with melted cheddar.",
      imagePath: "lib/images/burgers/cheese_burger.png",
      price: 30.0,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra cheese", price: 5.0),
        Addon(name: "Avocado", price: 10.0),
      ],
    ),
    Food(
      name: "Vegetarian Burger",
      description: "A delicious veggie burger with fresh vegetables.",
      imagePath: "lib/images/burgers/vege_burger.png",
      price: 35.0,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra cheese", price: 10.0),
        Addon(name: "Extra Sauce", price: 5.0),
        Addon(name: "Avocado", price: 15.0)
      ],
    ),
    // salads
    Food(
      name: "Caesar Salad",
      description: "A classic Caesar salad with croutons and parmesan cheese.",
      imagePath: "lib/images/salads/ceaser_salad.png",
      price: 25.0,
      category: FoodCategory.salads,
      availableAddons: [],
    ),
    Food(
      name: "Fruit Salad",
      description: "A refreshing mix of fresh fruits.",
      imagePath: "lib/images/salads/fruit_salad.png",
      price: 20.0,
      category: FoodCategory.salads,
      availableAddons: [],
    ),
    Food(
      name: "Greek Salad",
      description: "A traditional Greek salad with feta cheese and olives.",
      imagePath: "lib/images/salads/greek_salad.png",
      price: 30.0,
      category: FoodCategory.salads,
      availableAddons: [],
    ),
    Food(
      name: "Quinoa Salad",
      description: "A nutritious salad with quinoa and vegetables.",
      imagePath: "lib/images/salads/quinor_salad.png",
      price: 35.0,
      category: FoodCategory.salads,
      availableAddons: [],
    ),
    Food(
      name: "Romaine Salad",
      description: "A simple salad with romaine lettuce and tomatoes.",
      imagePath: "lib/images/salads/romain_salad.png",
      price: 20.0,
      category: FoodCategory.salads,
      availableAddons: [],
    ),
    // desserts
    Food(
      name: "Cheesecake",
      description: "A rich and creamy cheesecake topped with fruit compote.",
      imagePath: "lib/images/desserts/cheesecake_dessert.png",
      price: 40.0,
      category: FoodCategory.desserts,
      availableAddons: [],
    ),
    Food(
      name: "Cupcake",
      description: "A sweet and fluffy cupcake with frosting.",
      imagePath: "lib/images/desserts/cupcake_dessert.png",
      price: 15.0,
      category: FoodCategory.desserts,
      availableAddons: [],
    ),
    Food(
      name: "Donut",
      description: "A classic glazed donut.",
      imagePath: "lib/images/desserts/donut_dessert.png",
      price: 10.0,
      category: FoodCategory.desserts,
      availableAddons: [],
    ),
    Food(
      name: "Waffles",
      description: "Delicious waffles topped with syrup and whipped cream.",
      imagePath: "lib/images/desserts/waffles_dessert.png",
      price: 30.0,
      category: FoodCategory.desserts,
      availableAddons: [],
    ),
    // drinks
    Food(
      name: "Coffee",
      description: "A hot cup of freshly brewed coffee.",
      imagePath: "lib/images/drinks/coffee_drink.png",
      price: 15.0,
      category: FoodCategory.drinks,
      availableAddons: [],
    ),
    Food(
      name: "Juice",
      description: "A refreshing glass of mixed fruit juice.",
      imagePath: "lib/images/drinks/juice_drink.png",
      price: 20.0,
      category: FoodCategory.drinks,
      availableAddons: [],
    ),
    Food(
      name: "Milkshake",
      description: "A creamy milkshake in your favorite flavor.",
      imagePath: "lib/images/drinks/milkshake_drink.png",
      price: 25.0,
      category: FoodCategory.drinks,
      availableAddons: [],
    ),
    Food(
      name: "Soda",
      description: "A fizzy soda in your favorite flavor.",
      imagePath: "lib/images/drinks/soda_drink.png",
      price: 10.0,
      category: FoodCategory.drinks,
      availableAddons: [],
    ),
    // sides
    Food(
      name: "Garlic Bread",
      description: "Warm garlic bread with butter and garlic.",
      imagePath: "lib/images/sides/garlicbread_side.png",
      price: 15.0,
      category: FoodCategory.sides,
      availableAddons: [],
    ),
    Food(
      name: "Loaded Fries",
      description: "Crispy fries loaded with cheese, bacon, and sour cream.",
      imagePath: "lib/images/sides/loadedfries_side.png",
      price: 30.0,
      category: FoodCategory.sides,
      availableAddons: [
        Addon(name: "Extra cheese", price: 5.0),
        Addon(name: "Extra sour cream", price: 5.0),
      ],
    ),
    Food(
      name: "Onion Rings",
      description: "Crunchy onion rings with a crispy coating.",
      imagePath: "lib/images/sides/onionrings_side.png",
      price: 25.0,
      category: FoodCategory.sides,
      availableAddons: [],
    ),
  ];

  List<Food> get menu => _menu;

  List<CartItem> get cart => _cart;

  final List<CartItem> _cart = [];
  void addToCart(Food food, List<Addon> selectedAddons) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      bool isSameFood = item.food == food;

      bool isSameAddons =
          ListEquality().equals(item.selectedAddons, selectedAddons);

      return isSameFood && isSameAddons;
    });

    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(
        CartItem(food: food, selectedAddons: selectedAddons),
      );
    }
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);
    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0.0;
    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }

      total += itemTotal * cartItem.quantity;
    }

    return total;
  }

  int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here is your receipt.");
    receipt.writeln();

    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("----------");

    for (final CartItem in _cart) {
      receipt.writeln(
          "${CartItem.quantity} x  ${CartItem.food.name} - ${_formatPrice(CartItem.food.price)}");
      if (CartItem.selectedAddons.isNotEmpty) {
        receipt.writeln("  Add ons: ${_formatAddons(CartItem.selectedAddons)}");
      }
      receipt.writeln();
    }
    receipt.writeln("----------");
    receipt.writeln("");
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");

    return receipt.toString();
  }

  String _formatPrice(double price) {
    return "${price.toStringAsFixed(2)} DH";
  }

  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(", ");
  }
}
