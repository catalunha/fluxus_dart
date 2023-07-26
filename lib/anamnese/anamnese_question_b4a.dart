import 'dart:developer';

import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../utils/pagination.dart';
import 'anamnese_question_entity.dart';
import 'anamnese_question_model.dart';

class AnamneseQuestionB4a {
  Future<List<AnamneseQuestionModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    // if (pagination != null) {
    //   query.setAmountToSkip((pagination.page - 1) * pagination.limit);
    query.setLimit(200);
    // }
    if (cols.containsKey('${AnamneseQuestionEntity.className}.cols')) {
      query.keysToReturn(cols['${AnamneseQuestionEntity.className}.cols']!);
    }
    if (cols.containsKey('${AnamneseQuestionEntity.className}.pointers')) {
      query
          .includeObject(cols['${AnamneseQuestionEntity.className}.pointers']!);
    }
    ParseResponse? parseResponse;
    try {
      parseResponse = await query.query();
      final List<AnamneseQuestionModel> listTemp = <AnamneseQuestionModel>[];
      if (parseResponse.success && parseResponse.results != null) {
        for (var element in parseResponse.results!) {
          listTemp.add(AnamneseQuestionEntity().toModel(element));
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

  Future<AnamneseQuestionModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    final QueryBuilder<ParseObject> query = QueryBuilder<ParseObject>(
        ParseObject(AnamneseQuestionEntity.className));
    query.whereEqualTo(AnamneseQuestionEntity.id, id);

    if (cols.containsKey('${AnamneseQuestionEntity.className}.cols')) {
      query.keysToReturn(cols['${AnamneseQuestionEntity.className}.cols']!);
    }
    if (cols.containsKey('${AnamneseQuestionEntity.className}.pointers')) {
      query
          .includeObject(cols['${AnamneseQuestionEntity.className}.pointers']!);
    }
    query.first();
    try {
      final response = await query.query();

      if (response.success && response.results != null) {
        return AnamneseQuestionEntity()
            .toModel(response.results!.first, cols: cols);
      }
      return null;
    } catch (e, st) {
      log('$e');
      log('$st');
      rethrow;
    }
  }

  Future<String> save(AnamneseQuestionModel model) async {
    final parseObject = await AnamneseQuestionEntity().toParse(model);
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
    final parseObject = ParseObject(AnamneseQuestionEntity.className);
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
