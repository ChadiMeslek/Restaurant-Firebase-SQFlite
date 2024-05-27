import "package:flutter/material.dart";
import "package:restau/components/my_button.dart";
import "package:restau/components/my_textfield.dart";
import "package:restau/services/auth/auth_service.dart";

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  void register() async {
    final _authService = AuthService();

    if (passwordController.text == confirmpasswordController.text) {
      try {
        await _authService.signInWithEmailPassword(
            emailController.text, passwordController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Passwords don't match!"),
        ),
      );
    }
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
            ),
          ),
          const SizedBox(height: 25),
          Text(
            "Let's create an account for you",
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
              child: MyTextField(
                  controller: confirmpasswordController,
                  hintText: "Confirm Password",
                  obscureText: true)),
          const SizedBox(height: 10),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: MyButton(OnTap: register, text: "Sign Up")),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Aleady have an account ?",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                  onTap: widget.onTap,
                  child: Text("Login Now",
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
