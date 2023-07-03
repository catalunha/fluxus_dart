import 'package:freezed_annotation/freezed_annotation.dart';

part 'hour_model.freezed.dart';

@freezed
abstract class HourModel with _$HourModel {
  factory HourModel({
    String? id,
    String? name,
    String? start,
    String? end,
    bool? isActive,
  }) = _HourModel;
}
