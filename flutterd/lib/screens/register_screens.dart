import 'package:flutter/material.dart';
import 'package:flutterd/screens/login_screens.dart';
import 'package:flutterd/state/user_state.dart';
import 'package:provider/provider.dart';

class RegisterScreens extends StatefulWidget {
  static const routeName = '/register-screens';
  @override
  _RegisterScreensState createState() => _RegisterScreensState();
}

class _RegisterScreensState extends State<RegisterScreens> {
  final _form = GlobalKey<FormState>();

  String _username = '';
  String _password = '';
  String _confpassword = '';

  _registerNow() async {
    var isvalid = _form.currentState.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState.save();
    bool isregis = await Provider.of<UserState>(
      context,
      listen: false,
    ).registernow(_username, _password);
    if (isregis) {
      Navigator.of(context).pushReplacementNamed(LoginScrrens.routeName);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Something is wrong.Try Again"),
              actions: [
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Now"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Enter Your Username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Username",
                  ),
                  onSaved: (v) {
                    _username = v;
                  },
                ),
                TextFormField(
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Enter Your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                  onChanged: (v) {
                    setState(() {
                      _confpassword = v;
                    });
                  },
                  onSaved: (v) {
                    _password = v;
                  },
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                ),
                TextFormField(
                  validator: (v) {
                    if (_confpassword != v) {
                      return 'Confirm password';
                    }
                    if (v.isEmpty) {
                      return 'Confirm Your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                  ),
                  onSaved: (v) {
                    _password = v;
                  },
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        _registerNow();
                      },
                      child: Text("Register"),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScrrens.routeName);
                      },
                      child: Text(
                        "Login New",
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
