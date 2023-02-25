import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mobile_app/core/config/client.dart';
import 'package:mobile_app/core/config/header_options.dart';
import 'package:mobile_app/core/constant/api_path.dart';
import 'package:mobile_app/core/constant/key_constant.dart';
import 'package:mobile_app/models/request/login_body.dart';
import 'package:mobile_app/models/response/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<LoginModel> login(LoginBody body) async {
    try {
      final options = await getBaseOptions();

      final response = await client.post(
        ApiPath.login,
        data: body.toJson(),
        options: options,
      );

      log('${response.data}');
      log('${response.headers}');

      final responseModel = LoginModel.fromJson(response.data);
      final prefs = await SharedPreferences.getInstance();

      if (responseModel.token != null) {
        prefs.setString(KeyConstant.accessTokenKey, responseModel.token!);
      }

      return responseModel;
    } on DioError catch (e) {
      if (e.response != null) {
        log('${e.response!.data}');
        log('${e.response!.headers}');
        return LoginModel(
          status: e.response?.data['status'] ?? 500,
          message: e.response?.data['message'] ?? 'Server Error',
        );
      } else {
        log(e.message);
        return LoginModel(
          status: e.response?.data['status'] ?? 500,
          message: e.response?.data['message'] ?? 'Serever Error',
        );
      }
    }
  }
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
