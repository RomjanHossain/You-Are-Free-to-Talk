import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youarefreetotalk/services/database.dart';

class CenterFormReg extends StatefulWidget {
  @override
  _CenterFormRegState createState() => _CenterFormRegState();
}

class _CenterFormRegState extends State<CenterFormReg> {
  bool _isloading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final validCharacters = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _pass = TextEditingController();

  final TextEditingController _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String _username, _password;
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
              controller: _pass,
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              controller: _confirmPass,
              onSaved: (txt) => _password = txt,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                } else if (value != _pass.text) {
                  return 'password didnt match';
                }

                return null;
              },
              obscureText: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                labelText: 'conform password',
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

          //* register button
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
                  //? onpressed function here
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _isloading = true;
                    });
                    _formKey.currentState.save();
                    try {
                      UserCredential userCredential =
                          await _auth.createUserWithEmailAndPassword(
                              email: _username + '@yaft.com',
                              password: _password);
                      // set the user data up
                      await Provider.of<DatabaseServices>(context)
                          .createUserData(userCredential.user);
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            'User Created Successfully',
                            textAlign: TextAlign.center,
                          ),
                          duration: Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      setState(() {
                        _isloading = false;
                      });
                      Future.delayed(Duration(seconds: 1, milliseconds: 200));
                      Navigator.pop(context);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        //? warning: week password
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Weak Password detected',
                              textAlign: TextAlign.center,
                            ),
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        setState(() {
                          _isloading = false;
                        });
                      } else if (e.code == 'email-already-in-use') {
                        //? warning: username already exists
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Color(0xFFfe001c),
                            content: Text(
                              'Username Taken',
                              textAlign: TextAlign.center,
                            ),
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        setState(() {
                          _isloading = false;
                        });
                      }
                    } catch (e) {
                      print('form firebaseAtuth\n $e ');
                    }
                  }
                },
                child: Text('Register'),
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
