import 'package:dio/dio.dart';
import 'package:mobile_app/core/constant/key_constant.dart';

final client = Dio(
  BaseOptions(
    baseUrl: KeyConstant.baseUrl,
    connectTimeout: 30000,
    receiveTimeout: 30000,
    receiveDataWhenStatusError: true,
  ),
);
