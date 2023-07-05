import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../utils/pagination.dart';
import '../model/therapy_model.dart';
import 'therapy_entity.dart';

class TherapyB4a {
  Future<List<TherapyModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${TherapyEntity.className}.cols')) {
      query.keysToReturn(cols['${TherapyEntity.className}.cols']!);
    }
    if (cols.containsKey('${TherapyEntity.className}.pointers')) {
      query.includeObject(cols['${TherapyEntity.className}.pointers']!);
    }

    ParseResponse? response;
    try {
      response = await query.query();
      final List<TherapyModel> listTemp = <TherapyModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(await TherapyEntity().toModel(element, cols: cols));
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

  Future<TherapyModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    final QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(TherapyEntity.className));
    query.whereEqualTo(TherapyEntity.id, id);

    if (cols.containsKey('${TherapyEntity.className}.cols')) {
      query.keysToReturn(cols['${TherapyEntity.className}.cols']!);
    }
    if (cols.containsKey('${TherapyEntity.className}.pointers')) {
      query.includeObject(cols['${TherapyEntity.className}.pointers']!);
    } else {
      query.includeObject(['region']);
    }

    query.first();
    try {
      final response = await query.query();

      if (response.success && response.results != null) {
        return TherapyEntity().toModel(response.results!.first, cols: cols);
      }
      return null;
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }

  Future<String> update(TherapyModel model) async {
    final parseObject = await TherapyEntity().toParse(model);
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
    final parseObject = TherapyEntity().toParseRelation(
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
