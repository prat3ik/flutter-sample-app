import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Sample Integration tests', () {
    FlutterDriver driver;

    const VALID_USERNAME = "admin";
    const VALID_PASSWORD = "admin";

    final signInLabel = find.byValueKey('signInLabel');
    final userNameLabel = find.byValueKey('userNameLabel');
    final passwordLabel = find.byValueKey('passwordLabel');
    final forgotPasswordLabel = find.byValueKey('forgotPasswordLabel');
    final rememberMeLabel = find.byValueKey('rememberMeLabel');
    final rememberMeCheckBox = find.byValueKey('rememberMeCheckBox');
    final userNameEditText = find.byValueKey('userName');
    final passwordEditText = find.byValueKey('password');
    final loginButton = find.byValueKey('loginBtn');
    final loginAlertDialog = find.byValueKey('loginDialog');
    final loginSuccessText = find.byValueKey('loginSuccessText');
    final loginFailText = find.byValueKey('loginFailText');
    final userNameEmptyText = find.byValueKey('userNameEmptyText');
    final passwordEmptyText = find.byValueKey('passwordEmptyText');


    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    test('Verify user can see the login screen', () async{
      await driver.waitFor(signInLabel);
      await driver.waitFor(userNameLabel);
      await driver.waitFor(userNameEditText);
      await driver.waitFor(passwordLabel);
      await driver.waitFor(passwordEditText);
      await driver.waitFor(forgotPasswordLabel);
      await driver.waitFor(rememberMeLabel);
      await driver.waitFor(rememberMeCheckBox);
      await driver.waitFor(loginButton);
    });

    test('User can login with valid credentials', () async{
      await driver.tap(userNameEditText);
      await driver.enterText(VALID_USERNAME);
      await driver.tap(passwordEditText);
      await driver.enterText(VALID_PASSWORD);
      await driver.tap(loginButton);
      await driver.waitFor(loginAlertDialog);
      expect(await driver.getText(loginSuccessText), "Login Successfully..");
    });

    test('User can not login with invalid credentials', () async{
      await driver.tap(userNameEditText);
      await driver.enterText("abcd");
      await driver.tap(passwordEditText);
      await driver.enterText("abcd");
      await driver.tap(loginButton);
      await driver.waitFor(loginAlertDialog);
      expect(await driver.getText(loginFailText), "Username and Password Incorrect..");
     });

    test('User can not login with empty username', () async{
      await driver.tap(userNameEditText);
      await driver.enterText("");
      await driver.tap(passwordEditText);
      await driver.enterText(VALID_PASSWORD);
      await driver.tap(loginButton);
      await driver.waitFor(loginAlertDialog);
      expect(await driver.getText(userNameEmptyText), "Username can't be empty");
    });

    test('User can not login with empty password', () async{
      await driver.tap(userNameEditText);
      await driver.enterText(VALID_USERNAME);
      await driver.tap(passwordEditText);
      await driver.enterText("");
      await driver.tap(loginButton);
      await driver.waitFor(loginAlertDialog);
      expect(await driver.getText(passwordEmptyText), "Password can't be empty");
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });
  });


}
