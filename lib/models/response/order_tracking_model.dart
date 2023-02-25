import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_app/core/constant/enum.dart';

part 'order_tracking_model.g.dart';

@JsonSerializable(createToJson: false)
class OrderTrackingResponseModel extends Equatable {
  final int status;
  final String message;
  final OrderTrackingDataModel? data;

  const OrderTrackingResponseModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory OrderTrackingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OrderTrackingResponseModelFromJson(json);

  @override
  List<Object?> get props => [status, message, data];
}

@JsonSerializable(createToJson: false)
class OrderTrackingDataModel extends Equatable {
  final OrderStatusType status;
  final double? latitude;
  final double? longitude;

  const OrderTrackingDataModel({
    required this.status,
    this.latitude,
    this.longitude,
  });

  factory OrderTrackingDataModel.fromJson(Map<String, dynamic> json) =>
      _$OrderTrackingDataModelFromJson(json);

  @override
  List<Object?> get props => [status, latitude, longitude];
}
