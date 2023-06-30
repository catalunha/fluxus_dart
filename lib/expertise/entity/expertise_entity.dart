import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../model/expertise_model.dart';

class ExpertiseEntity {
  static const String className = 'Expertise';
  static const String id = 'objectId';
  static const String name = 'name';

  ExpertiseModel toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) {
    ExpertiseModel model = ExpertiseModel(
      id: parseObject.objectId!,
      name: parseObject.get<String>(ExpertiseEntity.name),
    );
    return model;
  }

  ParseObject toParse(ExpertiseModel model) {
    final parseObject = ParseObject(ExpertiseEntity.className);
    // parseObject.objectId = model.id;

    if (model.name != null) {
      parseObject.set(ExpertiseEntity.name, model.name);
    }

    return parseObject;
  }
}
