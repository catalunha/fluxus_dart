import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../healthPlan/entity/healthplan_entity.dart';
import '../../healthPlan/model/healthplan_model.dart';
import '../../region/entity/region_entity.dart';
import '../model/patient_model.dart';

class PatientEntity {
  // static const String className = 'Profile';
  static const String className = 'Patient';
  //SingleCols
  static const String id = 'objectId';
  static const String name = 'name';
  static const String email = 'email';
  static const String nickname = 'nickname';
  static const String cpf = 'cpf';
  static const String phone = 'phone';
  static const String isFemale = 'isFemale';
  static const String birthday = 'birthday';
  static const String address = 'address';
  static const String cep = 'cep';
  //PointerCols
  static const String region = 'region';
  //RelationCols
  static const String family = 'family';
  // static const String healthPlans = 'healthPlan';
  static const String healthPlans = 'healthPlans';

  Future<PatientModel> toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) async {
    //+++ get family
    List<PatientModel> familyList = [];
    if (cols.containsKey('${PatientEntity.className}.cols') &&
        cols['${PatientEntity.className}.cols']!
            .contains(PatientEntity.family)) {
      QueryBuilder<ParseObject> queryPatient =
          QueryBuilder<ParseObject>(ParseObject(PatientEntity.className));
      queryPatient.whereRelatedTo(
          PatientEntity.family, PatientEntity.className, parseObject.objectId!);
      queryPatient.keysToReturn([PatientEntity.name]);
      final ParseResponse parseResponse = await queryPatient.query();
      if (parseResponse.success && parseResponse.results != null) {
        for (var e in parseResponse.results!) {
          familyList.add(await PatientEntity().toModel(e as ParseObject, cols: {
            "${PatientEntity.className}.cols": [PatientEntity.name]
          }));
        }
      }
    }

    //--- get family
    //+++ get healthPlan
    List<HealthPlanModel> healthPlanList = [];
    if (cols.containsKey('${PatientEntity.className}.cols') &&
        cols['${PatientEntity.className}.cols']!
            .contains(PatientEntity.healthPlans)) {
      QueryBuilder<ParseObject> queryHealthPlanType =
          QueryBuilder<ParseObject>(ParseObject(HealthPlanEntity.className));
      queryHealthPlanType.whereRelatedTo(PatientEntity.healthPlans,
          PatientEntity.className, parseObject.objectId!);
      queryHealthPlanType.includeObject(['healthPlanType']);
      final ParseResponse parseResponse2 = await queryHealthPlanType.query();
      if (parseResponse2.success && parseResponse2.results != null) {
        for (var e in parseResponse2.results!) {
          healthPlanList.add(HealthPlanEntity().toModel(e as ParseObject));
        }
      }
    }

    //--- get healthPlan

    PatientModel model = PatientModel(
      id: parseObject.objectId!,
      email: parseObject.get(PatientEntity.email),
      nickname: parseObject.get(PatientEntity.nickname),
      name: parseObject.get(PatientEntity.name),
      cpf: parseObject.get(PatientEntity.cpf),
      phone: parseObject.get(PatientEntity.phone),
      address: parseObject.get(PatientEntity.address),
      cep: parseObject.get(PatientEntity.cep),
      isFemale: parseObject.get(PatientEntity.isFemale),
      birthday: parseObject.get<DateTime>(PatientEntity.birthday)?.toLocal(),
      region: parseObject.get(PatientEntity.region) != null
          ? RegionEntity().toModel(parseObject.get(PatientEntity.region))
          : null,
      family: familyList,
      healthPlans: healthPlanList,
    );
    return model;
  }

  ParseObject toParse(PatientModel model) {
    final parseObject = ParseObject(PatientEntity.className);
    parseObject.objectId = model.id;

    if (model.nickname != null) {
      parseObject.set(
          PatientEntity.nickname, model.nickname?.trim().toTitleCase());
    } else {
      parseObject.set(PatientEntity.nickname,
          model.name?.trim().split(' ')[0].toTitleCase());
    }
    // if (model.name != null) {
    parseObject.set(PatientEntity.name, model.name?.trim().toTitleCase());
    // }
    // if (model.email != null) {
    //   parseObject.set(PatientEntity.email, model.email);
    // }
    // if (model.cpf != null) {
    //   parseObject.set(PatientEntity.cpf, model.cpf);
    // }

    // if (model.phone != null) {
    //   parseObject.set(PatientEntity.phone, model.phone);
    // }
    // if (model.address != null) {
    parseObject.set(PatientEntity.address, model.address?.trim().toTitleCase());
    // }
    // if (model.cep != null) {
    //   parseObject.set(PatientEntity.cep, model.cep);
    // }

    // if (model.isFemale != null) {
    //   parseObject.set(PatientEntity.isFemale, model.isFemale);
    // }

    if (model.birthday != null) {
      parseObject.set<DateTime?>(
          PatientEntity.birthday,
          DateTime(model.birthday!.year, model.birthday!.month,
              model.birthday!.day));
    }
    // if (model.region != null) {
    //   parseObject.set(
    //       PatientEntity.region,
    //       (ParseObject(RegionEntity.className)..objectId = model.region!.id)
    //           .toPointer());
    // }

    return parseObject;
  }

  ParseObject toParseRelation({
    required String objectId,
    required String relationColumn,
    required String relationTable,
    required List<String> ids,
    required bool add,
  }) {
    final parseObject = ParseObject(PatientEntity.className);
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

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
