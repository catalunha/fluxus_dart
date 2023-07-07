import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../utils/pagination.dart';
import '../model/attendance_model.dart';
import 'attendance_entity.dart';

class AttendanceB4a {
  Future<List<AttendanceModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    query.setLimit(500);
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${AttendanceEntity.className}.cols')) {
      query.keysToReturn(cols['${AttendanceEntity.className}.cols']!);
    }
    if (cols.containsKey('${AttendanceEntity.className}.pointers')) {
      query.includeObject(cols['${AttendanceEntity.className}.pointers']!);
    }
    //  else {
    //   query.includeObject([
    //     'professional',
    //     'professional.region',
    //     'procedure',
    //     'procedure.expertise',
    //     'patient',
    //     'patient.region',
    //     'healthPlan',
    //     'healthPlan.healthPlanType',
    //     'status',
    //   ]);
    // }
    ParseResponse? parseResponse;
    try {
      parseResponse = await query.query();
      final List<AttendanceModel> listTemp = <AttendanceModel>[];
      if (parseResponse.success && parseResponse.results != null) {
        for (var element in parseResponse.results!) {
          listTemp.add(await AttendanceEntity().toModel(element, cols: cols));
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

  Future<AttendanceModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    final QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
    query.whereEqualTo(AttendanceEntity.id, id);

    if (cols.containsKey('${AttendanceEntity.className}.cols')) {
      query.keysToReturn(cols['${AttendanceEntity.className}.cols']!);
    }
    if (cols.containsKey('${AttendanceEntity.className}.pointers')) {
      query.includeObject(cols['${AttendanceEntity.className}.pointers']!);
    } else {
      query.includeObject([
        'professional',
        'professional.region',
        'procedure',
        'procedure.expertise',
        'patient',
        'patient.region',
        'healthPlan',
        'healthPlan.healthPlanType',
        'status',
      ]);
    }
    query.first();
    try {
      final response = await query.query();

      if (response.success && response.results != null) {
        return AttendanceEntity().toModel(response.results!.first, cols: cols);
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
    return null;
  }

  Future<String> update(AttendanceModel model) async {
    final parseObject = await AttendanceEntity().toParse(model);
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
    final parseObject = ParseObject(AttendanceEntity.className);
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

  Future<bool> confirmPresence(String modelId) async {
    ParseResponse? parseResponse;
    try {
      final parseObject = ParseObject(AttendanceEntity.className);
      parseObject.objectId = modelId;
      parseObject.set<DateTime?>(
          AttendanceEntity.confirmedPresence, DateTime.now());

      parseResponse = await parseObject.save();
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

  Future<bool> unConfirmPresence(String modelId) async {
    ParseResponse? parseResponse;
    try {
      final parseObject = ParseObject(AttendanceEntity.className);
      parseObject.objectId = modelId;
      parseObject.unset(AttendanceEntity.confirmedPresence);

      parseResponse = await parseObject.save();
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
