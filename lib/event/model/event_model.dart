import 'package:freezed_annotation/freezed_annotation.dart';

import '../../attendance/model/attendance_model.dart';
import '../../hour/model/hour_model.dart';
import '../../room/model/room_model.dart';
import '../../status/model/status_model.dart';

part 'event_model.freezed.dart';

@freezed
abstract class EventModel with _$EventModel {
  factory EventModel({
    String? id,
    DateTime? day,
    HourModel? hour,
    RoomModel? room,
    List<AttendanceModel>? attendances,
    StatusModel? status,
    String? history,
  }) = _EventModel;
}
