import 'package:dio/dio.dart';
import 'package:mobile_app/core/constant/key_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Options> getBaseOptions() async {
  final prefs = await SharedPreferences.getInstance();
  final storageToken = prefs.getString(KeyConstant.accessTokenKey);

  final headers = <String, dynamic>{
    'Accept': 'application/json',
    'isToken': prefs.containsKey(KeyConstant.accessTokenKey),
    'Authorization': 'Bearer $storageToken',
  };

  return Options(
    headers: headers,
  );
}
