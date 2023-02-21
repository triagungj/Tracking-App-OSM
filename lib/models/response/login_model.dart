import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable(createToJson: false)
class LoginModel extends Equatable {
  final int status;
  final String message;
  final String? token;
  final bool? isDriver;

  const LoginModel({
    required this.status,
    required this.message,
    this.token,
    this.isDriver,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  @override
  List<Object?> get props => throw UnimplementedError();
}
