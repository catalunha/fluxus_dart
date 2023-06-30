import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../utils/pagination.dart';
import '../entity/user_profile_entity.dart';
import '../model/user_profile_model.dart';

class UserProfileB4a {
  Future<List<UserProfileModel>> list(
    QueryBuilder<ParseObject> query, {
    Pagination? pagination,
    Map<String, List<String>> cols = const {},
  }) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    if (cols.containsKey('${UserProfileEntity.className}.cols')) {
      query.keysToReturn(cols['${UserProfileEntity.className}.cols']!);
    }
    if (cols.containsKey('${UserProfileEntity.className}.pointers')) {
      query.includeObject(cols['${UserProfileEntity.className}.pointers']!);
    }

    ParseResponse? response;
    try {
      response = await query.query();
      final List<UserProfileModel> listTemp = <UserProfileModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(await UserProfileEntity().toModel(element, cols: cols));
        }
        return listTemp;
      } else {
        return [];
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }

  Future<UserProfileModel?> readById(
    String id, {
    Map<String, List<String>> cols = const {},
  }) async {
    final QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(UserProfileEntity.className));
    query.whereEqualTo(UserProfileEntity.id, id);

    if (cols.containsKey('${UserProfileEntity.className}.cols')) {
      query.keysToReturn(cols['${UserProfileEntity.className}.cols']!);
    }
    if (cols.containsKey('${UserProfileEntity.className}.pointers')) {
      query.includeObject(cols['${UserProfileEntity.className}.pointers']!);
    } else {
      query.includeObject(['region']);
    }

    query.first();
    try {
      final response = await query.query();

      if (response.success && response.results != null) {
        return UserProfileEntity().toModel(response.results!.first, cols: cols);
      }
      return null;
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }

  Future<String> update(UserProfileModel userProfileModel) async {
    final userProfileParse =
        await UserProfileEntity().toParse(userProfileModel);
    ParseResponse? response;
    try {
      response = await userProfileParse.save();

      if (response.success && response.results != null) {
        final ParseObject userProfile = response.results!.first as ParseObject;
        return userProfile.objectId!;
      } else {
        throw Exception();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }

  Future<void> updateRelation({
    required String objectId,
    required String relationColumn,
    required String relationTable,
    required List<String> ids,
    required bool add,
  }) async {
    final parseObject = UserProfileEntity().toParseRelation(
        objectId: objectId,
        relationColumn: relationColumn,
        relationTable: relationTable,
        ids: ids,
        add: add);
    if (parseObject != null) {
      await parseObject.save();
    }
  }
/*
  Future<UserProfileModel?> readByCPF(String? value) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(UserProfileEntity.className));
    query.whereEqualTo(UserProfileEntity.cpf, value);

    query.first();
    ParseResponse? response;
    try {
      response = await query.query();

      if (response.success && response.results != null) {
        return UserProfileEntity().fromParse(response.results!.first);
      } else {
        // throw Exception();
        return null;
      }
    } on Exception {
      var errorTranslated = ParseErrorTranslate.translate(response!.error!);
      throw B4aException(
        errorTranslated,
        where: 'UserProfileRepositoryB4a.getByRegister',
        originalError: '${response.error!.code} -${response.error!.message}',
      );
    }
  }
  */
}
