import 'dart:io';

import 'package:intl/intl.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../user_profile/entity/user_profile_b4a.dart';
import '../user_profile/entity/user_profile_entity.dart';

void userProfileAction01() async {
  print('+++ userProfileAction01...');
  UserProfileB4a userProfileB4a = UserProfileB4a();

  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(UserProfileEntity.className));
  // query.whereEqualTo(
  //     UserProfileEntity.expertises,
  //     (ParseObject(ExpertiseEntity.className)..objectId = 'AwfAwREwOR')
  //         .toPointer());

  final list = await userProfileB4a.list(query, cols: {
    '${UserProfileEntity.className}.cols': [
      UserProfileEntity.email,
      UserProfileEntity.userName,
      UserProfileEntity.isActive,
      UserProfileEntity.access,
      UserProfileEntity.name,
      UserProfileEntity.nickname,
      UserProfileEntity.phone,
      UserProfileEntity.address,
      UserProfileEntity.cpf,
      UserProfileEntity.register,
      UserProfileEntity.isFemale,
      UserProfileEntity.birthday,
      // UserProfileEntity.photo,
      // UserProfileEntity.offices,
      // UserProfileEntity.expertises,
      // UserProfileEntity.procedures,
    ]
  });
  final dateFormat = DateFormat('y-MM-dd HH:mm:ss');
  var userProfileFile =
      File('data/user_profile.txt').openWrite(mode: FileMode.write);

  for (var prof in list) {
    userProfileFile.writeln(
        "update user_profile set name='${prof.name}',nickname ='${prof.nickname}',phone='${prof.phone}',is_active=${prof.isActive},address='${prof.address}',cpf='${prof.cpf}',register='${prof.register}',is_female=${prof.isFemale},birthday='${prof.birthday != null ? dateFormat.format(prof.birthday!) : null}' where email='${prof.email}'"
            .replaceAll("'null'", 'null')
            .replaceAll("''", 'null'));
  }
  userProfileFile.close();
  print('--- userProfileAction01.');
}
