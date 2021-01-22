import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:youarefreetotalk/pages/home/home.dart';
import 'package:youarefreetotalk/pages/register/register.dart';
import 'package:youarefreetotalk/services/database.dart';
import 'package:youarefreetotalk/widgets/form/login.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DatabaseServices _db = DatabaseServices();
  @override
  void initState() {
    super.initState();
    _db.getUser().then((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, HomePage.id);
      }
    });
  }

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
