import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../healthPlan/entity/healthplan_entity.dart';
import '../../patient/entity/patient_entity.dart';
import '../model/patient_healthPlan_model.dart';

class PatientHealthPlanEntity {
  static const String className = 'PatientHealthPlan';
  static const String id = 'objectId';
  //singleCols
  //pointerCols
  static const String patient = 'patient';
  static const String healthPlan = 'healthPlan';

  Future<PatientHealthPlanModel> toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) async {
    final PatientHealthPlanModel model = PatientHealthPlanModel(
      id: parseObject.objectId!,
      patient: parseObject.get(PatientHealthPlanEntity.patient) != null
          ? await PatientEntity().toModel(
              parseObject.get(PatientHealthPlanEntity.patient),
              cols: cols)
          : null,
      healthPlan: parseObject.get(PatientHealthPlanEntity.healthPlan) != null
          ? HealthPlanEntity()
              .toModel(parseObject.get(PatientHealthPlanEntity.healthPlan))
          : null,
    );
    return model;
  }

  Future<ParseObject> toParse(PatientHealthPlanModel model) async {
    final parseObject = ParseObject(PatientHealthPlanEntity.className);
    parseObject.objectId = model.id;

    if (model.patient != null) {
      parseObject.set(
          PatientHealthPlanEntity.patient,
          (ParseObject(PatientEntity.className)..objectId = model.patient!.id)
              .toPointer());
    }
    if (model.healthPlan != null) {
      parseObject.set(
          PatientHealthPlanEntity.healthPlan,
          (ParseObject(HealthPlanEntity.className)
                ..objectId = model.healthPlan!.id)
              .toPointer());
    }
    return parseObject;
  }
}
