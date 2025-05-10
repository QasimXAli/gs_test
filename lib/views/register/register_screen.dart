import 'package:flutter/material.dart';
import 'package:gs_test/utils/extensions.dart';
import 'package:gs_test/utils/theme_manager.dart';
import 'package:gs_test/utils/validators.dart';
import 'package:gs_test/views/common/custom_form_field.dart';
import 'package:gs_test/views/login_screen/login_screen.dart';
import 'package:gs_test/views/register/provider/register_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegisterProvider>(context, listen: false);
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
                'Sign up with email',
                style: ThemeManager.textTheme.titleLarge,
              ),
              30.ph,
              GestureDetector(
                onTap: () => provider.pickImage(),
                child: Consumer<RegisterProvider>(
                  builder: (_, provider, __) => Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: ThemeManager.avatarBGColor,
                        backgroundImage: provider.selectedImage != null
                            ? FileImage(provider.selectedImage!)
                            : null,
                        child: provider.selectedImage == null
                            ? const Icon(
                                Icons.person,
                                size: 30,
                                color: ThemeManager.whiteColor,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ThemeManager.whiteColor,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(6),
                          child: const Icon(
                            Icons.edit,
                            size: 16,
                            color: ThemeManager.blackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              20.ph,
              CustomFormField(
                  validator: (value) => requiredValidator(value),
                  controller: provider.nameController,
                  hintText: 'Name',
                  obscureText: false),
              20.ph,
              CustomFormField(
                  validator: (value) => emailValidator(value),
                  controller: provider.emailController,
                  hintText: 'Email',
                  obscureText: false),
              20.ph,
              Consumer<RegisterProvider>(
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
              30.ph,
              Consumer<RegisterProvider>(
                builder: (_, provider, __) => SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: ThemeManager.elevatedButtonBGColor),
                    onPressed: provider.loadingState
                        ? null
                        : () => provider.register(context),
                    child: provider.loadingState
                        ? const CircularProgressIndicator(color: Colors.black)
                        : Text('Sign Up',
                            style: ThemeManager.textTheme.titleMedium),
                  ),
                ),
              ),
              40.ph,
              Text(
                'Already have an account?',
                style: ThemeManager.textTheme.titleMedium,
              ),
              10.ph,
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Text(
                  'Login',
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
