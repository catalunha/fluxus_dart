import 'package:freezed_annotation/freezed_annotation.dart';

import '../healthPlanType/healthplantype_model.dart';

part 'healthplan_model.freezed.dart';
part 'healthplan_model.g.dart';

@freezed
abstract class HealthPlanModel with _$HealthPlanModel {
  factory HealthPlanModel({
    String? id,
    HealthPlanTypeModel? healthPlanType,
    String? code,
    DateTime? due,
    String? description,
  }) = _HealthPlanModel;
  factory HealthPlanModel.fromJson(Map<String, dynamic> json) =>
      _$HealthPlanModelFromJson(json);
}
