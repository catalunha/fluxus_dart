import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../model/status_model.dart';

class StatusEntity {
  static const String className = 'Status';
  static const String id = 'objectId';
  static const String name = 'name';
  static const String description = 'description';

  StatusModel toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) {
    final StatusModel model = StatusModel(
      id: parseObject.objectId!,
      name: parseObject.get(StatusEntity.name),
      description: parseObject.get(StatusEntity.description),
    );
    return model;
  }

  Future<ParseObject> toParse(StatusModel model) async {
    final parseObject = ParseObject(StatusEntity.className);
    parseObject.objectId = model.id;

    if (model.name != null) {
      parseObject.set(StatusEntity.name, model.name);
    }
    if (model.description != null) {
      parseObject.set(StatusEntity.description, model.description);
    }
    return parseObject;
  }
}
