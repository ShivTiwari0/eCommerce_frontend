import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/data/models/cart_item_model.dart';
import 'package:ecom/logic/cubits/cart_cubit.dart/cart_cubit.dart';
import 'package:ecom/logic/services/formater.dart';
import 'package:ecom/presentation/widgets/link_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';

class CartListView extends StatelessWidget {
  final  List<CartItemModel> items;
  final bool shrinkWrap;
  final bool noScroll;
  const CartListView({super.key, required this.items, this.shrinkWrap =false,this.noScroll=false});

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      shrinkWrap: shrinkWrap,
      physics:(noScroll)? const NeverScrollableScrollPhysics():null,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    leading:
                        SizedBox(width: 50 ,child: CachedNetworkImage(imageUrl: item.product!.images![0])),
                    title: Text("${item.product?.title}" , ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${item.product?.prices} x ${item.quantity} = ${Formatter.formatPrice(item.product!.prices! * item.quantity!)}"),
                        LinkButton(
                          text: "Remove",
                          onPressed: () {
                            BlocProvider.of<CartCubt>(context)
                                .removeFromCart(item.product!); 
                          },
                          color: Colors.redAccent,
                        )
                      ],
                    ),
                    trailing: InputQty(
                      onQtyChanged: (value) {log("im updating");
                        int intValue = value is double ? value.toInt() : value;
                        if (value == item.quantity) return;
                        BlocProvider.of<CartCubt>(context)
                            .addToCart(item.product!, intValue);
                      },
                      maxVal: 99,
                      initVal: item.quantity!,
                      minVal: 1,
                    ),
                  );
                },
              );
  }
} 