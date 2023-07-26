import 'package:freezed_annotation/freezed_annotation.dart';

part 'anamnese_group_model.freezed.dart';

@freezed
abstract class AnamneseGroupModel with _$AnamneseGroupModel {
  factory AnamneseGroupModel({
    String? id,
    required String name,
    @Default([]) List<String> orderOfQuestions,
    @Default(true) bool isActive,
  }) = _AnamneseGroupModel;
}
