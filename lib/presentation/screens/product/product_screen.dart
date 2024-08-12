import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/core/ui.dart';
import 'package:ecom/data/models/product_model.dart';
import 'package:ecom/logic/cubits/cart_cubit.dart/cart_cubit.dart';
import 'package:ecom/logic/cubits/cart_cubit.dart/cart_state.dart';
import 'package:ecom/logic/services/formater.dart';
import 'package:ecom/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetailScreen({super.key, required this.productModel});

  static const routeName = "Product_Screen";

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productModel.title ?? "No title found"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width,
              child: CarouselSlider.builder(
                itemCount: widget.productModel.images?.length ?? 0,
                slideBuilder: (index) {
                  String url = widget.productModel.images![index];

                  return CachedNetworkImage(
                    imageUrl: url,
                  );
                },
              ),
            ),

         

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.productModel.title}",
                    style: TextStyles.heading3,
                  ),
                  Text(
                    "₹${Formatter.formatPrice(widget.productModel.prices ?? 0)}",
                    style: TextStyles.heading2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<CartCubt, CartState>(builder: (context, state) {
                    bool isInCart = BlocProvider.of<CartCubt>(context)
                        .cartContains(widget.productModel);

                    return PrimaryButton(
                        onPressed: () {
                          if (isInCart) {
                            return;
                          }

                          BlocProvider.of<CartCubt>(context)
                              .addToCart(widget.productModel, 1);
                        },
                        color:
                            (isInCart) ? AppColors.textLight : AppColors.accent,
                        text: (isInCart)
                            ? "Product added to cart"
                            : "Add to Cart");
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Description",
                    style:
                        TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.productModel.description}",
                    style: TextStyles.body1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
