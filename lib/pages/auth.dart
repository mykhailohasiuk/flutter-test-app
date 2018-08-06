import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';

enum AuthMode { SignUp, Login }

class AuthPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  final Map<String, dynamic> _loginData = {
    'email': '',
    'password': '',
    'isTermsAccepted': true
  };

  final TextEditingController _passwordTextController = TextEditingController();

  AuthMode _authMode = AuthMode.Login;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWith = deviceWidth > 768.0 ? 500.0 : deviceWidth * 0.95;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('${_authMode == AuthMode.Login ? 'Log In' : 'SingUp'}'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(image: _buildBackgroundImage()),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWith,
              child: Form(
                key: _loginKey,
                child: Column(
                  children: <Widget>[
                    _buildEmailForm(),
                    SizedBox(
                      height: 10.00,
                    ),
                    _buildPasswordForm(),
                    SizedBox(
                      height: 10.00,
                    ),
                    _authMode == AuthMode.Login
                        ? Container()
                        : _buildPasswordConfirmForm(),
                    _buildAcceptSwitcher(),
                    SizedBox(
                      height: 10.0,
                    ),
                    FlatButton(
                      child: Text('Switch to ${_authMode == AuthMode.Login
                          ? 'Signup'
                          : 'Login'}'),
                      onPressed: () {
                        setState(() {
                          _authMode = _authMode == AuthMode.Login
                              ? AuthMode.SignUp
                              : AuthMode.Login;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10.00,
                    ),
                    ScopedModelDescendant<MainModel>(
                      builder: (BuildContext context, Widget child,
                          MainModel model) {
                        return RaisedButton(
                            color: Theme.of(context).accentColor,
                            textColor: Colors.white,
                            child: Text('LOGIN'),
                            onPressed: () =>
                                _submitAuth(model.login, model.signup));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      fit: BoxFit.cover,
      image: AssetImage('assets/login_background.jpg'),
    );
  }

  Widget _buildEmailForm() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'This is not a valid email!!';
        }
      },
      decoration: InputDecoration(
        labelText: 'Email',
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        suffixIcon: Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
      onSaved: (String value) {
        _loginData['email'] = value;
      },
    );
  }

  Widget _buildPasswordForm() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty || value.length < 8) {
          return 'Password is too short';
        }
      },
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        labelText: 'Password',
        suffixIcon: Icon(Icons.lock),
      ),
      keyboardType: TextInputType.text,
      onSaved: (String value) {
        _loginData['password'] = value;
      },
      controller: _passwordTextController,
    );
  }

  Widget _buildPasswordConfirmForm() {
    return TextFormField(
      validator: (String value) {
        if (_passwordTextController.text != value) {
          return 'Passwords do not match!';
        }
      },
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        labelText: 'Confirm Password',
        suffixIcon: Icon(Icons.lock),
      ),
      keyboardType: TextInputType.text,
      onSaved: (String value) {
        _loginData['password'] = value;
      },
    );
  }

  Widget _buildAcceptSwitcher() {
    return SwitchListTile(
      value: _loginData['isTermsAccepted'],
      title: Text('Accept terms'),
      onChanged: (bool value) {
        setState(() {
          _loginData['isTermsAccepted'] = value;
        });
      },
    );
  }

  void _submitAuth(Function login, Function signup) async {
    if (_loginKey.currentState.validate()) {
      if (_loginData['isTermsAccepted']) {
        _loginKey.currentState.save();
        if (_authMode == AuthMode.Login) {
          login(_loginData['email'], _loginData['password']);
        } else {
          final Map<String, dynamic> successInfo =
              await signup(_loginData['email'], _loginData['password']);
          if (successInfo['success']) {
            Navigator.pushReplacementNamed(context, '/products');
          } else {}
        }
      } else
        _showWarningDialog(context);
    } else
      return;
  }

  void _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Accept terms, bitch!'),
            content: Text(
                'We can not let you to log in unless you accept the terms'),
            actions: <Widget>[
              FlatButton(
                child: Text("Got it"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
