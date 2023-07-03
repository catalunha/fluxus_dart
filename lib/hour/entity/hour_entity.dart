import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../model/hour_model.dart';

class HourEntity {
  static const String className = 'Hour';
  static const String id = 'objectId';
  static const String name = 'name';
  static const String start = 'start';
  static const String end = 'end';
  static const String isActive = 'isActive';

  HourModel toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) {
    final HourModel model = HourModel(
      id: parseObject.objectId!,
      name: parseObject.get(HourEntity.name),
      start: parseObject.get(HourEntity.start),
      end: parseObject.get(HourEntity.end),
      isActive: parseObject.get(HourEntity.isActive),
    );
    return model;
  }

  Future<ParseObject> toParse(HourModel model) async {
    final parseObject = ParseObject(HourEntity.className);
    parseObject.objectId = model.id;

    if (model.name != null) {
      parseObject.set(HourEntity.name, model.name);
    }
    if (model.start != null) {
      parseObject.set(HourEntity.start, model.start);
    }
    if (model.end != null) {
      parseObject.set(HourEntity.end, model.end);
    }
    if (model.isActive != null) {
      parseObject.set(HourEntity.isActive, model.isActive);
    }
    return parseObject;
  }
}
