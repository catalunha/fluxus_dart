import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../attendance/entity/attendance_b4a.dart';
import '../attendance/entity/attendance_entity.dart';
import '../user_profile/entity/user_profile_entity.dart';
import 'entity/event_b4a.dart';
import 'entity/event_entity.dart';

Future<void> eventAction01() async {
  print('+++ eventAction01...');
  try {
    final QueryBuilder<ParseObject> queryAttendance =
        QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
    // final start = DateTime(2023, 06, 25);
    // final end = DateTime(2023, 06, 27);

    // queryAttendance.whereGreaterThanOrEqualsTo(
    //     AttendanceEntity.authorizationDateCreated,
    //     DateTime(start.year, start.month, start.day));
    // queryAttendance.whereLessThanOrEqualTo(
    //     AttendanceEntity.authorizationDateCreated,
    //     DateTime(end.year, end.month, end.day, 23, 59));

    queryAttendance.whereEqualTo(
        AttendanceEntity.professional,
        (ParseObject(UserProfileEntity.className)..objectId = 'hE0Ng2FSwQ')
            .toPointer());

    final list = await AttendanceB4a().list(
      queryAttendance,
      cols: {
        "${AttendanceEntity.className}.cols": [AttendanceEntity.id]
      },
    );
    for (var element in list) {
      print('${element.id}');
    }

    final QueryBuilder<ParseObject> queryEvent =
        QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
    List<QueryBuilder<ParseObject>> listQueries = [];

    for (var element in list) {
      final QueryBuilder<ParseObject> queryTemp =
          QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
      // final start = DateTime(2023, 06, 25);
      // final end = DateTime(2023, 06, 27);

      // queryTemp.whereGreaterThanOrEqualsTo(
      //     EventEntity.day, DateTime(start.year, start.month, start.day));
      // queryTemp.whereLessThanOrEqualTo(
      //     EventEntity.day, DateTime(end.year, end.month, end.day, 23, 59));

      queryTemp.whereEqualTo(
        EventEntity.attendances,
        (ParseObject(AttendanceEntity.className)..objectId = element.id)
            .toPointer(),
      );

      listQueries.add(queryTemp);
    }
    QueryBuilder<ParseObject> eventsOr = QueryBuilder.or(
      ParseObject(EventEntity.className),
      listQueries,
    );
    final start = DateTime(2023, 06, 25);
    final end = DateTime(2023, 06, 27);

    eventsOr.whereGreaterThanOrEqualsTo(
        EventEntity.day, DateTime(start.year, start.month, start.day));
    eventsOr.whereLessThanOrEqualTo(
        EventEntity.day, DateTime(end.year, end.month, end.day, 23, 59));
    eventsOr.orderByDescending('updatedAt');

    final list2 = await EventB4a().list(
      eventsOr,
    );

    for (var element in list2) {
      print('${element.id}');
    }

    /*

  final QueryBuilder<ParseObject> queryByDate =
      QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
  final start = DateTime(2023, 06, 25);
  final end = DateTime(2023, 06, 27);

  queryByDate.whereGreaterThanOrEqualsTo(
      EventEntity.day, DateTime(start.year, start.month, start.day));
  queryByDate.whereLessThanOrEqualTo(
      EventEntity.day, DateTime(end.year, end.month, end.day, 23, 59));

  List<QueryBuilder<ParseObject>> listQueries = [];
  for (var element in list) {
    final QueryBuilder<ParseObject> queryTemp =
        QueryBuilder<ParseObject>(ParseObject(EventEntity.className));

    queryTemp.whereEqualTo(
        EventEntity.attendances,
        (ParseObject(AttendanceEntity.className)..objectId = element.id)
            .toPointer());
    listQueries.add(queryTemp);
  }
  QueryBuilder<ParseObject> eventsOr = QueryBuilder.or(
    ParseObject(EventEntity.className),
    listQueries,
  );

  QueryBuilder<ParseObject> eventsAnd =
      QueryBuilder.and(ParseObject(EventEntity.className), [
    queryByDate,
    eventsOr,
  ]);


    final list2 = await EventB4a().list(
      eventsAnd,
    );

    int index = 1;
    for (var element in list2) {
      print('${index++}: ${element.id}');
    }
    */
  } catch (error, stackTrace) {
    print(error);
    print(stackTrace);
  }
  print('--- eventAction01...');
}


/*
  // query.whereEqualTo(
  //     EventEntity.attendances,
  //     (ParseObject(AttendanceEntity.className)..objectId = 'f4KXlIwQYq')
  //         .toPointer());

    // final start = DateTime(2023, 06, 25);
    // final end = DateTime(2023, 06, 27);

    // queryTemp.whereGreaterThanOrEqualsTo(
    //     EventEntity.day, DateTime(start.year, start.month, start.day));
    // queryTemp.whereLessThanOrEqualTo(
    //     EventEntity.day, DateTime(end.year, end.month, end.day, 23, 59));

/*
  final QueryBuilder<ParseObject> queryAttendance =
      QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
  queryAttendance.whereEqualTo(
      AttendanceEntity.professional,
      (ParseObject(UserProfileEntity.className)..objectId = 'hE0Ng2FSwQ')
          .toPointer());
*/

  // final QueryBuilder<ParseObject> queryAttendance =
  //     QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
  // queryAttendance.whereEqualTo(AttendanceEntity.id, 'f4KXlIwQYq');

  // query.whereMatchesKeyInQuery(
  //     EventEntity.attendances, 'objectId', queryAttendance);
  // query.whereEqualTo(
  //     EventEntity.attendances,
  //     (ParseObject(AttendanceEntity.className)..objectId = 'f4KXlIwQYq')
  //         .toPointer());

query.whereEqualTo(
EventEntity.attendances,
(ParseObject(AttendanceEntity.className)..objectId = 'f4KXlIwQYq')
    .toPointer());
*/
