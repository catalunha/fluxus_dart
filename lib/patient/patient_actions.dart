import 'dart:convert';
import 'dart:io';

import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'patient_entity.dart';
import 'patient_model.dart';

void patientFluxusToJson() async {
  print('+++ patientFluxusToJson');
  final cols = {
    "${PatientEntity.className}.cols": [
      PatientEntity.email,
      PatientEntity.phone,
      PatientEntity.nickname,
      PatientEntity.name,
      PatientEntity.cpf,
      PatientEntity.isFemale,
      PatientEntity.birthday,
      PatientEntity.address,
      PatientEntity.cep,
      PatientEntity.cpf,
      PatientEntity.family,
      PatientEntity.healthPlans,
    ],
  };

  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(PatientEntity.className));
  query.setLimit(500);
  if (cols.containsKey('${PatientEntity.className}.cols')) {
    query.keysToReturn(cols['${PatientEntity.className}.cols']!);
  }
  if (cols.containsKey('${PatientEntity.className}.pointers')) {
    query.includeObject(cols['${PatientEntity.className}.pointers']!);
  }
  ParseResponse? parseResponse;

  try {
    parseResponse = await query.query();
    if (parseResponse.success && parseResponse.results != null) {
      var fileOpen = File('data/Profile.json').openWrite(mode: FileMode.write);

      for (ParseObject element in parseResponse.results!) {
        // print(element.toJson());
        final model = await PatientEntity().toModel(element, cols: cols);
        print('${model.id}');
        fileOpen.writeln('${jsonEncode(model)},');
      }
    } else {
      throw Exception('sem dados');
    }
  } catch (e, st) {
    print('Erro:');
    print('$e');
    print('$st');
  }
}

void patientJsonToFluxus2() async {
  var dataJson = File('data/Profile.json').readAsStringSync();
  final dataJsonObj = json.decode(dataJson);
  final List<PatientModel> list =
      dataJsonObj.map<PatientModel>((e) => PatientModel.fromJson(e)).toList();
  for (var model in list) {
    print('create ${model.id}');
    final parseObject = PatientEntity().toParse(model);
    try {
      final response = await parseObject.save();
      if (response.success && response.results != null) {
        print('${response.results!.first.objectId!}');
        // ParseObject userProfile = response.results!.first as ParseObject;
        // return userProfile.objectId!;
      } else {
        print('${response.error}');
        print('${response.statusCode}');
        // throw Exception(response.error);
        // exit(0);
      }
    } catch (e) {
      print(e);
    }
  }
  for (var model in list) {
    if (model.family!.isNotEmpty) {
      print('family relation ${model.id}');
      final parseObject = PatientEntity().toParseRelation(
        objectId: model.id!,
        relationColumn: 'family',
        relationTable: 'Patient',
        ids: model.family!.map((e) => e.id!).toList(),
        add: true,
      );
      await parseObject.save();
    }
    if (model.healthPlans!.isNotEmpty) {
      print('healthPlans relation ${model.id}');
      final parseObject = PatientEntity().toParseRelation(
        objectId: model.id!,
        relationColumn: 'healthPlans',
        relationTable: 'HealthPlan',
        ids: model.healthPlans!.map((e) => e.id!).toList(),
        add: true,
      );
      await parseObject.save();
    }
  }
}

void patientTest() async {
  final parseObject =
      PatientEntity().toParse(PatientModel(id: '123abc', name: 'abc'));
  try {
    final response = await parseObject.save();
    if (response.success && response.results != null) {
      print('${response.results!.first.objectId!}');
      // ParseObject userProfile = response.results!.first as ParseObject;
      // return userProfile.objectId!;
    } else {
      print('${response.error}');
      print('${response.statusCode}');
      // throw Exception(response.error);
      // exit(0);
    }
  } catch (e) {
    print(e);
  }
}
