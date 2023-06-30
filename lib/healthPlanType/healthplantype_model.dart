import 'package:freezed_annotation/freezed_annotation.dart';

part 'healthplantype_model.freezed.dart';
part 'healthplantype_model.g.dart';

@freezed
abstract class HealthPlanTypeModel with _$HealthPlanTypeModel {
  factory HealthPlanTypeModel({
    String? id,
    String? name,
  }) = _HealthPlanTypeModel;
  factory HealthPlanTypeModel.fromJson(Map<String, dynamic> json) =>
      _$HealthPlanTypeModelFromJson(json);
}
