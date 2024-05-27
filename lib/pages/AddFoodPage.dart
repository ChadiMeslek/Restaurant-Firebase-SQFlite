import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restau/components/my_add_food_textfield.dart';
import 'package:restau/components/my_button.dart';
import 'package:restau/models/food.dart';
import 'package:restau/models/foodfordb.dart';
import 'package:restau/models/addonfordb.dart';
import 'package:restau/models/newrestaurant.dart';
import 'package:restau/services/database/restaurantdb.dart';

class AddFoodPage extends StatefulWidget {
  @override
  _AddFoodPageState createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imagePathController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  FoodCategory? _selectedCategory;
  List<FoodCategory> _categories = [
    FoodCategory.burgers,
    FoodCategory.salads,
    FoodCategory.drinks,
    FoodCategory.desserts,
  ];

  List<AddonForDB> _availableAddons = [];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _imagePathController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _saveFood(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final String categoryPrefix =
          _selectedCategory.toString().split('.').last;
      final String imagePath =
          'lib/images/$categoryPrefix/${_imagePathController.text}';

      final FoodForDB food = FoodForDB(
        id: 0,
        name: _nameController.text,
        description: _descriptionController.text,
        imagePath: imagePath,
        price: double.parse(_priceController.text),
        category: _selectedCategory!,
        availableAddons: _availableAddons,
      );

      Provider.of<NewMenuRestaurant>(context, listen: false).addToNewMenu(food);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Food'),
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AddFoodTextField(
                    controller: _nameController,
                    hintText: 'Name',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  AddFoodTextField(
                    controller: _descriptionController,
                    hintText: 'Description',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  AddFoodTextField(
                    controller: _imagePathController,
                    hintText: 'Image Name',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an image path';
                      }
                      return null;
                    },
                  ),
                  AddFoodTextField(
                    controller: _priceController,
                    hintText: 'Price',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid price';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<FoodCategory>(
                    decoration: InputDecoration(labelText: 'Category'),
                    value: _selectedCategory,
                    items: _categories.map((category) {
                      return DropdownMenuItem<FoodCategory>(
                        value: category,
                        child: Text(category.toString().split('.').last),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  MyButton(
                    OnTap: () => _saveFood(context),
                    text: "Save",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
