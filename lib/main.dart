import 'dart:developer';

import 'package:ecom/core/routes.dart';
import 'package:ecom/core/ui.dart';
import 'package:ecom/logic/cubits/cart_cubit.dart/cart_cubit.dart';

import 'package:ecom/logic/cubits/category_cubit/category_cubit.dart';
import 'package:ecom/logic/cubits/order_cubit/order_cubit.dart';
import 'package:ecom/logic/cubits/product_cubit/product_cubit.dart';
import 'package:ecom/logic/cubits/user_cubits/user_cubit.dart';

import 'package:ecom/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const EcomApp());
}

class EcomApp extends StatelessWidget {
  const EcomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(),
        ),
        BlocProvider(
          create: (context) => ProductCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubt(BlocProvider.of<UserCubit>(context)),
        ),
        BlocProvider(
          create: (context) => OrderCubit(BlocProvider.of<UserCubit>(context),
              (BlocProvider.of<CartCubt>(context))),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenrateRoute,
        theme: Themes.defaultTheme,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log("Created: $bloc");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log("Change in $bloc: $change");
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log("Change in $bloc: $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    log("Closed: $bloc");
    super.onClose(bloc);
  }
}
