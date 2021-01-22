import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youarefreetotalk/pages/home/home.dart';

class CenterFormIn extends StatefulWidget {
  @override
  _CenterFormInState createState() => _CenterFormInState();
}

class _CenterFormInState extends State<CenterFormIn> {
  bool _isloading = false;
  String _username, _password;
  final validCharacters = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: TextFormField(
              onSaved: (txt) => _username = txt,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                } else if (!validCharacters.hasMatch(value)) {
                  return 'username can not contain space or special character';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                labelText: 'Username',
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              onSaved: (txt) => _password = txt,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                } else if (value.length < 8) {
                  return 'password must be 8 or bigger';
                }
                return null;
              },
              obscureText: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                labelText: 'password',
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.redAccent,
                  ),
                ),
                // hintText: 'Shoe Dog',
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: 25,
              ),
              child: FlatButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _isloading = true;
                    });
                    _formKey.currentState.save();
                    //! trying to sign in user lol
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                              email: _username + '@yaft.com',
                              password: _password);
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            'Sign In Successfully',
                            textAlign: TextAlign.center,
                          ),
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      setState(() {
                        _isloading = false;
                      });
                      Navigator.pushReplacementNamed(context, HomePage.id);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              '😢  User not found!',
                              textAlign: TextAlign.center,
                            ),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        setState(() {
                          _isloading = false;
                        });
                      } else if (e.code == 'wrong-password') {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Wrong password :)',
                              textAlign: TextAlign.center,
                            ),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        setState(() {
                          _isloading = false;
                        });
                      }
                    }
                  }
                },
                child: Text('Go in'),
              ),
            ),
          ),
          _isloading
              ? CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
