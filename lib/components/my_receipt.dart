import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restau/components/my_button.dart';
import 'package:restau/models/restaurant.dart';
import 'package:restau/pages/home_page.dart';

class MyReceipt extends StatelessWidget {
  const MyReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    // Calculate the estimated delivery time (e.g., 20 minutes later)
    DateTime estimatedDeliveryTime = now.add(Duration(minutes: 20));
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 50),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "lib/images/assets/delivery.gif",
              height: 150,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Thank you for your order!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary),
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(25),
              child: Consumer<Restaurant>(
                builder: (context, restaurant, child) =>
                    Text(restaurant.displayCartReceipt()),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
                "Estimated delivery time is: ${estimatedDeliveryTime.hour}:${estimatedDeliveryTime.minute} "),
            const SizedBox(
              height: 25,
            ),
            MyButton(
                OnTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    )),
                text: "Back To Home Page"),
          ],
        ),
      ),
    );
  }
}
