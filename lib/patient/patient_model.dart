import 'package:freezed_annotation/freezed_annotation.dart';

import '../healthPlan/healthplan_model.dart';
import '../region/region_model.dart';

part 'patient_model.freezed.dart';
part 'patient_model.g.dart';

@freezed
abstract class PatientModel with _$PatientModel {
  factory PatientModel({
    String? id,
    String? email,
    String? phone,
    String? nickname,
    String? name,
    String? cpf,
    String? address,
    String? cep,
    bool? isFemale,
    DateTime? birthday,
    RegionModel? region,
    List<PatientModel>? family,
    List<HealthPlanModel>? healthPlans,
  }) = _PatientModel;
  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);
}
