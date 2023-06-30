import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../patient/entity/patient_entity.dart';
import '../../user_profile/entity/user_profile_entity.dart';
import '../model/shared_model.dart';

class SharedEntity {
  static const String className = 'Shared';
  static const String id = 'objectId';
  static const String createdAt = 'createdAt';
  //pointerCols
  static const String professional = 'professional';
  static const String patient = 'patient';
  //singleCols
  static const String description = 'description';
  static const String document = 'document';
  static const String isPublic = 'isPublic';

  Future<SharedModel> toModel(
    ParseObject parseObject, {
    Map<String, List<String>> cols = const {},
  }) async {
    final SharedModel model = SharedModel(
      id: parseObject.objectId!,
      createdAt: parseObject.createdAt!.toLocal(),
      professional: parseObject.get(SharedEntity.professional) != null
          ? await UserProfileEntity()
              .toModel(parseObject.get(SharedEntity.professional))
          : null,
      patient: parseObject.get(SharedEntity.patient) != null
          ? await PatientEntity()
              .toModel(parseObject.get(SharedEntity.patient), cols: cols)
          : null,
      description: parseObject.get(SharedEntity.description),
      document: parseObject.get(SharedEntity.document)?.get('url'),
      isPublic: parseObject.get(SharedEntity.isPublic),
    );
    return model;
  }

  Future<ParseObject> toParse(SharedModel model) async {
    final parseObject = ParseObject(SharedEntity.className);
    parseObject.objectId = model.id;

    parseObject.set(
        SharedEntity.professional,
        (ParseObject(UserProfileEntity.className)
              ..objectId = model.professional!.id)
            .toPointer());

    parseObject.set(
        SharedEntity.patient,
        (ParseObject(PatientEntity.className)..objectId = model.patient!.id)
            .toPointer());

    parseObject.set(SharedEntity.description, model.description);
    parseObject.set(SharedEntity.isPublic, model.isPublic);

    return parseObject;
  }
}
