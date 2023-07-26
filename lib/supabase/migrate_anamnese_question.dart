import 'dart:io';

import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../anamnese/anamnese_question_b4a.dart';
import '../anamnese/anamnese_question_entity.dart';

void migrateAnamneseQuestion() async {
  print('+++ migrateAnamneseQuestion');
  final QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(AnamneseQuestionEntity.className));
  query.orderByAscending('text');
  final listQuestions = await AnamneseQuestionB4a().list(
    query,
    cols: {
      '${AnamneseQuestionEntity.className}.cols': [
        AnamneseQuestionEntity.text,
        AnamneseQuestionEntity.type,
        AnamneseQuestionEntity.options,
        AnamneseQuestionEntity.isActive,
        AnamneseQuestionEntity.isRequired,
        AnamneseQuestionEntity.group,
      ],
      '${AnamneseQuestionEntity.className}.pointers': [
        AnamneseQuestionEntity.group,
      ],
    },
  );
  print('listQuestions: ${listQuestions.length}');
  var patientFile =
      File('data/anamnese_question.txt').openWrite(mode: FileMode.write);
  patientFile.writeln('text,type,options,is_required,is_active,group_id');
  for (var question in listQuestions) {
    patientFile.writeln(
        '"${question.text}",${question.type},"${question.options}",${question.isRequired},${question.isActive},${groupNew[question.group.name]}');
  }
}

final groupNew = {
  'Histórico familiar': 'dbd5b5c9-184b-4681-8563-8d1347ba0eaf',
  'Linguagem': '5c79c52e-7509-44d8-86f2-ed013d6678be',
  'Físico e Motor': '6abde216-05b8-4399-9c82-9b6243637d7f',
  'Sensorial': 'aa47c691-ee6d-4441-8d38-49e5b64fb657',
  'Alimentação': '90861630-c3f7-4915-af91-5718e032d49d',
  'Sono': '9bd470aa-6174-45b9-95d5-ecdc333aeab6',
  'Socialização': '82babeea-b0a6-4259-b8ce-a0e69a1150dd',
  'Saúde e Medicação': '90d21d07-bfe3-4a21-b585-a9fe9af100f7',
  'Raciocínio e Percepção': '54967b96-f0da-4638-81cd-f5efd9ccafde',
  'Test de programação - Não ativar': 'f8e0f9c8-1530-42ff-b7f1-ec5fa550649a',
};
