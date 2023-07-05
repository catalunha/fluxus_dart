import 'package:fluxus_dart/therapy/entity/therapy_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'entity/therapy_b4a.dart';

void therapyAction01() async {
  print('+++ therapyAction01...');
  TherapyB4a therapyB4a = TherapyB4a();
  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(TherapyEntity.className));
  final list = await therapyB4a.list(query, cols: {
    '${TherapyEntity.className}.cols': [
      TherapyEntity.dtStart,
      TherapyEntity.dtEnd,
      TherapyEntity.activity,
      TherapyEntity.room,
      TherapyEntity.capacity,
      TherapyEntity.professionals,
      TherapyEntity.patientHealthPlans,
      TherapyEntity.status,
      TherapyEntity.history,
    ],
    '${TherapyEntity.className}.pointers': [
      TherapyEntity.activity,
      TherapyEntity.room,
    ],
  });
  for (var element in list) {
    print(element.id);
    print(element);
  }

  print('--- therapyAction01...');
}
