import '../../expertise/model/expertise_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../office/model/office_model.dart';
import '../../procedure/model/procedure_model.dart';
import '../../region/model/region_model.dart';

part 'user_profile_model.freezed.dart';

@freezed
abstract class UserProfileModel with _$UserProfileModel {
  factory UserProfileModel({
    required String id,
    required String userName,
    required String email,
    required bool isActive,
    required List<String> access, //admin, sec, prof, fin

    String? nickname,
    String? name,
    String? cpf,
    String? register, // conselho de saude
    String? phone,
    String? photo,
    bool? isFemale,
    DateTime? birthday,
    String? address,
    RegionModel? region,
    List<OfficeModel>? offices, // cargos
    List<ExpertiseModel>? expertises, // especialidade
    List<ProcedureModel>? procedures, // procedimentos
  }) = _UserProfileModel;
}
