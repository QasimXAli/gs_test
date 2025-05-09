import 'package:flutter/material.dart';
import 'package:gs_test/utils/extensions.dart';
import 'package:gs_test/utils/theme_manager.dart';
import 'package:gs_test/utils/validators.dart';
import 'package:gs_test/views/common/custom_form_field.dart';
import 'package:gs_test/views/login_screen/provider/login_provider.dart';
import 'package:gs_test/views/register/register_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
        body: Align(
      alignment: Alignment.center,
      child: Form(
        key: provider.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Login with email',
                style: ThemeManager.textTheme.titleLarge,
              ),
              30.ph,
              CustomFormField(
                  validator: (value) => emailValidator(value),
                  controller: provider.emailController,
                  hintText: 'Enter your email',
                  obscureText: false),
              20.ph,
              Consumer<LoginProvider>(
                builder: (_, provider, __) => CustomFormField(
                  hintText: 'Password',
                  validator: requiredValidator,
                  suffixIcon: IconButton(
                    icon: Icon(
                      provider.obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () => provider.toggleObscure(),
                  ),
                  controller: provider.passwordController,
                  obscureText: provider.obscurePassword,
                ),
              ),
              30.ph,
              Text(
                'Forget Password ?',
                style: ThemeManager.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              30.ph,
              Consumer<LoginProvider>(
                builder: (_, provider, __) => SizedBox(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeManager.elevatedButtonBGColor),
                    onPressed:
                        provider.loadingState ? null : () => provider.login(),
                    child: provider.loadingState
                        ? const CircularProgressIndicator(color: Colors.black)
                        : Text('Login',
                            style: ThemeManager.textTheme.titleMedium),
                  ),
                ),
              ),
              40.ph,
              Text(
                'Don\'t have an account',
                style: ThemeManager.textTheme.titleMedium,
              ),
              10.ph,
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                child: Text(
                  'Sign up',
                  style: ThemeManager.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
