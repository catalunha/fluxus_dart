import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../attendance/entity/attendance_entity.dart';
import '../../attendance/model/attendance_model.dart';
import '../../hour/entity/hour_entity.dart';
import '../../room/entity/room_entity.dart';
import '../../status/entity/status_entity.dart';
import '../model/event_model.dart';

class EventEntity {
  static const String className = 'Event';
  static const String id = 'objectId';
  static const String day = 'day';
  static const String hour = 'hour';
  static const String room = 'room';
  static const String status = 'status';
  static const String attendances = 'attendances';
  static const String history = 'history';

  Future<EventModel> toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) async {
    //+++ get attendance
    final List<AttendanceModel> attendanceList = [];
    if (cols.containsKey('${EventEntity.className}.cols') &&
        cols['${EventEntity.className}.cols']!
            .contains(EventEntity.attendances)) {
      final QueryBuilder<ParseObject> queryAttendanceType =
          QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
      queryAttendanceType.whereRelatedTo(EventEntity.attendances,
          EventEntity.className, parseObject.objectId!);
      queryAttendanceType.includeObject([
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
      final ParseResponse parseResponse = await queryAttendanceType.query();
      if (parseResponse.success && parseResponse.results != null) {
        for (var e in parseResponse.results!) {
          attendanceList.add(
              await AttendanceEntity().toModel(e as ParseObject, cols: cols));
        }
      }
    }
    //--- get attendance

    final EventModel model = EventModel(
      id: parseObject.objectId!,
      day: parseObject.get<DateTime>(EventEntity.day)?.toLocal(),
      hour: parseObject.get(EventEntity.hour) != null
          ? HourEntity().toModel(parseObject.get(EventEntity.hour))
          : null,
      room: parseObject.get(EventEntity.room) != null
          ? RoomEntity().toModel(parseObject.get(EventEntity.room))
          : null,
      attendances: attendanceList,
      status: parseObject.get(EventEntity.status) != null
          ? StatusEntity().toModel(parseObject.get(EventEntity.status))
          : null,
      history: parseObject.get(EventEntity.history),
    );
    return model;
  }

  Future<ParseObject> toParse(EventModel model) async {
    final parseObject = ParseObject(EventEntity.className);
    parseObject.objectId = model.id;

    if (model.day != null) {
      parseObject.set<DateTime?>(EventEntity.day,
          DateTime(model.day!.year, model.day!.month, model.day!.day));
    }
    if (model.hour != null) {
      parseObject.set(
          EventEntity.hour,
          (ParseObject(HourEntity.className)..objectId = model.hour!.id)
              .toPointer());
    }
    if (model.room != null) {
      parseObject.set(
          EventEntity.room,
          (ParseObject(RoomEntity.className)..objectId = model.room!.id)
              .toPointer());
    }
    if (model.status != null) {
      parseObject.set(
          EventEntity.status,
          (ParseObject(StatusEntity.className)..objectId = model.status!.id)
              .toPointer());
    }
    if (model.history != null) {
      parseObject.set(EventEntity.history, model.history);
    }
    return parseObject;
  }

  ParseObject? toParseRelation({
    required String objectId,
    required String relationColumn,
    required String relationTable,
    required List<String> ids,
    required bool add,
  }) {
    final parseObject = ParseObject(EventEntity.className);
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
