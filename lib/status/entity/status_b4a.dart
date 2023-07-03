import 'dart:developer';

import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../utils/pagination.dart';
import '../model/status_model.dart';
import 'status_entity.dart';

class StatusB4a {
  Future<List<StatusModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${StatusEntity.className}.cols')) {
      query.keysToReturn(cols['${StatusEntity.className}.cols']!);
    }
    if (cols.containsKey('${StatusEntity.className}.pointers')) {
      query.includeObject(cols['${StatusEntity.className}.pointers']!);
    }
    ParseResponse? parseResponse;
    try {
      parseResponse = await query.query();
      final List<StatusModel> listTemp = <StatusModel>[];
      if (parseResponse.success && parseResponse.results != null) {
        for (var element in parseResponse.results!) {
          listTemp.add(StatusEntity().toModel(element));
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

  Future<StatusModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    final QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(StatusEntity.className));
    query.whereEqualTo(StatusEntity.id, id);

    if (cols.containsKey('${StatusEntity.className}.cols')) {
      query.keysToReturn(cols['${StatusEntity.className}.cols']!);
    }
    if (cols.containsKey('${StatusEntity.className}.pointers')) {
      query.includeObject(cols['${StatusEntity.className}.pointers']!);
    }

    query.first();
    try {
      final response = await query.query();

      if (response.success && response.results != null) {
        return StatusEntity().toModel(response.results!.first, cols: cols);
      }
      return null;
    } catch (e, st) {
      log('$e');
      log('$st');
      rethrow;
    }
  }

  Future<String> update(StatusModel model) async {
    final parseObject = await StatusEntity().toParse(model);
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
    final parseObject = ParseObject(StatusEntity.className);
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
