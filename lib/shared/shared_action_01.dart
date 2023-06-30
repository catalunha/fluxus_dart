import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../expertise/entity/expertise_entity.dart';
import '../user_profile/entity/user_profile_entity.dart';
import 'entity/shared_b4a.dart';
import 'entity/shared_entity.dart';

/*
UserProfile | Expertise
FIJcqwpoKf | ksAHYb3CGr
w3meVgSg3b | AwfAwREwOR
*/

void sharedAction01() async {
  print('+++ sharedAction01...');
  SharedB4a sharedB4a = SharedB4a();
  // final QueryBuilder<ParseObject> query =
  //     QueryBuilder<ParseObject>(ParseObject(SharedEntity.className));
  // query.whereEqualTo(
  //     SharedEntity.patient,
  //     (ParseObject(PatientEntity.className)..objectId = 'OBOTuOFOhn')
  //         .toPointer());
  // query.whereEqualTo(
  //     'professional',
  //     (ParseObject(ExpertiseEntity.className)..objectId = 'AwfAwREwOR')
  //         .toPointer());
  List<QueryBuilder<ParseObject>> querysShared = [];
  List<String> expertiseIds = [
    'ksAHYb3CGr',
    // 'AwfAwREwOR',
  ];
  for (var expertiseId in expertiseIds) {
    final QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(SharedEntity.className));
    final QueryBuilder<ParseObject> queryUser =
        QueryBuilder<ParseObject>(ParseObject(UserProfileEntity.className));
    queryUser.whereEqualTo(
        UserProfileEntity.expertises,
        (ParseObject(ExpertiseEntity.className)..objectId = expertiseId)
            .toPointer());

    query.whereMatchesKeyInQuery(
        SharedEntity.professional, 'objectId', queryUser);
    querysShared.add(query);
  }
  QueryBuilder<ParseObject> mainQuery = QueryBuilder.or(
    ParseObject(SharedEntity.className),
    querysShared,
  );
  final list = await sharedB4a.list(mainQuery, cols: {
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

  print('--- sharedAction01.');
}
