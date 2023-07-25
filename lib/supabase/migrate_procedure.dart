import 'dart:io';

import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../utils/pagination.dart';
import '../procedure/entity/procedure_entity.dart';
import '../procedure/model/procedure_model.dart';

void migrateProcedure() async {
  print('+++ migrateProcedure');

  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(ProcedureEntity.className));
  query.orderByAscending('name');
  query.includeObject(['expertise']);
  final list = await listProcedure(query);
  var procedureFile =
      File('data/procedure.txt').openWrite(mode: FileMode.write);

  procedureFile.writeln('code,name,description,expertise_id');

  for (var procedure in list) {
    procedureFile.writeln(
        '${procedure.code},${procedure.name},"${procedure.description}",${expertiseSupaBase[procedure.expertise!.name]}');
  }
}

Future<List<ProcedureModel>> listProcedure(
  QueryBuilder<ParseObject> query, {
  Pagination? pagination,
  Map<String, List<String>> cols = const {},
}) async {
  if (pagination != null) {
    query.setAmountToSkip((pagination.page - 1) * pagination.limit);
    query.setLimit(pagination.limit);
  }
  if (cols.containsKey('${ProcedureEntity.className}.cols')) {
    query.keysToReturn(cols['${ProcedureEntity.className}.cols']!);
  }
  if (cols.containsKey('${ProcedureEntity.className}.pointers')) {
    query.includeObject(cols['${ProcedureEntity.className}.pointers']!);
  } else {
    query.includeObject(['expertise']);
  }

  ParseResponse? parseResponse;
  try {
    parseResponse = await query.query();
    final List<ProcedureModel> listTemp = <ProcedureModel>[];
    if (parseResponse.success && parseResponse.results != null) {
      for (var element in parseResponse.results!) {
        listTemp.add(ProcedureEntity().toModel(element));
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

final expertiseSupaBase = {
  'Psicologia': '2064feda-42ac-4ac5-b725-79070a04c59e',
  'Nutrição': '0e673445-41a1-449e-89e9-659a5a24f101',
  'Fisioterapia': '8ecc88d7-1843-42f6-8111-676e8ad39272',
  'Fonoaudiologia': '7e2566c4-77c3-4a01-b9ec-7c2d3f49434e',
  'Terapia Ocupacional': '40b53dbc-aafb-4c8b-a067-55bc1b21126a',
  'Enfermeira': '27c014e3-a948-4c01-b6ed-13357858fc92',
  'Psicopedagogia': '6952e185-85f4-4e33-b8b8-5cc6ce3ef3d6',
  'Música': '65d3891f-092c-4fa3-a87b-0c8c77406b12',
};
final expertiseB4a = {
  'Psicologia': 'AwfAwREwOR',
  'Nutrição': '6LMktJYBvk',
  'Fisioterapia': '6LrBl5RNu2',
  'Fonoaudiologia': 'PJ7oiMLiKN',
  'Terapia Ocupacional': 'eyZdCXAEPj',
  'Enfermeira': 'ksAHYb3CGr',
  'Psicopedagogia': '5O3e8DfmA3',
  'Música': '7jrSLiuoJF',
};
