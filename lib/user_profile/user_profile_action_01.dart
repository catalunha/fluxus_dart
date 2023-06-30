import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../expertise/entity/expertise_entity.dart';
import 'entity/user_profile_b4a.dart';
import 'entity/user_profile_entity.dart';

void userProfileAction01() async {
  print('+++ userProfileAction01...');
  UserProfileB4a userProfileB4a = UserProfileB4a();

  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(UserProfileEntity.className));
  query.whereEqualTo(
      UserProfileEntity.expertises,
      (ParseObject(ExpertiseEntity.className)..objectId = 'AwfAwREwOR')
          .toPointer());

  final list = await userProfileB4a.list(query, cols: {
    '${UserProfileEntity.className}.cols': [
      UserProfileEntity.userName,
      UserProfileEntity.email,
      UserProfileEntity.isActive,
      UserProfileEntity.access,
      UserProfileEntity.name,
      // UserProfileEntity.photo,
      // UserProfileEntity.nickname,
      // UserProfileEntity.offices,
      UserProfileEntity.expertises,
      // UserProfileEntity.procedures,
    ],
    '${UserProfileEntity.className}.pointers': [
      UserProfileEntity.region,
    ],
  });
  for (var element in list) {
    print('${element.id} ${element.name} ');
  }

  print('--- userProfileAction01.');
}
