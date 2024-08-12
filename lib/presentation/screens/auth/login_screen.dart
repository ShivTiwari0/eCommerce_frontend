import 'package:ecom/core/extension.dart';
import 'package:ecom/core/ui.dart';
import 'package:ecom/logic/cubits/user_cubits/useer_state.dart';
import 'package:ecom/logic/cubits/user_cubits/user_cubit.dart';
import 'package:ecom/presentation/screens/auth/providers/login_providers.dart';
import 'package:ecom/presentation/screens/auth/signup_screen.dart';

import 'package:ecom/presentation/splash/splash_screen.dart';
import 'package:ecom/presentation/widgets/link_button.dart';
import 'package:ecom/presentation/widgets/primary_button.dart';
import 'package:ecom/presentation/widgets/primaryt_textfield.dart';
import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

class LoginSCreen extends StatelessWidget {
  const LoginSCreen({super.key});
  static const String routeName = "login";  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) { 
        if (state is UserLoggedInState) {
         
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Ecommerce App",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: SafeArea(
            child: Form(
          key: provider.formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                "Login",
                style: TextStyles.heading2,
              ),
              (provider.error != "")
                  ? Text(
                      provider.error,
                      style: const TextStyle(color: Colors.red),
                    )
                  : const SizedBox(),
              SizedBox(
                height: context.height() * 0.02,
              ),
              PrimarytTextfield(
                labelText: "Email Address",
                controller: provider.emailController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Email is required";
                  }
                  if (!EmailValidator.validate(value.trim())) {
                    return "Invalid Email";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: context.height() * 0.02,
              ),
              PrimarytTextfield(
                labelText: "Password",
                controller: provider.passwordController,
                obsecureText: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Password is required";
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LinkButton(
                    text: "Forgot Password?",
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(
                height: context.height() * 0.02,
              ),
              PrimaryButton(
                onPressed: provider.login,
                text: (provider.isLoading ? "Loading..." : "LogIn"),
              ),
              SizedBox(
                height: context.height() * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Dont have an account?"),
                  LinkButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                    text: " Sign Up",
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
