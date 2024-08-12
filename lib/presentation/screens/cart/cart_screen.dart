import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/core/ui.dart';
import 'package:ecom/logic/cubits/cart_cubit.dart/cart_cubit.dart';
import 'package:ecom/logic/cubits/cart_cubit.dart/cart_state.dart';
import 'package:ecom/logic/services/calculation.dart';
import 'package:ecom/logic/services/formater.dart';
import 'package:ecom/presentation/screens/order/order_detail_screen.dart';
import 'package:ecom/presentation/widgets/cart_list_view.dart';
import 'package:ecom/presentation/widgets/link_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const routeName = "cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: SafeArea(
          child: BlocBuilder<CartCubt, CartState>(builder: (context, state) {
        if (state is CartLoadingState && state.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CartErrorState && state.items.isEmpty) {
          return Center(child: Text(state.message));
        }
        if(state is CartLoadedState && state.items.isEmpty){
          return const Center(child: Text("Cart is empty"));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CartListView(items: state.items)
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        Text(
                          "${state.items.length}",
                          style: TextStyles.body1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "Total: ${Formatter.formatPrice(Calculations.cartTotal(state.items))}",
                            style: TextStyles.body2
                                .copyWith(fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                  FilledButton(
                      child: const Text("Place Order"), onPressed: () {Navigator.pushNamed(context, OrderDetailScreen.routeName);})
                ],
              ),
            )
          ],
        );
      })),
    );
  }
}
