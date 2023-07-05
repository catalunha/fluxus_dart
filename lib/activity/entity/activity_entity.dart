import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../expertise/entity/expertise_entity.dart';
import '../../expertise/model/expertise_model.dart';
import '../model/activity_model.dart';

class ActivityEntity {
  static const String className = 'Activity';
  // Nome do campo App =  no Database
  static const String id = 'objectId';
  static const String name = 'name';
  static const String expertises = 'expertises';

  Future<ActivityModel> toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) async {
    //+++ get expertise
    final List<ExpertiseModel> expertiseList = [];

    if (cols.containsKey('${ActivityEntity.className}.cols') &&
        cols['${ActivityEntity.className}.cols']!
            .contains(ActivityEntity.expertises)) {
      final QueryBuilder<ParseObject> queryExpertise =
          QueryBuilder<ParseObject>(ParseObject(ExpertiseEntity.className));
      queryExpertise.whereRelatedTo(ActivityEntity.expertises,
          ActivityEntity.className, parseObject.objectId!);
      final ParseResponse parseResponse = await queryExpertise.query();
      if (parseResponse.success && parseResponse.results != null) {
        for (var e in parseResponse.results!) {
          expertiseList.add(ExpertiseEntity().toModel(e as ParseObject));
        }
      }
    }

    //--- get expertise
    final ActivityModel model = ActivityModel(
      id: parseObject.objectId!,
      name: parseObject.get(ActivityEntity.name),
      expertises: expertiseList,
    );
    return model;
  }

  Future<ParseObject> toParse(ActivityModel model) async {
    final parseObject = ParseObject(ActivityEntity.className);
    parseObject.objectId = model.id;

    parseObject.set(ActivityEntity.name, model.name);

    return parseObject;
  }

  ParseObject? toParseRelation({
    required String objectId,
    required String relationColumn,
    required String relationTable,
    required List<String> ids,
    required bool add,
  }) {
    final parseObject = ParseObject(ActivityEntity.className);
    parseObject.objectId = objectId;
    if (ids.isEmpty) {
      parseObject.unset(relationColumn);
      return parseObject;
    }
    if (add) {
      parseObject.addRelation(
        relationColumn,
        ids
            .map(
              (element) => ParseObject(relationTable)..objectId = element,
            )
            .toList(),
      );
    } else {
      parseObject.removeRelation(
          relationColumn,
          ids
              .map((element) => ParseObject(relationTable)..objectId = element)
              .toList());
    }
    return parseObject;
  }
}
