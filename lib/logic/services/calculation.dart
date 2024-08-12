import 'package:ecom/data/models/cart_item_model.dart';

class Calculations {
  static double cartTotal(List<CartItemModel> items) {
    double total = 0;

    for (int i = 0; i < items.length; i++) {
      total += items[i].product!.prices! * items[i].quantity!;
    }
    return total;
  }
}
