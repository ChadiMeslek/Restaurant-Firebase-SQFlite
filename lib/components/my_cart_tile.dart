import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restau/components/my_quantity_selector.dart';
import 'package:restau/models/cart_item.dart';
import 'package:restau/models/restaurant.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;

  const MyCartTile({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        cartItem.food.imagePath,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartItem.food.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${cartItem.food.price.toStringAsFixed(2)} DH',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          QuantitySelector(
                            quantity: cartItem.quantity,
                            food: cartItem.food,
                            onIncrement: () {
                              restaurant.addToCart(
                                cartItem.food,
                                cartItem.selectedAddons,
                              );
                            },
                            onDecrement: () {
                              restaurant.removeFromCart(cartItem);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: cartItem.selectedAddons.isEmpty ? 0 : 60,
                child: ListView(
                  padding:
                      const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                  scrollDirection: Axis.horizontal,
                  children: cartItem.selectedAddons
                      .map<Widget>((addon) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 8),
                            child: Chip(
                              labelStyle: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary),
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              label: Text('${addon.name}: ${addon.price} DH'),
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
