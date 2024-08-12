import 'dart:async';

import 'package:ecom/data/models/cart_item_model.dart';
import 'package:ecom/data/models/product_model.dart';

import 'package:ecom/data/repository/cart_repository.dart';
import 'package:ecom/logic/cubits/cart_cubit.dart/cart_state.dart';
import 'package:ecom/logic/cubits/user_cubits/useer_state.dart';
import 'package:ecom/logic/cubits/user_cubits/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubt extends Cubit<CartState> {
  final UserCubit _userCubit;
  StreamSubscription? _userSubscription;
  CartCubt(this._userCubit) : super(CartInitialState()) {
    //initial Value
    _handleUserState(_userCubit.state);
    //Listning to UserCubit(for future updates)
    _userSubscription = _userCubit.stream.listen(_handleUserState);
  }
  void _handleUserState(UserState userState) {
    if (userState is UserLoggedInState) {
      final userId = userState.userModel.sId;

      if (userId != null) {
        _initialize(userId);
      } else {
        emit(CartErrorState(state.items, 'User ID is null'));
      }
    } else if (userState is UserLogoutState) {
      emit(CartInitialState());
    }
  }

  void sortAndLoad(List<CartItemModel> items) {
    items.sort(
      (a, b) => a.product!.title!.compareTo(b.product!.title!),
    );
      emit(CartLoadedState(items));
  }

  final _cartRepository = CartRepository();

  void _initialize(String userId) async {
    emit(CartLoadingState(state.items));
    try {
      final items = await _cartRepository.fetchAllCartItem(userId);
      sortAndLoad(items);
     
    } catch (e) {
      emit(CartErrorState(state.items, e.toString()));
    }
  }

  void addToCart(ProductModel product, int quantity) async {
    emit(CartLoadingState(state.items));
    try {
      if (_userCubit.state is UserLoggedInState) {
        UserLoggedInState userstate = _userCubit.state as UserLoggedInState;

        CartItemModel newItem =
            CartItemModel(product: product, quantity: quantity);
        final newItems =
            await _cartRepository.addToCart(newItem, userstate.userModel.sId!);
            sortAndLoad(newItems);
      
      } else {
        throw " An Error occured while adding to item ";
      }
    } catch (e) {
      emit(CartErrorState(state.items, e.toString()));
    }
  }

  bool cartContains(ProductModel product) {
    if (state.items.isNotEmpty) {
      final foundItem = state.items
          .where((item) => item.product!.sId! == product.sId!)
          .toList();

      if (foundItem.isNotEmpty) {
        return true;
      } else {
        false;
      }
    }
    return false;
  }

  void removeFromCart(ProductModel product) async {
    emit(CartLoadingState(state.items));
    try {
      if (_userCubit.state is UserLoggedInState) {
        UserLoggedInState userstate = _userCubit.state as UserLoggedInState;

        final newItems = await _cartRepository.removeFromCart(
            product.sId!, userstate.userModel.sId!);
            sortAndLoad(newItems);
      
      } else {
        throw " An Error occured while removing to item ";
      }
    } catch (e) {
      emit(CartErrorState(state.items, e.toString()));
    }
  }
void clearCart(){
  emit(CartLoadedState([]));
}
  @override
  Future<void> close() {
    _userSubscription!.cancel();
    return super.close();
  }
}
