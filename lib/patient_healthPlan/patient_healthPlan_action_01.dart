import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../patient/entity/patient_entity.dart';
import 'entity/attendance_b4a.dart';
import 'entity/attendance_entity.dart';

Future<void> patientHealthPlanAction01() async {
  print('+++ PatientHealthPlanAction01...');
  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(PatientHealthPlanEntity.className));

  query.whereEqualTo(
      PatientHealthPlanEntity.patient,
      (ParseObject(PatientEntity.className)..objectId = 'OBOTuOFOhn')
          .toPointer());

  final list = await PatientHealthPlanB4a().list(query, cols: {
    '${PatientHealthPlanEntity.className}.cols': [
      PatientHealthPlanEntity.patient,
      PatientHealthPlanEntity.healthPlan
    ],
    '${PatientHealthPlanEntity.className}.pointers': [
      PatientHealthPlanEntity.patient,
      PatientHealthPlanEntity.healthPlan
    ],
  });
  for (var element in list) {
    print('${element.id}');
  }
  print('--- PatientHealthPlanAction01...');
}
