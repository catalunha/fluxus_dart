import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_model.freezed.dart';

@freezed
abstract class StatusModel with _$StatusModel {
  factory StatusModel({
    String? id,
    String? name,
    String? description,
  }) = _StatusModel;
}
