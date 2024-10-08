import 'package:ecom/data/models/order_model.dart';

abstract class OrderState{
  final List<OrderModel> orders;

  OrderState(this.orders);
}

class OrderInitialState extends OrderState{
  OrderInitialState():super([]);
}

class OrderLoadingState extends OrderState{
  OrderLoadingState(super.orders);
}

class OrderLoadedState extends OrderState{
  OrderLoadedState(super.orders);
  
}
class OrderErrorState extends OrderState{
  final String message;

  OrderErrorState(super.orders, this.message);
}