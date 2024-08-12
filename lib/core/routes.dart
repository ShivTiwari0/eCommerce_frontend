import 'package:ecom/data/models/category_model.dart';
import 'package:ecom/data/models/product_model.dart';

import 'package:ecom/logic/cubits/category_product_cubit.dart/category_product_cubit.dart';
import 'package:ecom/presentation/screens/auth/login_screen.dart';
import 'package:ecom/presentation/screens/auth/providers/login_providers.dart';
import 'package:ecom/presentation/screens/auth/providers/signup_provider.dart';
import 'package:ecom/presentation/screens/auth/signup_screen.dart';
import 'package:ecom/presentation/screens/cart/cart_screen.dart';
import 'package:ecom/presentation/screens/home/home_screen.dart';
import 'package:ecom/presentation/screens/order/my_order_screen.dart';
import 'package:ecom/presentation/screens/order/order_detail_screen.dart';
import 'package:ecom/presentation/screens/order/order_placed_screen.dart';
import 'package:ecom/presentation/screens/order/providers/order_detail_provider.dart';
import 'package:ecom/presentation/screens/product/category_product_screen.dart';
import 'package:ecom/presentation/screens/product/product_screen.dart';
import 'package:ecom/presentation/screens/user/edit_profile.dart';
import 'package:ecom/presentation/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Routes {
  static Route? onGenrateRoute(RouteSettings setting) {
    switch (setting.name) {
      case LoginSCreen.routeName:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => LoginProvider(context),
                child: const LoginSCreen()));

      case SignUpScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => SignUpProvider(context),
                child: const SignUpScreen()));

      case HomeScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const HomeScreen());

      case SplashScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const SplashScreen());

      case ProductDetailScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ProductDetailScreen(
            productModel: setting.arguments as ProductModel,
          ),
        );

      case CartScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const CartScreen(),
        );
      case CategoryProductScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                create: (context) {
                  return CategoryProductCubit(
                      setting.arguments as CategoryModel);
                },
                child: const CategoryProductScreen()));

      case EditProfileScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const EditProfileScreen(),
        );
      case OrderDetailScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => OrderDetailProvider(),
              child: const OrderDetailScreen()),
        );
      case OrderPlacedScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const OrderPlacedScreen(),
        );
         case MyOrderScreen.routename:
        return CupertinoPageRoute(
          builder: (context) => const MyOrderScreen(),
        );
      default:
        return null;
    }
  }
}
