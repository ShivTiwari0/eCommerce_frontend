import 'dart:async';

import 'package:ecom/data/models/cart_item_model.dart';
import 'package:ecom/data/models/order_model.dart';
import 'package:ecom/data/repository/order_repository.dart';
import 'package:ecom/logic/cubits/cart_cubit.dart/cart_cubit.dart';
import 'package:ecom/logic/cubits/cart_cubit.dart/cart_state.dart';
import 'package:ecom/logic/cubits/user_cubits/useer_state.dart';
import 'package:ecom/logic/cubits/user_cubits/user_cubit.dart';
import 'package:ecom/logic/services/calculation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final UserCubit _userCubit;
  final CartCubt _cartCubt;
  StreamSubscription? _userSubscription;

  OrderCubit(this._userCubit, this._cartCubt) : super(OrderInitialState()) {
    //initial Value
    _handleUserState(_userCubit.state);
    //Listning to UserCubit(for future updates)
    _userSubscription = _userCubit.stream.listen(_handleUserState);
  }

  final _repository = OrderRepository();

  void _handleUserState(UserState userState) {
    if (userState is UserLoggedInState) {
      final userId = userState.userModel.sId;

      if (userId != null) {
        _initialize(userId);
      } else {
        emit(OrderErrorState(state.orders, 'User ID is null'));
      }
    } else if (userState is UserLogoutState) {
      emit(OrderInitialState());
    }
  }

  void _initialize(String userId) async {
    emit(OrderLoadingState(state.orders));
    try {
      final orders = await _repository.fetchOrdersForUser(userId);

      emit(OrderLoadedState(orders));
    } catch (e) {
      emit(OrderErrorState(state.orders, e.toString()));
    }
  }

  Future<OrderModel?> createOrder(
      {required List<CartItemModel> items,
      required String paymentMethod}) async {
    emit(OrderLoadingState(state.orders));

    if (_userCubit.state is! UserLoggedInState) {
      return null;
    }

    try {
      OrderModel newOrder = OrderModel(
          user: (_userCubit.state as UserLoggedInState).userModel,
          items: items,
          totalAmount: Calculations.cartTotal(items),
          status: (paymentMethod == 'Pay-On-Delivery')
              ? "order-placed"
              : "payment-pending");
      final order = await _repository.createOrder(newOrder);
      List<OrderModel> orders = [order, ...state.orders];
      emit(OrderLoadedState(orders));
      //clearing the cart
      _cartCubt.clearCart();

      return order;
    } catch (e) {
      emit(OrderErrorState(state.orders, e.toString()));
      return null;
    }
  }

  Future<bool> updateOrder(OrderModel ordermodel,
      {String? signature, String? paymentId}) async {
    try {
      OrderModel updatedOrder = await _repository.updateOrder(ordermodel,
          paymentId: paymentId, signature: signature);

      int index = state.orders.indexOf(updatedOrder);
      if (index == -1) {
        return false;
      }
      List<OrderModel> newList = state.orders;
      newList[index] = updatedOrder;
      emit(OrderLoadedState(newList));
      return true;
    } catch (e) {
      emit(OrderErrorState(state.orders, e.toString()));
      return false;
    }
  } 

  @override
  Future<void> close() { 
    _userSubscription?.cancel();
    return super.close(); 
  } 
}
