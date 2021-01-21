import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:youarefreetotalk/pages/register/register.dart';
import 'package:youarefreetotalk/widgets/centerForm.dart';

class LoginPage extends StatelessWidget {
  static const String id = 'login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('holy'),
            CenterFormIn(),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                      text: ' Sign Up',
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () => Navigator.of(context)
                            .push(registerFormPageAnimation()),
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
