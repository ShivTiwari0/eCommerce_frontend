import 'dart:async';

import 'package:ecom/logic/cubits/user_cubits/useer_state.dart';
import 'package:ecom/logic/cubits/user_cubits/user_cubit.dart';
import 'package:ecom/presentation/screens/auth/login_screen.dart';
import 'package:ecom/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = "splash";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void gotoNextScreen() {
    UserState userState = BlocProvider.of<UserCubit>(context).state;
    if (userState is UserLoggedInState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else if (userState is UserLogoutState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, LoginSCreen.routeName);
    } else if (userState is UserErrorState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, LoginSCreen.routeName);
    }
  }

  @override
  void initState() {
    Timer(const Duration(milliseconds: 100), () => gotoNextScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit,UserState>(
      listener: (context, state) { gotoNextScreen(); },
      child: const Scaffold( 
          body: Center(
        child: CircularProgressIndicator(),
      )),
    );
  }
}
