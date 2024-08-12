import 'package:ecom/core/extension.dart';
import 'package:ecom/core/ui.dart';
import 'package:ecom/presentation/screens/auth/login_screen.dart';
import 'package:ecom/presentation/screens/auth/providers/signup_provider.dart';
import 'package:ecom/presentation/widgets/link_button.dart';
import 'package:ecom/presentation/widgets/primary_button.dart';
import 'package:ecom/presentation/widgets/primaryt_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  static const String routeName = "signup";
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);
    return Scaffold(
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
              "Create a new Account",
              style: TextStyles.heading2,
            ),
            (provider.error != "")
                ? Text(
                    provider.error,
                    style: const TextStyle(color: Colors.red),
                  )
                : const SizedBox(),
            SizedBox(
              height: context.height() * 0.02 ,
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
              height: context.height() * 0.01
            ),
            PrimarytTextfield(
              labelText: "Passwords",
              controller: provider.passwordController,
              obsecureText: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Password is required";
                }
                return null;
              },
            ),   SizedBox(
              height: context.height() * 0.01
            ),
            PrimarytTextfield(
              labelText: "Confirm Password",
              controller: provider.mPasswordController,
              obsecureText: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Confirm your password";
                }
                if (value.trim() != provider.passwordController.text.trim()) {
                  return "Password Do not match";
                }
                return null;
              },
            ),
            SizedBox(
              height: context.height() * 0.02,
            ),
            PrimaryButton(
              onPressed: provider.signUp,
              text: (provider.isLoading ? "Loading..." : "Create Account") ,
            ),
            SizedBox(
              height: context.height() * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Alraedy have an account?"),
                LinkButton(
                  onPressed: () {Navigator.pushNamed(context, LoginSCreen.routeName);},
                  text: " Sign In",
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
