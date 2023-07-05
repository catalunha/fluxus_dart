import 'package:fluxus_dart/activity/model/activity_model.dart';
import 'package:fluxus_dart/patient_healthPlan/model/patient_healthPlan_model.dart';
import 'package:fluxus_dart/room/model/room_model.dart';
import 'package:fluxus_dart/status/model/status_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../user_profile/model/user_profile_model.dart';

part 'therapy_model.freezed.dart';

@freezed
abstract class TherapyModel with _$TherapyModel {
  factory TherapyModel({
    String? id,
    DateTime? dtStart,
    DateTime? dtEnd,
    ActivityModel? activity,
    RoomModel? room,
    @Default(1) int capacity,
    List<UserProfileModel>? professionals,
    List<PatientHealthPlanModel>? patientHealthPlans,
    StatusModel? status,
    @Default('') String history,
  }) = _TherapyModel;
}
