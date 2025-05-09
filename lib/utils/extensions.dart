import 'package:flutter/material.dart';

extension PaddingHeight on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}


//Thoughts: I could have opted for GoRouter or other routing packages but for this project 
//I think the default Navigator is good enough
extension NavContext on BuildContext {
  void push(Widget page) {
    Navigator.push(this, MaterialPageRoute(builder: (_) => page));
  }

  void pushReplacement(Widget page) {
    Navigator.pushReplacement(this, MaterialPageRoute(builder: (_) => page));
  }

  void pushAndRemoveUntil(Widget page) {
    Navigator.pushAndRemoveUntil(
        this, MaterialPageRoute(builder: (_) => page), (route) => false);
  }
}
