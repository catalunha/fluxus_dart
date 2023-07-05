import 'package:freezed_annotation/freezed_annotation.dart';

import '../../healthPlan/model/healthplan_model.dart';
import '../../patient/model/patient_model.dart';

part 'patient_healthPlan_model.freezed.dart';

@freezed
abstract class PatientHealthPlanModel with _$PatientHealthPlanModel {
  factory PatientHealthPlanModel({
    String? id,
    PatientModel? patient,
    HealthPlanModel? healthPlan,
  }) = _PatientHealthPlanModel;
}
