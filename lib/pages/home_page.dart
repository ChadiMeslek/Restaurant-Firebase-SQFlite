import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restau/components/my_current_location.dart';
import 'package:restau/components/my_description_box.dart';
import 'package:restau/components/my_drawer.dart';
import 'package:restau/components/my_food_tile.dart';
import 'package:restau/components/my_sliver_app_bar.dart';
import 'package:restau/components/my_tab_bar.dart';
import 'package:restau/models/food.dart';
import 'package:restau/models/newrestaurant.dart';
import 'package:restau/models/restaurant.dart';
import 'package:restau/pages/AddFoodPage.dart';
import 'package:restau/pages/ModifyFoodPage.dart';
import 'package:restau/pages/RemoveFoodPage.dart';
import 'package:restau/pages/food_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Food> _filterMenuByCategory(
      FoodCategory category, List<Food> fullMenu, List<Food> newMenu) {
    return [...fullMenu, ...newMenu]
        .where((food) => food.category == category)
        .toList();
  }

  List<Widget> getFoodInThisCategory(List<Food> fullMenu, List<Food> newMenu) {
    return FoodCategory.values.map((category) {
      List<Food> categoryMenu =
          _filterMenuByCategory(category, fullMenu, newMenu);
      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final food = categoryMenu[index];
          return MyFoodTile(
            food: food,
            OnTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodPage(food: food),
                ),
              );
            },
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddFoodPage())),
            icon: Icon(Icons.add_circle_rounded),
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => RemoveFoodPage())),
            icon: Icon(Icons.remove_circle_rounded),
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ModifyFoodPage())),
            icon: Icon(Icons.edit),
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppBar(
            title: MyTabBar(tabController: _tabController),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const MyCurrentLocation(),
                const MyDescriptionBox(),
              ],
            ),
          )
        ],
        body: Consumer2<Restaurant, NewMenuRestaurant>(
          builder: (context, restaurant, newMenuRestaurant, child) =>
              TabBarView(
            controller: _tabController,
            children: getFoodInThisCategory(
                restaurant.menu, newMenuRestaurant.newMenu),
          ),
        ),
      ),
    );
  }
}
