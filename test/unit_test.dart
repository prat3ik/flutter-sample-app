import 'package:demo_app/screen/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('"Unit Test" for password is empty', () {
    var password_result = Validator.password('');
    expect(password_result, 'Password can\'t be empty');
  });

  test('"Unit Test" for password is not empty', () {
    var password_result = Validator.password('admin');
    expect(password_result, null);
  });

  test('"Unit Test" for username is empty', () {
    var username_result = Validator.username('');
    expect(username_result, 'Username can\'t be empty');
  });

  test('"Unit Test" for username is not empty', () {
    var username_result = Validator.username('admin');
    expect(username_result, null);
  });
}