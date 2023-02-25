// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_tracking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderTrackingResponseModel _$OrderTrackingResponseModelFromJson(
        Map<String, dynamic> json) =>
    OrderTrackingResponseModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : OrderTrackingDataModel.fromJson(
              json['data'] as Map<String, dynamic>),
    );

OrderTrackingDataModel _$OrderTrackingDataModelFromJson(
        Map<String, dynamic> json) =>
    OrderTrackingDataModel(
      status: $enumDecode(_$OrderStatusTypeEnumMap, json['status']),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

const _$OrderStatusTypeEnumMap = {
  OrderStatusType.waiting: 'waiting',
  OrderStatusType.ontheway: 'ontheway',
  OrderStatusType.done: 'done',
};
