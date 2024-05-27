import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restau/services/auth/auth_gate.dart';
import 'package:restau/services/auth/auth_service.dart';
import 'package:restau/services/auth/login_or_register.dart';
import 'package:restau/components/my_drawer_tile.dart';
import 'package:restau/pages/home_page.dart';
import 'package:restau/pages/login.dart';
import 'package:restau/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    void logout() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AuthGate(),
          ));
      final authService = AuthService();
      authService.signOut();
    }

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100),
            child: Image.asset(
              "lib/images/logo/chadi_food.png",
              height: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          MyDrawerTile(
              text: "H O M E",
              icon: Icons.home,
              onTap: () {
                Navigator.pop(context);
              }),
          MyDrawerTile(
              text: "S E T T I N G S",
              icon: Icons.settings,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ));
              }),
          const Spacer(),
          MyDrawerTile(text: "L O G O U T", icon: Icons.logout, onTap: logout),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
