import 'package:ecom/logic/cubits/cart_cubit.dart/cart_cubit.dart';
import 'package:ecom/logic/cubits/cart_cubit.dart/cart_state.dart';
import 'package:ecom/logic/cubits/user_cubits/useer_state.dart';
import 'package:ecom/logic/cubits/user_cubits/user_cubit.dart';
import 'package:ecom/presentation/screens/cart/cart_screen.dart';
import 'package:ecom/presentation/screens/home/category_screen.dart';
import 'package:ecom/presentation/screens/home/profile_scree.dart';
import 'package:ecom/presentation/screens/home/user_feed_screen.dart';
import 'package:ecom/presentation/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "home";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> screens = const [ 
    UserFeedScreen(),
    CategoryScreen(),
    ProfileScree()
  ];
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit,UserState>(
      listener: (BuildContext context, state) {  
        if(state is UserLogoutState){
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Ecommerce App"), actions: [
          IconButton(
            icon: BlocBuilder<CartCubt, CartState>(builder: (context, state) {
              return Badge(
                label: Text(state.items.length.toString()),
                isLabelVisible: (state is CartLoadingState) ? false : true,
                child: const Icon(CupertinoIcons.cart),
              );
            }),
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
          ),
        ]),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: "Categories",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              )
            ]),
      ),
    );
  }
}
