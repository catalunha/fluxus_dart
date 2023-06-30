import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../model/office_model.dart';

class OfficeEntity {
  static const String className = 'Office';
  static const String id = 'objectId';
  static const String name = 'name';

  OfficeModel toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) {
    final OfficeModel model = OfficeModel(
      id: parseObject.objectId!,
      name: parseObject.get(OfficeEntity.name),
    );
    return model;
  }

  Future<ParseObject> toParse(OfficeModel model) async {
    final parseObject = ParseObject(OfficeEntity.className);
    parseObject.objectId = model.id;

    if (model.name != null) {
      parseObject.set(OfficeEntity.name, model.name);
    }

    return parseObject;
  }
}
