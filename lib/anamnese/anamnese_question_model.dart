import 'anamnese_group_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anamnese_question_model.freezed.dart';

@freezed
abstract class AnamneseQuestionModel with _$AnamneseQuestionModel {
  factory AnamneseQuestionModel({
    String? id,
    required AnamneseGroupModel group,
    required String text,
    required String type,
    required List<String> options,
    @Default(false) bool isRequired,
    @Default(true) bool isActive,
  }) = _AnamneseQuestionModel;
}
