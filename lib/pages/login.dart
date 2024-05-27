import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restau/components/my_button.dart';
import 'package:restau/components/my_textfield.dart';
import 'package:restau/pages/home_page.dart';
import 'package:restau/services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    /*
    authentification
    */
    final _authService = AuthService();

    try {
      await _authService.signUpWithEmailPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }

    //HOME PAGE IF USER EXISTS AND PASSWORD IS CORRECT
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            "lib/images/logo/chadi_food.png",
            height: 150,
          )),
          const SizedBox(height: 25),
          Text(
            "Food Delivery App",
            style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary),
          ),
          const SizedBox(height: 25),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false)),
          const SizedBox(height: 10),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true)),
          const SizedBox(height: 10),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: MyButton(OnTap: login, text: "Sign In")),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member yet ?",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                  onTap: widget.onTap,
                  child: Text("Register Now",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold)))
            ],
          )
        ],
      ),
    );
  }
}
