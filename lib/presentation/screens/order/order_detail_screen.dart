import 'dart:developer';

import 'package:ecom/core/ui.dart';
import 'package:ecom/data/models/order_model.dart';
import 'package:ecom/data/models/user_model.dart';
import 'package:ecom/logic/cubits/cart_cubit.dart/cart_cubit.dart';
import 'package:ecom/logic/cubits/cart_cubit.dart/cart_state.dart';
import 'package:ecom/logic/cubits/order_cubit/order_cubit.dart';
import 'package:ecom/logic/cubits/user_cubits/useer_state.dart';
import 'package:ecom/logic/cubits/user_cubits/user_cubit.dart';
import 'package:ecom/logic/services/razorpay.dart';
import 'package:ecom/presentation/screens/order/order_placed_screen.dart';
import 'package:ecom/presentation/screens/order/providers/order_detail_provider.dart';
import 'package:ecom/presentation/screens/user/edit_profile.dart';
import 'package:ecom/presentation/widgets/cart_list_view.dart';
import 'package:ecom/presentation/widgets/gap_widget.dart';
import 'package:ecom/presentation/widgets/link_button.dart';
import 'package:ecom/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});
  static const routeName = "order_setail";
  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Order"),
      ),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is UserErrorState) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is UserLoggedInState) {
                UserModel user = state.userModel;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User Details",
                      style: TextStyles.body2
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const GapWidget(),
                    Text(
                      "${user.fullName}",
                      style: TextStyles.heading3,
                    ),
                    Text(
                      "Email: ${user.email!}",
                      style: TextStyles.body2,
                    ),
                    Text(
                      "Phone: ${user.phoneNumber!}",
                      style: TextStyles.body2,
                    ),
                    Text(
                      "Address: ${user.address!}, ${user.city!}, ${user.state!}",
                      style: TextStyles.body2,
                    ),
                    LinkButton(
                      text: "Edit profile",
                      onPressed: () {
                        Navigator.pushNamed(
                            context, EditProfileScreen.routeName);
                      },
                    )
                  ],
                );
              }
              return const Center(
                child: Text("An error occured"),
              );
            },
          ),
          const GapWidget(
            size: 10,
          ),
          Text(
            "Items",
            style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
          ),
          const GapWidget(),
          BlocBuilder<CartCubt, CartState>(
            builder: (context, state) {
              if (state is CartLoadingState && state.items.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CartErrorState && state.items.isEmpty) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is CartLoadedState) {
                return CartListView(
                  items: state.items,
                  noScroll: true,
                  shrinkWrap: true,
                );
              }
              return const Center(
                child: SizedBox(),
              );
            },
          ),
          const GapWidget(
            size: 10,
          ),
          Text(
            "Payments",
            style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
          ),
          const GapWidget(),
          Consumer<OrderDetailProvider>(builder: (context, provider, child) {
            return Column(
              children: [
                RadioListTile(
                  value: "Pay-On-Delivery",
                  groupValue: provider.paymentMethod,
                  onChanged: (value) {
                    provider.changePaymentMethod(value);
                  },
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Pay On Delivery"),
                ),
                RadioListTile(
                  value: "Pay-Now",
                  groupValue: provider.paymentMethod,
                  onChanged: (value) {
                    provider.changePaymentMethod(value);
                  },
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Pay Now"),
                ),
              ],
            );
          }),
          const GapWidget(),
          PrimaryButton(
            text: "Place Order",
            onPressed: () async {
              OrderModel? newOrder = await BlocProvider.of<OrderCubit>(context)
                  .createOrder(
                      items: BlocProvider.of<CartCubt>(context).state.items,
                      paymentMethod: Provider.of<OrderDetailProvider>(context,
                              listen: false)
                          .paymentMethod
                          .toString());

              if (newOrder == null) {
                return;
              }
              if (newOrder.status == 'payment-pending') {
               
                RazorPayServices.checkOutOrder(newOrder,
                    onSuccess: (response) async {
                       newOrder.status='order-placed';  
                  bool sucess = await BlocProvider.of<OrderCubit>(context)
                      .updateOrder(newOrder,
                          paymentId: response.paymentId,
                          signature: response.signature);
                  if (!sucess) {
                    const SnackBar(content: Text("Cant Update order"));
                    return;
                  }
                  Navigator.popUntil(
                    context,
                    (route) => route.isFirst,
                  );
                  Navigator.pushNamed(context, OrderPlacedScreen.routeName);
                }, onFailure: (response) {
                  log("Payment Failed");
                });
              }

              if (newOrder.status == 'order-placed') {
                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                );
                Navigator.pushNamed(context, OrderPlacedScreen.routeName);
              }
            },
          )
        ],
      )),
    );
  }
}
