import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_app/core/constant/enum.dart';
import 'package:mobile_app/models/response/customer_model.dart';
import 'package:mobile_app/models/response/driver_model.dart';

part 'order_model.g.dart';

@JsonSerializable(createToJson: false)
class OrderResponseModel extends Equatable {
  final int status;
  final String message;
  final OrderDataModel? result;

  const OrderResponseModel({
    required this.status,
    required this.message,
    this.result,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseModelFromJson(json);

  @override
  List<Object?> get props => [status, message, result];
}

@JsonSerializable(createToJson: false)
class OrderDataModel extends Equatable {
  final List<OrderModel> data;
  final String? nextPageUrl;

  const OrderDataModel({
    required this.data,
    this.nextPageUrl,
  });
  factory OrderDataModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDataModelFromJson(json);

  @override
  List<Object?> get props => [data, nextPageUrl];
}

@JsonSerializable(createToJson: false)
class OrderModel extends Equatable {
  final String id;
  final String name;
  final OrderStatusType status;
  final String? imageUrl;
  final String dateOrder;
  final String? datePickup;
  final String? dateArrived;
  final String origin;
  final String destination;
  final double? latitude;
  final double? longitude;
  final CustomerModel customer;
  final DriverModel driver;

  const OrderModel({
    required this.id,
    required this.name,
    required this.status,
    this.imageUrl,
    required this.dateOrder,
    this.datePickup,
    this.dateArrived,
    required this.origin,
    required this.destination,
    this.latitude,
    this.longitude,
    required this.customer,
    required this.driver,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  @override
  List<Object?> get props => [];
}
