import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'anamnese_group_model.dart';

class AnamneseGroupEntity {
  static const String className = 'AnamneseGroup';
  static const String id = 'objectId';
  static const String name = 'name';
  static const String description = 'description';
  static const String orderOfQuestions = 'orderOfQuestions';
  static const String isActive = 'isActive';

  AnamneseGroupModel toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) {
    final AnamneseGroupModel model = AnamneseGroupModel(
      id: parseObject.objectId!,
      name: parseObject.get(AnamneseGroupEntity.name),
      orderOfQuestions: parseObject
                  .get<List<dynamic>>(AnamneseGroupEntity.orderOfQuestions) !=
              null
          ? parseObject
              .get<List<dynamic>>(AnamneseGroupEntity.orderOfQuestions)!
              .map((e) => e.toString())
              .toList()
          : [],
      isActive: parseObject.get(AnamneseGroupEntity.isActive) ?? true,
    );
    return model;
  }

  Future<ParseObject> toParse(AnamneseGroupModel model) async {
    final parseObject = ParseObject(AnamneseGroupEntity.className);
    parseObject.objectId = model.id;

    parseObject.set(AnamneseGroupEntity.name, model.name);

    parseObject.set(AnamneseGroupEntity.isActive, model.isActive);
    parseObject.set(
        AnamneseGroupEntity.orderOfQuestions, model.orderOfQuestions);
    return parseObject;
  }
}
