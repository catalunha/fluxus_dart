import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../user_profile/entity/user_profile_entity.dart';
import 'entity/attendance_b4a.dart';
import 'entity/attendance_entity.dart';

Future<void> attendanceAction01() async {
  print('+++ attendanceAction01...');
  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
  final start = DateTime(2023, 06, 25);
  final end = DateTime(2023, 06, 27);

  query.whereGreaterThanOrEqualsTo(AttendanceEntity.authorizationDateCreated,
      DateTime(start.year, start.month, start.day));
  query.whereLessThanOrEqualTo(AttendanceEntity.authorizationDateCreated,
      DateTime(end.year, end.month, end.day, 23, 59));

  query.whereEqualTo(
      AttendanceEntity.professional,
      (ParseObject(UserProfileEntity.className)..objectId = 'hE0Ng2FSwQ')
          .toPointer());

  final list = await AttendanceB4a().list(query, cols: {
    "${AttendanceEntity.className}.cols": [AttendanceEntity.id]
  });
  int index = 1;
  for (var element in list) {
    print('${index++}: ${element.id}');
    print('$element');
  }
  print('--- attendanceAction01...');
}
