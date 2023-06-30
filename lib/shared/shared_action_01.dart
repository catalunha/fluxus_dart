import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'entity/shared_b4a.dart';
import 'entity/shared_entity.dart';

void sharedAction01() async {
  print('sharedAction01...');
  SharedB4a sharedB4a = SharedB4a();
  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(SharedEntity.className));

  final list = await sharedB4a.list(query, cols: {
    '${SharedEntity.className}.cols': [
      SharedEntity.professional,
      SharedEntity.patient,
      SharedEntity.description,
      SharedEntity.document,
      SharedEntity.isPublic,
    ],
    '${SharedEntity.className}.pointers': [
      SharedEntity.professional,
      SharedEntity.patient,
    ],
  });

  for (var element in list) {
    print(element.id);
  }
}
