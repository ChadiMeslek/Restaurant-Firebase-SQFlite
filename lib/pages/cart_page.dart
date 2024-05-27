import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restau/components/my_button.dart';
import 'package:restau/components/my_cart_tile.dart';
import 'package:restau/models/cart_item.dart';
import 'package:restau/models/restaurant.dart';
import 'package:restau/pages/payement_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        final userCart = restaurant.cart;
        return Scaffold(
            appBar: AppBar(
              title: const Text("Cart"),
              backgroundColor: Colors.transparent,
              foregroundColor: Theme.of(context).colorScheme.inversePrimary,
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(
                              "Are you sure you want to clear the cart ?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                "Cancel",
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                restaurant.clearCart();
                              },
                              child: const Text(
                                "Yes",
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      userCart.isEmpty
                          ? const Expanded(
                              child: Center(child: Text("Cart is empty...")))
                          : Expanded(
                              child: ListView.builder(
                                  itemCount: userCart.length,
                                  itemBuilder: ((context, index) {
                                    final CartItem = userCart[index];
                                    return MyCartTile(cartItem: CartItem);
                                  }))),
                    ],
                  ),
                ),
                if (userCart.isNotEmpty)
                  Column(
                    children: [
                      MyButton(
                          OnTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PaymentPage(),
                              )),
                          text: "Go to Checkout"),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  )
              ],
            ));
      },
    );
  }
}
