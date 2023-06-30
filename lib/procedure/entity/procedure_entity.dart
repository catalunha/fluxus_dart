import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../expertise/entity/expertise_entity.dart';
import '../model/procedure_model.dart';

class ProcedureEntity {
  static const String className = 'Procedure';
  // Nome do campo App =  no Database
  static const String id = 'objectId';
  static const String code = 'code';
  static const String name = 'name';
  static const String description = 'description';
  static const String cost = 'cost';
  static const String costProf = 'costProf';
  static const String expertise = 'expertise';

  ProcedureModel toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) {
    final ProcedureModel model = ProcedureModel(
      id: parseObject.objectId!,
      code: parseObject.get(ProcedureEntity.code),
      name: parseObject.get(ProcedureEntity.name),
      description: parseObject.get(ProcedureEntity.description),
      cost: parseObject.get(ProcedureEntity.cost)?.toDouble(),
      costProf: parseObject.get(ProcedureEntity.costProf)?.toDouble(),
      expertise: parseObject.get(ProcedureEntity.expertise) != null
          ? ExpertiseEntity()
              .toModel(parseObject.get(ProcedureEntity.expertise))
          : null,
    );
    return model;
  }

  Future<ParseObject> toParse(ProcedureModel model) async {
    final parseObject = ParseObject(ProcedureEntity.className);
    parseObject.objectId = model.id;

    if (model.code != null) {
      parseObject.set(ProcedureEntity.code, model.code);
    }
    if (model.name != null) {
      parseObject.set(ProcedureEntity.name, model.name);
    }
    if (model.description != null) {
      parseObject.set(ProcedureEntity.description, model.description);
    }
    if (model.cost != null) {
      parseObject.set(ProcedureEntity.cost, model.cost);
    }
    if (model.costProf != null) {
      parseObject.set(ProcedureEntity.costProf, model.costProf);
    }
    if (model.expertise != null) {
      parseObject.set(
          ProcedureEntity.expertise,
          (ParseObject(ExpertiseEntity.className)
                ..objectId = model.expertise!.id)
              .toPointer());
    }
    return parseObject;
  }
}
