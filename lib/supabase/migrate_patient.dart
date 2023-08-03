import 'dart:io';

import 'package:intl/intl.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:uuid/uuid.dart';

import '../patient/entity/patient_entity.dart';
import '../patient/model/patient_model.dart';
import '../utils/pagination.dart';

void migratePatient() async {
  print('+++ migratePatient');
  List<PatientModel> list = await getAll();
  print('process...list: ${list.length}');

  var patientFile = File('data/patient.txt').openWrite(mode: FileMode.write);
  patientFile.writeln(
      'id,name,nickname,email,phone,cpf,address,cep,is_female,birthday');

  var healthPlansFile =
      File('data/healthPlans.txt').openWrite(mode: FileMode.write);
  healthPlansFile.writeln('id,code,description,due,health_plan_type_id');

  var patientHealthplansfile =
      File('data/patient_healthPlans.txt').openWrite(mode: FileMode.write);
  patientHealthplansfile.writeln('patient_id,health_plan_id');
  final dateFormat = DateFormat('y-MM-dd HH:mm:ss');

  for (var patient in list) {
    final patientUUID = Uuid().v4();
    //patient
    patientFile.writeln(
        '$patientUUID,"${patient.name}","${patient.nickname}","${patient.email}","${patient.phone}","${patient.cpf}","${patient.address?.replaceAll('"', '')}","${patient.cep}",${patient.isFemale},${patient.birthday != null ? dateFormat.format(patient.birthday!) : null}');
    if (patient.healthPlans != null && patient.healthPlans!.isNotEmpty) {
      for (var healthPlans in patient.healthPlans!) {
        if (healthPlans.healthPlanType!.id != "fp5YkDWvxq") {
          final healthPlansUUID = Uuid().v4();

          healthPlansFile.writeln(
              '$healthPlansUUID,"${healthPlans.code}","${healthPlans.description}",${healthPlans.due != null ? dateFormat.format(healthPlans.due!) : null},${health_plan_type[healthPlans.healthPlanType!.name]}');
          patientHealthplansfile.writeln('$patientUUID,$healthPlansUUID');
          patientHealthplansfile
              .writeln('$patientUUID,ff1104eb-452c-4a3d-ba18-6369b7ec752c');
        }
      }
    }
  }
  print('process...list: ${list.length}');

  patientFile.close();
  healthPlansFile.close();
  patientHealthplansfile.close();
}

Future<List<PatientModel>> getAll() async {
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
  query.whereGreaterThan('createdAt', DateTime(2023, 07, 22));
  query.setLimit(500);

  return await list(query, cols: cols);
}

Future<List<PatientModel>> list(
  QueryBuilder<ParseObject> query, {
  Pagination? pagination,
  Map<String, List<String>> cols = const {},
}) async {
  query.setLimit(500);
  if (pagination != null) {
    query.setAmountToSkip((pagination.page - 1) * pagination.limit);
    query.setLimit(pagination.limit);
  }
  if (cols.containsKey('${PatientEntity.className}.cols')) {
    query.keysToReturn(cols['${PatientEntity.className}.cols']!);
  }
  if (cols.containsKey('${PatientEntity.className}.pointers')) {
    query.includeObject(cols['${PatientEntity.className}.pointers']!);
  }

  ParseResponse? response;
  try {
    response = await query.query();
    final List<PatientModel> listTemp = <PatientModel>[];
    if (response.success && response.results != null) {
      for (var element in response.results!) {
        listTemp.add(await PatientEntity().toModel(element, cols: cols));
      }
      return listTemp;
    } else {
      return [];
    }
  } catch (e, st) {
    print('Erro em list');
    print(e);
    print(st);
    return [];
  }
}

final health_plan_type = {
  'IPSM': '1beb9a72-cc0e-464a-ba8f-841159f2dffc',
  'UNIMED GV': '8fa07c78-b611-4b93-866a-51b4811d455c',
  'VALE/PASA': '6f6f440e-4674-4fcf-beff-02c13e6a718e',
  'BRADESCO': '2f3b7c65-29ac-4d7e-9976-aafed300d456',
  'Particular': 'f71778d2-3459-47cf-963c-8820527d60e6',
  'Prefeitura': 'f61f4144-b24d-4e0d-a807-1e01d11df1ed',
  'UNIMED BH': 'd3491177-04d8-4778-9a2a-9395dcb6d9a0',
  'UNIMED VALE DO AÇO': '735eea28-1269-4172-a7dc-528cc6774c30',
  'UNIMED SÃO PAULO': 'efbd8261-4991-4779-8144-a6e06d377891',
  'UNIMED VITÓRIA': '91f8eb0f-dc97-4463-a755-aadb30cb9d80',
  'COOPEND': 'a121264b-6c6e-4213-932a-974249d4eafb',
};
