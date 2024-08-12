import 'package:ecom/data/models/product_model.dart';

class CartItemModel {
  int? quantity;
  String? sId;
  ProductModel? product;

  CartItemModel({this.quantity, this.sId, this.product});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    product = ProductModel.fromJson(json["product"]);
    sId = json['_id'];
  }

  Map<String, dynamic> toJson({bool productMode = false}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["product"] = (productMode == false) ? product!.sId : product!.toJson();
    data['quantity'] = this.quantity;
    data['_id'] = this.sId;
    return data;
  }
}
