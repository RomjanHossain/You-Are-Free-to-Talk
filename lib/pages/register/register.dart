import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:youarefreetotalk/widgets/form/reg.dart';

//? animation for upload fomr
Route registerFormPageAnimation() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => RegisterPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

class RegisterPage extends StatelessWidget {
  static const String id = 'register';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf4f4f4),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('dlkfsd'),
            CenterFormReg(),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "You have an account? ",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: ' Sign In',
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () => Navigator.pop(context),
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
