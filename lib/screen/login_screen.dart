import 'package:demo_app/utils/constants.dart';
import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen>{
  bool _rememberMe = false;
  static const DEFAULT_USERNAME = "admin";
  static const DEFAULT_PASSWORD = "admin";
  var usernameText = "";
  var passwordText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFE54300),
                Color(0xFFD94F00),
                Color(0xFFCA5F00),
                Color(0xFFBF6C00),
              ],
//              stops: [0.1, 0.4, 0.7, 0.9],
            ),
          ),
        ),
        Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 120.0
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign In',
                  key: Key('signInLabel'),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.0,),
                _buildUsernameTF(),
                SizedBox(height: 30.0,),
                _buildPasswordTF(),
                _buildForgotPasswordBtn(),
                _buildRememberMeCheckbox(),
                _buildLoginBtn(),
              ],
            ),
          ),
        ),
      ],)
    );
  }

 Widget _buildUsernameTF() {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          key: Key('userNameLabel'),
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0,),
        Container(
          key: Key('userName'),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0,),
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                hintText: 'Enter Your Username',
                hintStyle: kHintTextStyle
            ),
            onChanged: (input) => usernameText = input,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          key: Key('passwordLabel'),
          style: kLabelStyle,

        ),
        SizedBox(height: 10.0,),
        Container(
          key: Key('password'),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0,),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                hintText: 'Enter Your Password',
                hintStyle: kHintTextStyle
            ),
            onChanged: (input) => passwordText = input,
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      key: Key('forgotPassword'),
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          key: Key('forgotPasswordLabel'),
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            key: Key('rememberMeCheckBox'),
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            key: Key('rememberMeLabel'),
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      key: Key('loginBtn'),
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => doLogin(context),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFFBF6C00),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
  void doLogin(BuildContext context){
    var alertDialog;
    if(usernameText.isEmpty){
      alertDialog = AlertDialog(
        key: Key('loginDialog'),
        title: Text('Login'),
        content: Text(Validator.username(usernameText),
        key: Key('userNameEmptyText'),),
      );
    }else if(passwordText.isEmpty){
      alertDialog = AlertDialog(
        key: Key('loginDialog'),
        title: Text('Login'),
        content: Text(Validator.password(passwordText),
        key: Key('passwordEmptyText')),
      );
    }else if(usernameText == DEFAULT_USERNAME && passwordText == DEFAULT_PASSWORD){
      alertDialog = AlertDialog(
        key: Key('loginDialog'),
        title: Text('Login'),
        content: Text('Login Successfully..',
        key: Key('loginSuccessText')),
      );
    }else{
      alertDialog = AlertDialog(
        key: Key('loginDialog'),
        title: Text('Login'),
        content: Text('Username and Password Incorrect..',
        key: Key('loginFailText')),
      );
    }
    showDialog(
      context: context,
      builder: (BuildContext context){
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop(true);
        });
        return alertDialog;
      }
    );
  }
}

class Validator{

  static String username(String username){
    return username.isEmpty ? 'Username can\'t be empty' : null;
  }

  static String password(String password){
    return password.isEmpty ? 'Password can\'t be empty' : null;
  }

}