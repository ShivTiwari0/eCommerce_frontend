import 'package:ecom/core/ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';


class OrderPlacedScreen extends StatefulWidget {
  const OrderPlacedScreen({super.key});
  static const routeName = "order_placed";
  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Placed "),),
      body:  Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(CupertinoIcons.cube_box_fill,size: 100,color: AppColors.textLight,), Text("Order Placed", style:  TextStyles.heading3.copyWith(color: AppColors.textLight),)],
        ),
      ),
    );
  }
} 
