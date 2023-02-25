// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponseModel _$OrderResponseModelFromJson(Map<String, dynamic> json) =>
    OrderResponseModel(
      status: json['status'] as int,
      message: json['message'] as String,
      result: json['result'] == null
          ? null
          : OrderDataModel.fromJson(json['result'] as Map<String, dynamic>),
    );

OrderDataModel _$OrderDataModelFromJson(Map<String, dynamic> json) =>
    OrderDataModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextPageUrl: json['next_page_url'] as String?,
    );

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as String,
      name: json['name'] as String,
      status: $enumDecode(_$OrderStatusTypeEnumMap, json['status']),
      imageUrl: json['image_url'] as String?,
      dateOrder: json['date_order'] as String,
      datePickup: json['date_pickup'] as String?,
      dateArrived: json['date_arrived'] as String?,
      origin: json['origin'] as String,
      destination: json['destination'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      customer:
          CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      driver: DriverModel.fromJson(json['driver'] as Map<String, dynamic>),
    );

const _$OrderStatusTypeEnumMap = {
  OrderStatusType.waiting: 'waiting',
  OrderStatusType.ontheway: 'ontheway',
  OrderStatusType.done: 'done',
};
