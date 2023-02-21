import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_body.g.dart';

@JsonSerializable(createFactory: false)
class LoginBody extends Equatable {
  final String username;
  final String password;

  const LoginBody({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);

  @override
  List<Object?> get props => [];
}
