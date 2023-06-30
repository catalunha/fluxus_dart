import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'healthplantype_model.dart';

class HealthPlanTypeEntity {
  static const String className = 'HealthPlanType';
  static const String id = 'objectId';
  static const String name = 'name';

  HealthPlanTypeModel toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) {
    HealthPlanTypeModel model = HealthPlanTypeModel(
      id: parseObject.objectId!,
      name: parseObject.get(HealthPlanTypeEntity.name),
    );
    return model;
  }

  Future<ParseObject> toParse(HealthPlanTypeModel model) async {
    final parseObject = ParseObject(HealthPlanTypeEntity.className);
    parseObject.objectId = model.id;

    if (model.name != null) {
      parseObject.set(HealthPlanTypeEntity.name, model.name);
    }

    return parseObject;
  }
}
