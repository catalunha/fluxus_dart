import 'package:freezed_annotation/freezed_annotation.dart';

part 'expertise_model.freezed.dart';
part 'expertise_model.g.dart';

@freezed
abstract class ExpertiseModel with _$ExpertiseModel {
  factory ExpertiseModel({
    String? id,
    String? name,
  }) = _ExpertiseModel;
  factory ExpertiseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpertiseModelFromJson(json);
}
