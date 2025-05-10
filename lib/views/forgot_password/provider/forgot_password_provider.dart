import 'package:flutter/material.dart';
import 'package:gs_test/services/auth_service.dart';
import 'package:gs_test/utils/extensions.dart';
import 'package:gs_test/utils/toast_message.dart';
import 'package:gs_test/views/login_screen/login_screen.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final AuthService _authService;
  ForgotPasswordProvider(this._authService);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  bool loadingState = false;

  void toggleLoading() {
    loadingState = !loadingState;
    notifyListeners();
  }

  Future<void> sendResetEmail(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    try {
      toggleLoading();
      await _authService.sendPasswordResetEmail(
        emailController.text.trim(),
      );
      if (context.mounted) {
        emailController.clear();
        context.pushAndRemoveUntil(LoginScreen());
      }
      ToastMessage.show(msg: 'Reset email sent');
    } catch (e) {
      ToastMessage.show(msg: e.toString());
    } finally {
      toggleLoading();
    }
  }
}
