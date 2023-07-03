import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'entity/event_b4a.dart';
import 'entity/event_entity.dart';

Future<void> eventAction01() async {
  print('+++ eventAction01...');
  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
  final start = DateTime(2023, 06, 25);
  final end = DateTime(2023, 06, 27);

  query.whereGreaterThanOrEqualsTo(
      EventEntity.day, DateTime(start.year, start.month, start.day));
  query.whereLessThanOrEqualTo(
      EventEntity.day, DateTime(end.year, end.month, end.day, 23, 59));

/*
  final QueryBuilder<ParseObject> queryAttendance =
      QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
  queryAttendance.whereEqualTo(
      AttendanceEntity.professional,
      (ParseObject(UserProfileEntity.className)..objectId = 'hE0Ng2FSwQ')
          .toPointer());
  query.whereMatchesQuery(EventEntity.attendances, queryAttendance);
*/
/*
  final QueryBuilder<ParseObject> queryAttendance =
      QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
  queryAttendance.whereEqualTo(
      AttendanceEntity.professional,
      (ParseObject(UserProfileEntity.className)..objectId = 'hE0Ng2FSwQ')
          .toPointer());
  query.whereMatchesKeyInQuery(
      EventEntity.attendances, 'objectId', queryAttendance);

*/
/*

query.whereEqualTo(
EventEntity.attendances,
(ParseObject(AttendanceEntity.className)..objectId = 'f4KXlIwQYq')
    .toPointer());
    */

  final list = await EventB4a().list(
    query,
  );
  int index = 1;
  for (var element in list) {
    print('${index++}: ${element.id}');
  }
  print('--- eventAction01...');
}
