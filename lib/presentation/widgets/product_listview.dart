import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/core/extension.dart';
import 'package:ecom/core/ui.dart';
import 'package:ecom/data/models/product_model.dart';
import 'package:ecom/logic/services/formater.dart';
import 'package:flutter/cupertino.dart';


import '../screens/product/product_screen.dart';

class ProductListview extends StatelessWidget {
  const ProductListview({super.key, required this.products});
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return  ListView.builder( 
        itemCount:products.length,
        itemBuilder: (context, index) {
          final product = products[index];
         
          return CupertinoButton(
            onPressed: () {Navigator.pushNamed(context, ProductDetailScreen.routeName,arguments: product); },
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                CachedNetworkImage(
                    width: context.width() * 0.3,
                    imageUrl:
                   product.images?[0]??""),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, 
                    children: [
                      Text( 
                        "${product.title}",
                        style:  
                            TextStyles.body1.copyWith(fontWeight: FontWeight.bold),maxLines: 1,overflow:TextOverflow.ellipsis
                      ),
                      SizedBox(
                        height: context.height() * 0.004,
                      ),
                      Text(
                        product.description??"No Discription",maxLines: 2,overflow:TextOverflow.ellipsis,
                        style: TextStyles.body2.copyWith( 
                            fontWeight: FontWeight.w400, 
                            color: AppColors.textLight),
                      ),
                      SizedBox(
                        height: context.height() * 0.02,  
                      ),
                      Text("₹${Formatter.formatPrice(product.prices??00)}",
                          style: TextStyles.body1
                              .copyWith(fontWeight: FontWeight.w500))
                    ],
                  ),  
                )
              ],
            ),
          );
        },
      );
  }
}