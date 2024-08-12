// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:ecom/logic/cubits/user_cubits/useer_state.dart';
import 'package:ecom/logic/cubits/user_cubits/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginProvider extends ChangeNotifier {
  final BuildContext context;
  LoginProvider(this.context) {
    _listentoUserCubit();
  }

  bool isLoading = false;
  String error = '';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  StreamSubscription? _userSubscription;
  void _listentoUserCubit() {
    log("ListentoUserCubit.........");
    _userSubscription =
        BlocProvider.of<UserCubit>(context).stream.listen((userState) {
      if (userState is UserLoadingState) {
        isLoading = true;
        error = "";
        notifyListeners();
      } else if (userState is UserErrorState) {
        isLoading = false;
        error = userState.message.toString();
        notifyListeners();
      } else {
        isLoading = false;
        error = '';
        notifyListeners();
      }
    });
  }

  void login() async {
    if (!formKey.currentState!.validate()) return;
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    BlocProvider.of<UserCubit>(context)
        .signIn(email: email, password: password);
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
