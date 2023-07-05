import 'package:fluxus_dart/patient_healthPlan/model/patient_healthPlan_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../activity/entity/activity_entity.dart';
import '../../patient_healthPlan/entity/attendance_entity.dart';
import '../../room/entity/room_entity.dart';
import '../../status/entity/status_entity.dart';
import '../../user_profile/entity/user_profile_entity.dart';
import '../../user_profile/model/user_profile_model.dart';
import '../model/therapy_model.dart';

class TherapyEntity {
  static const String className = 'Therapy';
  // Nome do campo App =  no Database
  static const String id = 'objectId';
  static const String dtStart = 'dtStart';
  static const String dtEnd = 'dtEnd';
  static const String activity = 'activity';
  static const String room = 'room';
  static const String capacity = 'capacity';
  static const String professionals = 'professionals';
  static const String patientHealthPlans = 'patientHealthPlans';
  static const String status = 'status';
  static const String history = 'history';

  Future<TherapyModel> toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) async {
    //+++ get expertise
    final List<UserProfileModel> professionals = [];

    if (cols.containsKey('${TherapyEntity.className}.cols') &&
        cols['${TherapyEntity.className}.cols']!
            .contains(TherapyEntity.professionals)) {
      final QueryBuilder<ParseObject> queryProfessionals =
          QueryBuilder<ParseObject>(ParseObject(UserProfileEntity.className));
      queryProfessionals.whereRelatedTo(TherapyEntity.professionals,
          TherapyEntity.className, parseObject.objectId!);
      final ParseResponse parseResponse = await queryProfessionals.query();
      if (parseResponse.success && parseResponse.results != null) {
        for (var e in parseResponse.results!) {
          professionals
              .add(await UserProfileEntity().toModel(e as ParseObject));
        }
      }
    }
    //--- get expertise
    //+++ get expertise
    final List<PatientHealthPlanModel> patientHealthPlans = [];

    if (cols.containsKey('${TherapyEntity.className}.cols') &&
        cols['${TherapyEntity.className}.cols']!
            .contains(TherapyEntity.patientHealthPlans)) {
      final QueryBuilder<ParseObject> queryPatientHealthPlan =
          QueryBuilder<ParseObject>(
              ParseObject(PatientHealthPlanEntity.className));
      queryPatientHealthPlan.whereRelatedTo(TherapyEntity.patientHealthPlans,
          TherapyEntity.className, parseObject.objectId!);
      final ParseResponse parseResponse = await queryPatientHealthPlan.query();
      if (parseResponse.success && parseResponse.results != null) {
        for (var e in parseResponse.results!) {
          patientHealthPlans
              .add(await PatientHealthPlanEntity().toModel(e as ParseObject));
        }
      }
    }
    //--- get expertise
    final TherapyModel model = TherapyModel(
      id: parseObject.objectId!,
      dtStart: parseObject.get<DateTime>(TherapyEntity.dtStart)?.toLocal(),
      dtEnd: parseObject.get<DateTime>(TherapyEntity.dtEnd)?.toLocal(),
      activity: parseObject.containsKey(TherapyEntity.activity) &&
              parseObject.get(TherapyEntity.activity) != null
          ? await ActivityEntity()
              .toModel(parseObject.get(TherapyEntity.activity))
          : null,
      room: parseObject.containsKey(TherapyEntity.room) &&
              parseObject.get(TherapyEntity.room) != null
          ? RoomEntity().toModel(parseObject.get(TherapyEntity.room))
          : null,
      capacity: parseObject.get(TherapyEntity.capacity),
      professionals: professionals,
      patientHealthPlans: patientHealthPlans,
      status: parseObject.containsKey(TherapyEntity.status) &&
              parseObject.get(TherapyEntity.status) != null
          ? StatusEntity().toModel(parseObject.get(TherapyEntity.status))
          : null,
      history: parseObject.get(TherapyEntity.history) ?? '',
    );
    return model;
  }

  Future<ParseObject> toParse(TherapyModel model) async {
    final parseObject = ParseObject(TherapyEntity.className);
    parseObject.objectId = model.id;

    if (model.dtStart != null) {
      parseObject.set<DateTime?>(TherapyEntity.dtStart, model.dtStart);
    }
    if (model.dtEnd != null) {
      parseObject.set<DateTime?>(TherapyEntity.dtEnd, model.dtEnd);
    }
    if (model.activity != null) {
      parseObject.set(
          TherapyEntity.activity,
          (ParseObject(ActivityEntity.className)..objectId = model.activity!.id)
              .toPointer());
    }
    if (model.room != null) {
      parseObject.set(
          TherapyEntity.room,
          (ParseObject(RoomEntity.className)..objectId = model.room!.id)
              .toPointer());
    }
    parseObject.set(TherapyEntity.capacity, model.capacity);
    if (model.status != null) {
      parseObject.set(
          TherapyEntity.status,
          (ParseObject(StatusEntity.className)..objectId = model.status!.id)
              .toPointer());
    }
    parseObject.set(TherapyEntity.history, model.history);
    return parseObject;
  }

  ParseObject? toParseRelation({
    required String objectId,
    required String relationColumn,
    required String relationTable,
    required List<String> ids,
    required bool add,
  }) {
    final parseObject = ParseObject(TherapyEntity.className);
    parseObject.objectId = objectId;
    if (ids.isEmpty) {
      parseObject.unset(relationColumn);
      return parseObject;
    }
    if (add) {
      parseObject.addRelation(
        relationColumn,
        ids
            .map(
              (element) => ParseObject(relationTable)..objectId = element,
            )
            .toList(),
      );
    } else {
      parseObject.removeRelation(
          relationColumn,
          ids
              .map((element) => ParseObject(relationTable)..objectId = element)
              .toList());
    }
    return parseObject;
  }
}
