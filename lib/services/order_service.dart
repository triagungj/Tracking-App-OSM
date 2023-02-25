import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mobile_app/core/config/client.dart';
import 'package:mobile_app/core/config/header_options.dart';
import 'package:mobile_app/core/constant/api_path.dart';
import 'package:mobile_app/models/response/order_model.dart';
import 'package:mobile_app/models/response/order_tracking_model.dart';

class OrderService {
  Future<OrderResponseModel> getOrderList(int? page, int? size) async {
    try {
      final options = await getBaseOptions();

      final response = await client.get(
        ApiPath.order,
        queryParameters: {
          'page': page,
          'size': size,
        },
        options: options,
      );

      log('${response.headers}');
      log(response.requestOptions.baseUrl + response.requestOptions.path);
      log('${response.data}');

      final responseModel = OrderResponseModel.fromJson(response.data);

      return responseModel;
    } on DioError catch (e) {
      if (e.response != null) {
        log('${e.response!.data}');
        log('${e.response!.headers}');
        return OrderResponseModel(
          status: e.response?.data['status'] ?? 500,
          message: e.response?.data['message'] ?? 'Server Error',
        );
      } else {
        log(e.message);
        return OrderResponseModel(
          status: e.response?.data['status'] ?? 500,
          message: e.response?.data['message'] ?? 'Server Error',
        );
      }
    }
  }

  Future<OrderTrackingResponseModel> getTrackingOrder(String id) async {
    
    try {
      final options = await getBaseOptions();

      final response = await client.get(
        '${ApiPath.tracking}/$id',
        options: options,
      );

      log('${response.headers}');
      log(response.requestOptions.baseUrl + response.requestOptions.path);
      log('${response.data}');

      final responseModel = OrderTrackingResponseModel.fromJson(response.data);

      return responseModel;
    } on DioError catch (e) {
      if (e.response != null) {
        log('${e.response!.data}');
        log('${e.response!.headers}');
        return OrderTrackingResponseModel(
          status: e.response?.data['status'] ?? 500,
          message: e.response?.data['message'] ?? 'Server Error',
        );
      } else {
        log(e.message);
        return OrderTrackingResponseModel(
          status: e.response?.data['status'] ?? 500,
          message: e.response?.data['message'] ?? 'Server Error',
        );
      }
    }
  }
}
