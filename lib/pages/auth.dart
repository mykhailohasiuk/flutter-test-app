import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';

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

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWith = deviceWidth > 768.0 ? 500.0 : deviceWidth * 0.95;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
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
                    _buildAcceptSwitcher(),
                    SizedBox(
                      height: 10.0,
                    ),
                    ScopedModelDescendant<MainModel>(
                      builder: (BuildContext context, Widget child,
                          MainModel model) {
                        return RaisedButton(
                            color: Theme.of(context).accentColor,
                            textColor: Colors.white,
                            child: Text('LOGIN'),
                            onPressed:() => _submitLogin(model.login));
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
      initialValue: 'myshCo@uke.net',
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
      initialValue: '123456789',
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

  void _submitLogin(Function login) {
    if (_loginKey.currentState.validate()) {
      if (_loginData['isTermsAccepted']) {
        _loginKey.currentState.save();
        login(_loginData['email'], _loginData['password']);
        Navigator.pushReplacementNamed(context, '/products');
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
