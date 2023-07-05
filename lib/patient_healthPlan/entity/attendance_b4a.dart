import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../utils/pagination.dart';
import '../model/patient_healthPlan_model.dart';
import 'attendance_entity.dart';

class PatientHealthPlanB4a {
  Future<List<PatientHealthPlanModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    query.setLimit(500);
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${PatientHealthPlanEntity.className}.cols')) {
      query.keysToReturn(cols['${PatientHealthPlanEntity.className}.cols']!);
    }
    if (cols.containsKey('${PatientHealthPlanEntity.className}.pointers')) {
      query.includeObject(
          cols['${PatientHealthPlanEntity.className}.pointers']!);
    }
    ParseResponse? parseResponse;
    try {
      parseResponse = await query.query();
      final List<PatientHealthPlanModel> listTemp = <PatientHealthPlanModel>[];
      if (parseResponse.success && parseResponse.results != null) {
        for (var element in parseResponse.results!) {
          listTemp.add(
              await PatientHealthPlanEntity().toModel(element, cols: cols));
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

  Future<PatientHealthPlanModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    final QueryBuilder<ParseObject> query = QueryBuilder<ParseObject>(
        ParseObject(PatientHealthPlanEntity.className));
    query.whereEqualTo(PatientHealthPlanEntity.id, id);

    if (cols.containsKey('${PatientHealthPlanEntity.className}.cols')) {
      query.keysToReturn(cols['${PatientHealthPlanEntity.className}.cols']!);
    }
    if (cols.containsKey('${PatientHealthPlanEntity.className}.pointers')) {
      query.includeObject(
          cols['${PatientHealthPlanEntity.className}.pointers']!);
    }
    query.first();
    try {
      final response = await query.query();

      if (response.success && response.results != null) {
        return PatientHealthPlanEntity()
            .toModel(response.results!.first, cols: cols);
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
    return null;
  }

  Future<String> update(PatientHealthPlanModel model) async {
    final parseObject = await PatientHealthPlanEntity().toParse(model);
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
    final parseObject = ParseObject(PatientHealthPlanEntity.className);
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
