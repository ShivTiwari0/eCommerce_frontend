import 'package:flutter/widgets.dart';

class OrderDetailProvider extends ChangeNotifier {
  String? paymentMethod = "Pay-Now";
  void changePaymentMethod(String? value) {
    paymentMethod = value;
    notifyListeners();
  }
}
