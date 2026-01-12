import 'package:flutter/material.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/common/widgets/input/app_text_field.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/domain/usecases/auth/signin.dart';
import 'package:spotify/service.locator.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> _signInButtonPressed(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    var result = await sl<SignInUseCase>().call(
        params: SigninUserReq(
            email: _emailController.text, password: _passwordController.text));
    if (!mounted) return;
    setState(() => isLoading = false);
    result.fold((failure) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(failure)));
    }, (success) {
      Navigator.pushNamedAndRemoveUntil(context, '/root', (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        showIcon: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                _signInText(context),
                const SizedBox(height: 30),
                _emailField(),
                const SizedBox(height: 20),
                _passwordField(),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Recovery Password",
                        style: TextStyle(
                            color: context.isDarkMode
                                ? Colors.grey
                                : AppColors.darkGrey),
                      )),
                ),
                const SizedBox(height: 10),
                BasicAppButton(
                    isLoading: isLoading,
                    onPressed: () => _signInButtonPressed(context),
                    title: "Sign In"),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Divider(thickness: 0.2, color: AppColors.grey)),
                    SizedBox(
                      width: 50,
                      child: Text(
                        "Or",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.grey),
                      ),
                    ),
                    Expanded(
                        child: Divider(thickness: 0.2, color: AppColors.grey))
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        size: 50,
                        Icons.facebook,

                        // color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        size: 50,
                        Icons.apple,

                        // color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member?"),
                    TextButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/signup');
                        },
                        child: const Text(
                          "Register now",
                          style: TextStyle(color: AppColors.primary),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInText(BuildContext context) {
    return Text(
      "Sign In",
      style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: context.isDarkMode ? Colors.white : Colors.black),
    );
  }

  Widget _emailField() {
    return AppTextField(
      titleLabel: "Enter Email",
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
    );
  }

  Widget _passwordField() {
    return AppTextField(
      titleLabel: "Password",
      obscureText: true,
      controller: _passwordController,
    );
  }
}
