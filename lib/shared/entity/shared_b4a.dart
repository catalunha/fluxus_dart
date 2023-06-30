import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../utils/pagination.dart';
import '../model/shared_model.dart';
import 'shared_entity.dart';

class SharedB4a {
  Future<List<SharedModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${SharedEntity.className}.cols')) {
      query.keysToReturn(cols['${SharedEntity.className}.cols']!);
    }
    if (cols.containsKey('${SharedEntity.className}.pointers')) {
      query.includeObject(cols['${SharedEntity.className}.pointers']!);
    }
    ParseResponse? parseResponse;
    try {
      parseResponse = await query.query();
      final List<SharedModel> listTemp = <SharedModel>[];
      if (parseResponse.success && parseResponse.results != null) {
        for (var element in parseResponse.results!) {
          listTemp.add(await SharedEntity().toModel(element, cols: cols));
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

  Future<SharedModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    final QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(SharedEntity.className));
    query.whereEqualTo(SharedEntity.id, id);

    if (cols.containsKey('${SharedEntity.className}.cols')) {
      query.keysToReturn(cols['${SharedEntity.className}.cols']!);
    }
    if (cols.containsKey('${SharedEntity.className}.pointers')) {
      query.includeObject(cols['${SharedEntity.className}.pointers']!);
    }
    query.first();
    try {
      final response = await query.query();

      if (response.success && response.results != null) {
        return SharedEntity().toModel(response.results!.first, cols: cols);
      }
    } catch (e, st) {
      print(e);
      print(st);
    }
    return null;
  }

  Future<String> update(SharedModel model) async {
    final parseObject = await SharedEntity().toParse(model);
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
    final parseObject = ParseObject(SharedEntity.className);
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
