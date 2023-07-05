import 'package:fluxus_dart/therapy/entity/therapy_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../patient/entity/patient_entity.dart';
import '../patient_healthPlan/entity/attendance_entity.dart';
import 'entity/therapy_b4a.dart';

Future<void> therapyAction01() async {
  print('+++ therapyAction01...');
  TherapyB4a therapyB4a = TherapyB4a();
  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(TherapyEntity.className));
/*
  query.whereEqualTo(
      TherapyEntity.professionals,
      (ParseObject(UserProfileEntity.className)..objectId = 'JyrhaEVDqW')
          .toPointer());
*/
/*
  query.whereEqualTo(
      TherapyEntity.patientHealthPlans,
      (ParseObject(PatientHealthPlanEntity.className)..objectId = '0q31xjPbhu')
          .toPointer());
*/

  final QueryBuilder<ParseObject> queryPatientHealthPlans =
      QueryBuilder<ParseObject>(ParseObject(PatientHealthPlanEntity.className));
  queryPatientHealthPlans.whereEqualTo(
      PatientHealthPlanEntity.patient,
      (ParseObject(PatientEntity.className)..objectId = 'OBOTuOFOhn')
          .toPointer());
  queryPatientHealthPlans.query();

  // query.whereMatchesQuery(
  //     TherapyEntity.patientHealthPlans, queryPatientHealthPlans);

  // query.whereMatchesKeyInQuery(
  //     TherapyEntity.patientHealthPlans, 'objectId', queryPatientHealthPlans);

  // query.whereMatchesKeyInQuery(
  //     TherapyEntity.patientHealthPlans, 'objectId', queryPatientHealthPlans);

  final list = await therapyB4a.list(query, cols: {
    '${TherapyEntity.className}.cols': [
      TherapyEntity.dtStart,
      TherapyEntity.dtEnd,
      TherapyEntity.activity,
      TherapyEntity.room,
      TherapyEntity.capacity,
      TherapyEntity.professionals,
      TherapyEntity.patientHealthPlans,
      TherapyEntity.status,
      TherapyEntity.history,
    ],
    '${TherapyEntity.className}.pointers': [
      TherapyEntity.activity,
      TherapyEntity.room,
    ],
  });
  print('listando...');
  for (var element in list) {
    print(element.id);
    // print(element);
  }
  print('listando...');

  print('--- therapyAction01...');
}
