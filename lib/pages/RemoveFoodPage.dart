import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restau/models/food.dart';
import 'package:restau/models/newrestaurant.dart';

class RemoveFoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remove Food'),
        centerTitle: true,
      ),
      body: Consumer<NewMenuRestaurant>(
        builder: (context, newMenuRestaurant, child) {
          return ListView.builder(
            itemCount: newMenuRestaurant.newMenu.length,
            itemBuilder: (context, index) {
              final Food food = newMenuRestaurant.newMenu[index];
              return ListTile(
                title: Text(food.name),
                subtitle: Text(food.description),
                onTap: () {
                  _showRemoveConfirmationDialog(context, food);
                },
              );
            },
          );
        },
      ),
    );
  }

  void _showRemoveConfirmationDialog(BuildContext context, Food food) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove ${food.name}?'),
        content: Text('Are you sure you want to remove ${food.name}?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _removeFood(context, food);
            },
            child: Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _removeFood(BuildContext context, Food food) {
    final newMenuRestaurant =
        Provider.of<NewMenuRestaurant>(context, listen: false);
    newMenuRestaurant.removeFromNewMenu(food);
    Navigator.of(context).pop(); // Close the dialog
  }
}
