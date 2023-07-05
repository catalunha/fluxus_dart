import 'package:fluxus_dart/activity/entity/activity_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'entity/activity_b4a.dart';

void activityAction01() async {
  print('+++ activityAction01...');
  ActivityB4a activityB4a = ActivityB4a();
  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(ActivityEntity.className));
  final list = await activityB4a.list(query, cols: {
    '${ActivityEntity.className}.cols': [
      ActivityEntity.name,
      ActivityEntity.expertises,
    ],
  });
  for (var element in list) {
    print(element.id);
    print(element);
  }

  print('--- activityAction01...');
}
