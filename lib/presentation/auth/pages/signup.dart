import 'package:flutter/material.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/common/widgets/input/app_text_field.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/domain/usecases/auth/signup.dart';
import 'package:spotify/service.locator.dart';

class SignupPage extends StatefulWidget {
  SignupPage({
    super.key,
  });

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> _signupButtonPressed(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    var result = await sl<SignUpUseCase>().call(
        params: CreateUserReq(
            fullName: _fullNameController.text,
            email: _emailController.text,
            password: _passwordController.text));

    if (!mounted) return;
    setState(() => isLoading = false);
    result.fold(
        (l) => {
              //error
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(l)))
            },
        (r) => {
              //success
              Navigator.pushNamedAndRemoveUntil(context, '/root', (_) => false)
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
                _registerText(context),
                const SizedBox(height: 40),
                _fullNameField(),
                const SizedBox(height: 20),
                _emailField(),
                const SizedBox(height: 20),
                _passwordField(),
                const SizedBox(height: 20),
                BasicAppButton(
                    isLoading: isLoading,
                    onPressed: () => _signupButtonPressed(context),
                    title: "Create Account"),
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
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/signin');
                        },
                        child: const Text(
                          "Sign In",
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

  Widget _registerText(BuildContext context) {
    return Text(
      "Register",
      style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: context.isDarkMode ? Colors.white : Colors.black),
    );
  }

  Widget _fullNameField() {
    return AppTextField(
        titleLabel: "Full Name", controller: _fullNameController);
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
