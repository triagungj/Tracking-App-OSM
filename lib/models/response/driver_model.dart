import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_model.g.dart';

@JsonSerializable(createToJson: false)
class DriverModel extends Equatable {
  final String id;
  final String name;
  final String? avatar;
  final String noHp;

  const DriverModel({
    required this.id,
    required this.name,
    this.avatar,
    required this.noHp,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) =>
      _$DriverModelFromJson(json);

  @override
  List<Object?> get props => [id, name, avatar, noHp];
}
