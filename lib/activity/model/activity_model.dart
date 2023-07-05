import 'package:freezed_annotation/freezed_annotation.dart';

import '../../expertise/model/expertise_model.dart';

part 'activity_model.freezed.dart';

@freezed
abstract class ActivityModel with _$ActivityModel {
  factory ActivityModel({
    String? id,
    String? name,
    List<ExpertiseModel>? expertises,
  }) = _ActivityModel;
}
