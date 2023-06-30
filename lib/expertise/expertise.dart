import 'dart:convert';
import 'dart:io';

import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'entity/expertise_entity.dart';
import 'model/expertise_model.dart';

void expertiseFluxus1ToJson() async {
  print('+++ teste5');
  ParseResponse? parseResponse;
  final parseObject = ParseObject('Expertise');

  parseResponse = await parseObject.getAll();

  if (parseResponse.success && parseResponse.results != null) {
    var fileOpen = File('expertise.json').openWrite(mode: FileMode.append);

    for (ParseObject element in parseResponse.results!) {
      print(element.toJson());
      final model = ExpertiseEntity().toModel(element);
      print('${model.toJson()}');
      fileOpen.writeln('${jsonEncode(model)},');
    }
  } else {
    throw Exception();
  }
}

void expertiseJsonToFluxus2() async {
  var dataJson = File('expertise.json').readAsStringSync();
  final dataJsonObj = json.decode(dataJson);
  final List<ExpertiseModel> list = dataJsonObj
      .map<ExpertiseModel>((e) => ExpertiseModel.fromJson(e))
      .toList();
  for (var model in list) {
    print('${model.id}');
    final parseObject = ExpertiseEntity().toParse(model);
    await parseObject.save();
  }
}
