import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'region_model.dart';

class RegionEntity {
  static const String className = 'Region';
  // Nome do campo App =  no Database
  static const String id = 'objectId';
  static const String uf = 'uf';
  static const String city = 'city';
  static const String name = 'name';

  RegionModel toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) {
    RegionModel model = RegionModel(
        id: parseObject.objectId!,
        uf: parseObject.get(RegionEntity.uf),
        city: parseObject.get(RegionEntity.city),
        name: parseObject.get(RegionEntity.name));
    return model;
  }

  Future<ParseObject> toParse(RegionModel model) async {
    final parseObject = ParseObject(RegionEntity.className);
    parseObject.objectId = model.id;

    if (model.uf != null) {
      parseObject.set(RegionEntity.uf, model.uf);
    }
    if (model.city != null) {
      parseObject.set(RegionEntity.city, model.city);
    }
    if (model.name != null) {
      parseObject.set(RegionEntity.name, model.name);
    }

    return parseObject;
  }
}
