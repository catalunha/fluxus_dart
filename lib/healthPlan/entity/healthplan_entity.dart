import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../healthPlanType/healthplantype_entity.dart';
import '../model/healthplan_model.dart';

class HealthPlanEntity {
  static const String className = 'HealthPlan';
  // Nome do campo App =  no Database
  static const String id = 'objectId';
  //normal
  static const String code = 'code';
  static const String due = 'due';
  static const String description = 'description';
  //pointers
  static const String healthPlanType = 'healthPlanType';

  HealthPlanModel toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) {
    HealthPlanModel model = HealthPlanModel(
      id: parseObject.objectId!,
      code: parseObject.get(HealthPlanEntity.code),
      due: parseObject.get<DateTime>(HealthPlanEntity.due)?.toLocal(),
      description: parseObject.get(HealthPlanEntity.description),
      healthPlanType: parseObject.get(HealthPlanEntity.healthPlanType) != null
          ? HealthPlanTypeEntity()
              .toModel(parseObject.get(HealthPlanEntity.healthPlanType))
          : null,
    );
    return model;
  }

  Future<ParseObject> toParse(HealthPlanModel model) async {
    final parseObject = ParseObject(HealthPlanEntity.className);
    parseObject.objectId = model.id;
    if (model.description != null) {
      parseObject.set(HealthPlanEntity.description, model.description);
    }
    if (model.code != null) {
      parseObject.set(HealthPlanEntity.code, model.code);
    }
    if (model.due != null) {
      parseObject.set<DateTime?>(HealthPlanEntity.due,
          DateTime(model.due!.year, model.due!.month, model.due!.day));
    }
    if (model.description != null) {
      parseObject.set(HealthPlanEntity.description, model.description);
    }

    if (model.healthPlanType != null) {
      parseObject.set(
          HealthPlanEntity.healthPlanType,
          (ParseObject(HealthPlanTypeEntity.className)
                ..objectId = model.healthPlanType!.id)
              .toPointer());
    }
    return parseObject;
  }
}
