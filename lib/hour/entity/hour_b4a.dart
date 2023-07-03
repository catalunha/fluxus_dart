import 'dart:developer';

import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../../utils/pagination.dart';
import '../model/hour_model.dart';
import 'hour_entity.dart';

class HourB4a {
  Future<List<HourModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${HourEntity.className}.cols')) {
      query.keysToReturn(cols['${HourEntity.className}.cols']!);
    }
    if (cols.containsKey('${HourEntity.className}.pointers')) {
      query.includeObject(cols['${HourEntity.className}.pointers']!);
    }
    ParseResponse? parseResponse;
    try {
      parseResponse = await query.query();
      final List<HourModel> listTemp = <HourModel>[];
      if (parseResponse.success && parseResponse.results != null) {
        for (var element in parseResponse.results!) {
          listTemp.add(HourEntity().toModel(element));
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

  Future<HourModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    final QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(HourEntity.className));
    query.whereEqualTo(HourEntity.id, id);

    if (cols.containsKey('${HourEntity.className}.cols')) {
      query.keysToReturn(cols['${HourEntity.className}.cols']!);
    }
    if (cols.containsKey('${HourEntity.className}.pointers')) {
      query.includeObject(cols['${HourEntity.className}.pointers']!);
    }

    query.first();
    try {
      final response = await query.query();

      if (response.success && response.results != null) {
        return HourEntity().toModel(response.results!.first, cols: cols);
      }
      return null;
    } catch (e, st) {
      log('$e');
      log('$st');
      rethrow;
    }
  }

  Future<String> update(HourModel model) async {
    final parseObject = await HourEntity().toParse(model);
    ParseResponse? parseResponse;
    try {
      parseResponse = await parseObject.save();

      if (parseResponse.success && parseResponse.results != null) {
        final ParseObject parseObjectItem =
            parseResponse.results!.first as ParseObject;
        return parseObjectItem.objectId!;
      } else {
        throw Exception();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }

  Future<bool> delete(String modelId) async {
    final parseObject = ParseObject(HourEntity.className);
    parseObject.objectId = modelId;
    ParseResponse? parseResponse;

    try {
      parseResponse = await parseObject.delete();
      if (parseResponse.success && parseResponse.results != null) {
        return true;
      } else {
        return false;
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }
}
