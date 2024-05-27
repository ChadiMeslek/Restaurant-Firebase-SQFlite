import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';
import 'package:restau/components/my_button.dart';
import 'package:restau/pages/delivery_page.dart';
import 'package:restau/themes/appcolors.dart';
import 'package:restau/themes/theme_provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  void userTappedPay() {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Confirm Payment ?"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Card Number: $cardNumber"),
                Text("Expiry Date: $expiryDate"),
                Text("Card Holder Name: $cardHolderName"),
                Text("CVV: $cvvCode"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeliveryProgressPage(),
                ),
              ),
              child: const Text("Yes"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isDarkMode
                  ? 'lib/images/assets/bg-dark.png'
                  : 'lib/images/assets/bg-light.png',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            CreditCardWidget(
              backgroundImage: 'lib/images/assets/card_bg.png',
              cardBgColor: Theme.of(context).colorScheme.inversePrimary,
              glassmorphismConfig: Glassmorphism.defaultConfig(),
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              customCardTypeIcons: <CustomCardTypeIcon>[
                CustomCardTypeIcon(
                  cardType: CardType.mastercard,
                  cardImage: Image.asset(
                    'lib/images/assets/mastercard.png',
                    height: 48,
                    width: 48,
                  ),
                ),
              ],
              onCreditCardWidgetChange: ((p0) {}),
            ),
            CreditCardForm(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              onCreditCardModelChange: (data) {
                setState(() {
                  cardNumber = data.cardNumber;
                  expiryDate = data.expiryDate;
                  cardHolderName = data.cardHolderName;
                  cvvCode = data.cvvCode;
                });
              },
              formKey: formKey,
            ),
            const Spacer(),
            GestureDetector(
              onTap: userTappedPay,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      AppColors.colorB58D67,
                      AppColors.colorB58D67,
                      AppColors.colorE5D1B2,
                      AppColors.colorF9EED2,
                      AppColors.colorEFEFED,
                      AppColors.colorF9EED2,
                      AppColors.colorB58D67,
                    ],
                    begin: Alignment(-1, -4),
                    end: Alignment(1, 4),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                child: const Text(
                  'Validate',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'halter',
                    fontSize: 14,
                    package: 'flutter_credit_card',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
