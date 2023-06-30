import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../expertise/entity/expertise_entity.dart';
import '../../expertise/model/expertise_model.dart';
import '../../office/entity/office_entity.dart';
import '../../office/model/office_model.dart';
import '../../procedure/entity/procedure_entity.dart';
import '../../procedure/model/procedure_model.dart';
import '../../region/entity/region_entity.dart';
import '../model/user_profile_model.dart';

class UserProfileEntity {
  static const String className = 'UserProfile';

  static const String id = 'objectId';
  static const String userName = 'userName';
  static const String email = 'email';
  static const String access = 'access';
  static const String isActive = 'isActive';

  static const String nickname = 'nickname';
  static const String name = 'name';
  static const String cpf = 'cpf';
  static const String register = 'register';
  static const String phone = 'phone';
  static const String photo = 'photo';
  static const String isFemale = 'isFemale';
  static const String birthday = 'birthday';
  static const String address = 'address';

  static const String region = 'region';

  static const String offices = 'offices';
  static const String expertises = 'expertises';
  static const String procedures = 'procedures';

  Future<UserProfileModel> toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) async {
    //+++ get office
    final List<OfficeModel> officeList = [];
    if (cols.containsKey('${UserProfileEntity.className}.cols') &&
        cols['${UserProfileEntity.className}.cols']!
            .contains(UserProfileEntity.offices)) {
      final QueryBuilder<ParseObject> queryOffice =
          QueryBuilder<ParseObject>(ParseObject(OfficeEntity.className));
      queryOffice.whereRelatedTo(UserProfileEntity.offices,
          UserProfileEntity.className, parseObject.objectId!);
      final ParseResponse parseResponse = await queryOffice.query();
      if (parseResponse.success && parseResponse.results != null) {
        for (var e in parseResponse.results!) {
          officeList.add(OfficeEntity().toModel(e as ParseObject));
        }
      }
    }

    //--- get office
    //+++ get expertise
    final List<ExpertiseModel> expertiseList = [];

    if (cols.containsKey('${UserProfileEntity.className}.cols') &&
        cols['${UserProfileEntity.className}.cols']!
            .contains(UserProfileEntity.expertises)) {
      final QueryBuilder<ParseObject> queryExpertise =
          QueryBuilder<ParseObject>(ParseObject(ExpertiseEntity.className));
      queryExpertise.whereRelatedTo(UserProfileEntity.expertises,
          UserProfileEntity.className, parseObject.objectId!);
      final ParseResponse parseResponse = await queryExpertise.query();
      if (parseResponse.success && parseResponse.results != null) {
        for (var e in parseResponse.results!) {
          expertiseList.add(ExpertiseEntity().toModel(e as ParseObject));
        }
      }
    }

    //--- get expertise
    //+++ get procedure
    final List<ProcedureModel> procedureList = [];

    if (cols.containsKey('${UserProfileEntity.className}.cols') &&
        cols['${UserProfileEntity.className}.cols']!
            .contains(UserProfileEntity.procedures)) {
      final QueryBuilder<ParseObject> queryProcedure =
          QueryBuilder<ParseObject>(ParseObject(ProcedureEntity.className));
      queryProcedure.whereRelatedTo(UserProfileEntity.procedures,
          UserProfileEntity.className, parseObject.objectId!);
      queryProcedure.includeObject(['expertise']);
      final ParseResponse parseResponse = await queryProcedure.query();
      if (parseResponse.success && parseResponse.results != null) {
        for (var e in parseResponse.results!) {
          procedureList.add(ProcedureEntity().toModel(e as ParseObject));
        }
      }
    }

    //--- get procedure
    final UserProfileModel model = UserProfileModel(
      id: parseObject.objectId!,
      userName: parseObject.get(UserProfileEntity.userName),
      email: parseObject.get(UserProfileEntity.email),
      nickname: parseObject.get(UserProfileEntity.nickname),
      name: parseObject.get(UserProfileEntity.name),
      cpf: parseObject.get(UserProfileEntity.cpf),
      register: parseObject.get(UserProfileEntity.register),
      phone: parseObject.get(UserProfileEntity.phone),
      address: parseObject.get(UserProfileEntity.address),
      photo: parseObject.get(UserProfileEntity.photo)?.get('url'),
      isFemale: parseObject.get(UserProfileEntity.isFemale),
      isActive: parseObject.get(UserProfileEntity.isActive),
      birthday:
          parseObject.get<DateTime>(UserProfileEntity.birthday)?.toLocal(),
      access: parseObject.get<List<dynamic>>(UserProfileEntity.access) != null
          ? parseObject
              .get<List<dynamic>>(UserProfileEntity.access)!
              .map((e) => e.toString())
              .toList()
          : [],
      region: parseObject.containsKey(UserProfileEntity.region) &&
              parseObject.get(UserProfileEntity.region) != null
          ? RegionEntity().toModel(parseObject.get(UserProfileEntity.region))
          : null,
      offices: officeList,
      expertises: expertiseList,
      procedures: procedureList,
    );
    return model;
  }

  Future<ParseObject> toParse(UserProfileModel model) async {
    final parseObject = ParseObject(UserProfileEntity.className);
    parseObject.objectId = model.id;

    if (model.nickname != null) {
      parseObject.set(UserProfileEntity.nickname, model.nickname);
    }
    if (model.name != null) {
      parseObject.set(UserProfileEntity.name, model.name);
    }
    if (model.cpf != null) {
      parseObject.set(UserProfileEntity.cpf, model.cpf);
    }
    if (model.register != null) {
      parseObject.set(UserProfileEntity.register, model.register);
    }

    if (model.phone != null) {
      parseObject.set(UserProfileEntity.phone, model.phone);
    }
    if (model.address != null) {
      parseObject.set(UserProfileEntity.address, model.address);
    }

    if (model.isFemale != null) {
      parseObject.set(UserProfileEntity.isFemale, model.isFemale);
    }

    if (model.birthday != null) {
      parseObject.set<DateTime?>(
          UserProfileEntity.birthday,
          DateTime(model.birthday!.year, model.birthday!.month,
              model.birthday!.day));
    }
    if (model.region != null) {
      parseObject.set(
          UserProfileEntity.region,
          (ParseObject(RegionEntity.className)..objectId = model.region!.id)
              .toPointer());
    }
    parseObject.set(UserProfileEntity.access, model.access);

    parseObject.set(UserProfileEntity.isActive, model.isActive);
    return parseObject;
  }

  ParseObject? toParseRelation({
    required String objectId,
    required String relationColumn,
    required String relationTable,
    required List<String> ids,
    required bool add,
  }) {
    final parseObject = ParseObject(UserProfileEntity.className);
    parseObject.objectId = objectId;
    if (ids.isEmpty) {
      parseObject.unset(relationColumn);
      return parseObject;
    }
    if (add) {
      parseObject.addRelation(
        relationColumn,
        ids
            .map(
              (element) => ParseObject(relationTable)..objectId = element,
            )
            .toList(),
      );
    } else {
      parseObject.removeRelation(
          relationColumn,
          ids
              .map((element) => ParseObject(relationTable)..objectId = element)
              .toList());
    }
    return parseObject;
  }
}
