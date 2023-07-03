import 'package:freezed_annotation/freezed_annotation.dart';

import '../../healthPlan/model/healthplan_model.dart';
import '../../patient/model/patient_model.dart';
import '../../procedure/model/procedure_model.dart';
import '../../status/model/status_model.dart';
import '../../user_profile/model/user_profile_model.dart';

part 'attendance_model.freezed.dart';

@freezed
abstract class AttendanceModel with _$AttendanceModel {
  factory AttendanceModel({
    String? id,
    UserProfileModel? professional,
    ProcedureModel? procedure,
    PatientModel? patient,
    HealthPlanModel? healthPlan,
    String? authorizationCode,
    DateTime? authorizationDateCreated,
    DateTime? authorizationDateLimit,
    DateTime? attendance,
    String? history,
    DateTime? confirmedPresence,
    StatusModel? status,
  }) = _AttendanceModel;
}
