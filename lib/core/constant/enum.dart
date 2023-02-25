import 'package:json_annotation/json_annotation.dart';

enum OrderStatusType {
  @JsonValue('waiting')
  waiting,
  @JsonValue('ontheway')
  ontheway,
  @JsonValue('done')
  done,
}
