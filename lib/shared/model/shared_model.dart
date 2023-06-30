import 'package:freezed_annotation/freezed_annotation.dart';

import '../../patient/model/patient_model.dart';
import '../../user_profile/model/user_profile_model.dart';

part 'shared_model.freezed.dart';

@freezed
abstract class SharedModel with _$SharedModel {
  factory SharedModel({
    String? id,
    DateTime? createdAt,
    UserProfileModel? professional,
    PatientModel? patient,
    String? description,
    String? document,
    @Default(false) bool isPublic,
  }) = _SharedModel;
}
