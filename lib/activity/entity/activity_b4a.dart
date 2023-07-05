import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../utils/pagination.dart';
import '../model/activity_model.dart';
import 'activity_entity.dart';

class ActivityB4a {
  Future<List<ActivityModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${ActivityEntity.className}.cols')) {
      query.keysToReturn(cols['${ActivityEntity.className}.cols']!);
    }
    if (cols.containsKey('${ActivityEntity.className}.pointers')) {
      query.includeObject(cols['${ActivityEntity.className}.pointers']!);
    }

    ParseResponse? response;
    try {
      response = await query.query();
      final List<ActivityModel> listTemp = <ActivityModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(await ActivityEntity().toModel(element, cols: cols));
        }
        return listTemp;
      } else {
        return [];
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }

  Future<ActivityModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    final QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(ActivityEntity.className));
    query.whereEqualTo(ActivityEntity.id, id);

    if (cols.containsKey('${ActivityEntity.className}.cols')) {
      query.keysToReturn(cols['${ActivityEntity.className}.cols']!);
    }
    if (cols.containsKey('${ActivityEntity.className}.pointers')) {
      query.includeObject(cols['${ActivityEntity.className}.pointers']!);
    } else {
      query.includeObject(['region']);
    }

    query.first();
    try {
      final response = await query.query();

      if (response.success && response.results != null) {
        return ActivityEntity().toModel(response.results!.first, cols: cols);
      }
      return null;
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }

  Future<String> update(ActivityModel model) async {
    final parseObject = await ActivityEntity().toParse(model);
    ParseResponse? response;
    try {
      response = await parseObject.save();

      if (response.success && response.results != null) {
        final ParseObject parseObject = response.results!.first as ParseObject;
        return parseObject.objectId!;
      } else {
        throw Exception();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }

  Future<void> updateRelation({
    required String objectId,
    required String relationColumn,
    required String relationTable,
    required List<String> ids,
    required bool add,
  }) async {
    final parseObject = ActivityEntity().toParseRelation(
        objectId: objectId,
        relationColumn: relationColumn,
        relationTable: relationTable,
        ids: ids,
        add: add);
    if (parseObject != null) {
      await parseObject.save();
    }
  }
}
