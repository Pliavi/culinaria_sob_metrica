import 'dart:io';

import 'package:csm_front/data/datasources/api_instance.dart';
import 'package:csm_front/data/models/user_model.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static AsyncResult<UserModel, Exception> login(
    String email,
    String password,
  ) async {
    try {
      final response = await api.post(
        "/login",
        data: {
          'email': email,
          'password': password,
        },
      );

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response.data['token']);

      final token = response.data['token'];
      api.options.headers["Authorization"] = "Bearer $token";
      const user = UserModel(email: "fake@fake.com");

      return user.toSuccess();
    } on Exception catch (e) {
      return e.toFailure();
    }
  }

  static AsyncResult<bool, Exception> checkIsLogged() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      return false.toSuccess();
    }

    api.options.headers["Authorization"] = "Bearer $token";

    final res = await api.post("/validate-token");

    return (res.statusCode == HttpStatus.ok).toSuccess();
  }

  static AsyncResult<bool, Exception> logout() async {
    final res = await api.post("/logout");

    if (res.statusCode != HttpStatus.ok) {
      return false.toSuccess();
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');

    api.options.headers["Authorization"] = "";

    return true.toSuccess();
  }
}
