import 'dart:developer';

import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../utils/pagination.dart';
import '../model/event_model.dart';
import 'event_entity.dart';

class EventB4a {
  Future<List<EventModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${EventEntity.className}.cols')) {
      query.keysToReturn(cols['${EventEntity.className}.cols']!);
    }
    if (cols.containsKey('${EventEntity.className}.pointers')) {
      query.includeObject(cols['${EventEntity.className}.pointers']!);
    } else {
      query.includeObject([
        EventEntity.hour,
        EventEntity.room,
        EventEntity.status,
      ]);
    }

    ParseResponse? response;
    try {
      response = await query.query();
      final List<EventModel> listTemp = <EventModel>[];
      if (response.success && response.results != null) {
        log('EventB4a list length: ${response.results?.length}');
        for (var element in response.results!) {
          listTemp.add(await EventEntity().toModel(element, cols: cols));
        }
        return listTemp;
      } else {
        log('EventB4a list empty...');
        log('${response.count}');
        log('${response.error?.message}');
        return [];
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }

  Future<EventModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    final QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
    query.whereEqualTo(EventEntity.id, id);
    if (cols.containsKey('${EventEntity.className}.cols')) {
      query.keysToReturn(cols['${EventEntity.className}.cols']!);
    }
    if (cols.containsKey('${EventEntity.className}.pointers')) {
      query.includeObject(cols['${EventEntity.className}.pointers']!);
    } else {
      query.includeObject([
        EventEntity.hour,
        EventEntity.room,
        EventEntity.status,
      ]);
    }
    query.first();
    try {
      final response = await query.query();

      if (response.success && response.results != null) {
        return EventEntity().toModel(response.results!.first, cols: cols);
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
    return null;
  }

  Future<String> update(EventModel userProfileModel) async {
    final userProfileParse = await EventEntity().toParse(userProfileModel);
    ParseResponse? response;
    try {
      response = await userProfileParse.save();

      if (response.success && response.results != null) {
        final ParseObject userProfile = response.results!.first as ParseObject;
        return userProfile.objectId!;
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
    final parseObject = EventEntity().toParseRelation(
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
