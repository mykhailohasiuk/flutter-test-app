import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _emailValue = '';
  String _passwordValue = '';
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(image: _buildBackgroundImage()),
        child: Center(
          child: SingleChildScrollView(
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
                RaisedButton(
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                    child: Text('LOGIN'),
                    onPressed: _submitLogin),
              ],
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
    return TextField(
      decoration: InputDecoration(
        labelText: 'Email',
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        suffixIcon: Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (String value) {
        setState(() {
          _emailValue = value;
        });
      },
    );
  }

  Widget _buildPasswordForm() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        labelText: 'Password',
        suffixIcon: Icon(Icons.lock),
      ),
      keyboardType: TextInputType.text,
      onChanged: (String value) {
        setState(() {
          _passwordValue = value;
        });
      },
    );
  }

  Widget _buildAcceptSwitcher() {
    return SwitchListTile(
      title: Text('Accept terms'),
      value: _acceptTerms,
      onChanged: (bool value) {
        setState(() {
          _acceptTerms = value;
        });
      },
    );
  }

  void _submitLogin() {
    Navigator.pushReplacementNamed(context, '/products');
  }
}
