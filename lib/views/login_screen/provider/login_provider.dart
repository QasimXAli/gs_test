import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gs_test/services/auth_service.dart';
import 'package:gs_test/utils/toast_message.dart';

class LoginProvider extends ChangeNotifier {
  final AuthService _authService;

  LoginProvider(this._authService);

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  bool loadingState = false;
  bool obscurePassword = true;

  void toggleLoading() {
    loadingState = !loadingState;
    notifyListeners();
  }

  void toggleObscure() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    try {
      toggleLoading();
      await _authService.login(emailController.text, passwordController.text);
    } on FirebaseAuthException catch (e) {
      ToastMessage.show(msg: e.message ?? "Authentication failed");
    } catch (e) {
      ToastMessage.show(msg: e.toString());
    } finally {
      toggleLoading();
    }
  }
}
