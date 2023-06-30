import 'package:freezed_annotation/freezed_annotation.dart';

part 'office_model.freezed.dart';

@freezed
abstract class OfficeModel with _$OfficeModel {
  factory OfficeModel({
    String? id,
    String? name,
  }) = _OfficeModel;
}
