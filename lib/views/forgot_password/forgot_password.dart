import 'package:flutter/material.dart';
import 'package:gs_test/utils/extensions.dart';
import 'package:gs_test/utils/theme_manager.dart';
import 'package:gs_test/utils/validators.dart';
import 'package:gs_test/views/common/custom_form_field.dart';
import 'package:gs_test/views/forgot_password/provider/forgot_password_provider.dart';
import 'package:provider/provider.dart';

//Thoughts: It wasnt in the document provided but i still added this screen.  

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ForgotPasswordProvider>(context, listen: false);

    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Form(
          key: provider.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Forgot Password',
                  style: ThemeManager.textTheme.titleLarge,
                ),
                30.ph,
                CustomFormField(
                  hintText: 'Email',
                  controller: provider.emailController,
                  validator: (value) => emailValidator(value),
                  obscureText: false,
                ),
                50.ph,
                Consumer<ForgotPasswordProvider>(
                  builder: (_, provider, __) => SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: ThemeManager.elevatedButtonBGColor,
                      ),
                      onPressed: provider.loadingState
                          ? null
                          : () => provider.sendResetEmail(context),
                      child: provider.loadingState
                          ? const CircularProgressIndicator(color: Colors.black)
                          : Text('Send',
                              style: ThemeManager.textTheme.titleMedium),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
