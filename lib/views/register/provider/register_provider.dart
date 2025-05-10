import 'dart:io' show File;

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter/material.dart';
import 'package:gs_test/services/auth_service.dart';
import 'package:gs_test/utils/extensions.dart';
import 'package:gs_test/utils/toast_message.dart';
import 'package:gs_test/views/home/home_screen.dart';
import 'package:image_picker/image_picker.dart';

class RegisterProvider extends ChangeNotifier {
  final AuthService _authService;
  RegisterProvider(this._authService);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool loadingState = false;
  bool obscurePassword = true;
  File? selectedImage;
  void toggleLoading() {
    loadingState = !loadingState;
    notifyListeners();
  }

  void toggleObscure() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedImage = File(picked.path);
      notifyListeners();
    }
  }

  Future<void> register(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    if (selectedImage == null) {
      ToastMessage.show(msg: 'Please select a profile image');
      return;
    }

    try {
      toggleLoading();
      await _authService.register(
        email: emailController.text.trim(),
        name: nameController.text.trim(),
        password: passwordController.text.trim(),
        imageFile: selectedImage!,
      );
      ToastMessage.show(msg: 'Registration successful');
      if (context.mounted) {
        reset();
        //Thoughts:  Clasic navigation stack issue because the wrapper is on login screen i have to pop here inorder to navigate to home.
        context.pop();
      }
    } on FirebaseAuthException catch (e) {
      ToastMessage.show(msg: e.message ?? "Authentication failed");
    } catch (e) {
      ToastMessage.show(msg: e.toString());
    } finally {
      toggleLoading();
    }
  }

  void reset() {
    //Thoughts: As the provider is registered as global instead of being tied to the screen it stays in the widget tree
    //I have to manually clear the values of controllers.
    //Its been a while since i used provider.
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    selectedImage = null;
  }
}
