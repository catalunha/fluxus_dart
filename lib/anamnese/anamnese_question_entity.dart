import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'anamnese_group_entity.dart';
import 'anamnese_question_model.dart';

class AnamneseQuestionEntity {
  static const String className = 'AnamneseQuestion';
  static const String id = 'objectId';
  static const String text = 'text';
  static const String type = 'type';
  static const String options = 'options';
  static const String isRequired = 'isRequired';
  static const String group = 'group';
  static const String isActive = 'isActive';

  AnamneseQuestionModel toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) {
    final AnamneseQuestionModel model = AnamneseQuestionModel(
      id: parseObject.objectId!,
      text: parseObject.get(AnamneseQuestionEntity.text),
      type: parseObject.get(AnamneseQuestionEntity.type),
      options:
          parseObject.get<List<dynamic>>(AnamneseQuestionEntity.options) != null
              ? parseObject
                  .get<List<dynamic>>(AnamneseQuestionEntity.options)!
                  .map((e) => e.toString())
                  .toList()
              : [],
      isRequired: parseObject.get<bool>(AnamneseQuestionEntity.isRequired,
          defaultValue: false)!,
      group: AnamneseGroupEntity()
          .toModel(parseObject.get(AnamneseQuestionEntity.group), cols: cols),
      isActive: parseObject.get<bool>(AnamneseQuestionEntity.isActive,
          defaultValue: true)!,
    );
    return model;
  }

  Future<ParseObject> toParse(AnamneseQuestionModel model) async {
    final parseObject = ParseObject(AnamneseQuestionEntity.className);
    parseObject.objectId = model.id;
    parseObject.set(
        AnamneseQuestionEntity.group,
        (ParseObject(AnamneseGroupEntity.className)..objectId = model.group.id)
            .toPointer());
    parseObject.set(AnamneseQuestionEntity.text, model.text);
    parseObject.set(AnamneseQuestionEntity.type, model.type);
    parseObject.set(AnamneseQuestionEntity.options, model.options);
    parseObject.set(AnamneseQuestionEntity.isRequired, model.isRequired);

    parseObject.set(AnamneseQuestionEntity.isActive, model.isActive);
    return parseObject;
  }
}
