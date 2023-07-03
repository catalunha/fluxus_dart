import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_model.freezed.dart';

@freezed
abstract class RoomModel with _$RoomModel {
  factory RoomModel({
    String? id,
    String? name,
    bool? isActive,
  }) = _RoomModel;
}
