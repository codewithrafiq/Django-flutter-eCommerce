import 'package:flutter/material.dart';
import 'package:flutterd/screens/home_Screens.dart';
import 'package:flutterd/screens/register_screens.dart';
import 'package:flutterd/state/user_state.dart';
import 'package:provider/provider.dart';

class LoginScrrens extends StatefulWidget {
  static const routeName = '/login-screens';

  @override
  _LoginScrrensState createState() => _LoginScrrensState();
}

class _LoginScrrensState extends State<LoginScrrens> {
  String _username = '';
  String _password = '';
  final _form = GlobalKey<FormState>();

  void _loginNew() async {
    var isvalid = _form.currentState.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState.save();
    bool istoken = await Provider.of<UserState>(
      context,
      listen: false,
    ).loginNow(_username, _password);
    if (istoken) {
      Navigator.of(context).pushReplacementNamed(HomeScreens.routeName);
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
        title: Text("Login Now"),
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
                  onSaved: (v) {
                    _password = v;
                  },
                  obscureText: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        _loginNew();
                      },
                      child: Text("Login"),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(RegisterScreens.routeName);
                      },
                      child: Text(
                        "Register New",
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
