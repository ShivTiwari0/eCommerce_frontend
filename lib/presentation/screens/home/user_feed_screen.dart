import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/core/extension.dart';
import 'package:ecom/core/ui.dart';
import 'package:ecom/logic/cubits/product_cubit/product_cubit.dart';
import 'package:ecom/logic/cubits/product_cubit/product_state.dart';
import 'package:ecom/logic/services/formater.dart';
import 'package:ecom/presentation/screens/product/product_screen.dart';
import 'package:ecom/presentation/widgets/product_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      if (state is ProductLoadingState && state.products.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is ProductErrorState && state.products.isEmpty) {
        return Center(
          child: Text(state.message.toString()),
        );
      }
      return ProductListview(products: state.products);
    });
  }
}
