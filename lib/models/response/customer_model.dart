import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_model.g.dart';

@JsonSerializable(createToJson: false)
class CustomerModel extends Equatable {
  final String id;
  final String name;
  final String? avatar;
  final String noHp;

  const CustomerModel({
    required this.id,
    required this.name,
    this.avatar,
    required this.noHp,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  @override
  List<Object?> get props => [id, name, avatar, noHp];
}
