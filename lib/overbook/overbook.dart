import 'dart:developer';

import 'package:fluxus_dart/event/entity/event_b4a.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../event/entity/event_entity.dart';
import '../room/entity/room_entity.dart';
import '../room/model/room_model.dart';

Future<bool> overbook() async {
  print('overbook');
  String? currentId = 'ZNFXxkfImC';
  DateTime start = DateTime(2023, 07, 12, 07, 00);
  DateTime end = DateTime(2023, 07, 12, 08, 00);
  RoomModel room = RoomModel(id: 'e0e5Zzx2ZC');
  log('+++ overbook: Teste 1');

  //  BD------S----------E------
  // 1 N---S------E-------------
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
  query.whereNotEqualTo(EventEntity.id, currentId);
  query.whereEqualTo(EventEntity.room,
      (ParseObject(RoomEntity.className)..objectId = room.id).toPointer());
  query.whereGreaterThanOrEqualsTo(EventEntity.start, start);
  query.whereLessThanOrEqualTo(EventEntity.start, end);
  var result = await queryOverbook(query);
  if (result) {
    return true;
  }
  log('+++ overbook: Teste 2');
  //  BD------S----------E------
  // 2 N--------S------E--------
  query = QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
  query.whereNotEqualTo(EventEntity.id, currentId);
  query.whereEqualTo(EventEntity.room,
      (ParseObject(RoomEntity.className)..objectId = room.id).toPointer());
  query.whereLessThanOrEqualTo(EventEntity.start, start);
  query.whereGreaterThanOrEqualsTo(EventEntity.end, end);
  result = await queryOverbook(query);
  if (result) {
    return true;
  }
  log('+++ overbook: Teste 3');
  //  BD------S----------E------
  // 3 N--------------S------E--
  query = QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
  query.whereNotEqualTo(EventEntity.id, currentId);
  query.whereEqualTo(EventEntity.room,
      (ParseObject(RoomEntity.className)..objectId = room.id).toPointer());
  query.whereGreaterThanOrEqualsTo(EventEntity.end, start);
  query.whereLessThanOrEqualTo(EventEntity.end, end);
  result = await queryOverbook(query);
  if (result) {
    return true;
  }
  log('+++ overbook: Teste 4');
  //  BD------S----------E------
  // 4 N---S---------------E----
  query = QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
  query.whereNotEqualTo(EventEntity.id, currentId);
  query.whereEqualTo(EventEntity.room,
      (ParseObject(RoomEntity.className)..objectId = room.id).toPointer());
  query.whereGreaterThanOrEqualsTo(EventEntity.start, start);
  query.whereLessThanOrEqualTo(EventEntity.end, end);
  if (result) {
    return true;
  }

  return false;
}

Future<bool> queryOverbook(QueryBuilder<ParseObject> query) async {
  final list = await EventB4a().list(query, cols: {
    '${EventEntity.className}.cols': [
      EventEntity.id,
      EventEntity.start,
      EventEntity.end,
      EventEntity.room,
      // EventEntity.status,
    ],
    // '${EventEntity.className}.pointers': [
    //   EventEntity.room,
    //   EventEntity.status,
    // ]
  });
  for (final element in list) {
    log('queryOverbook: $element');
  }
  if (list.isEmpty) {
    log('queryOverbook: false');
    return false;
  } else {
    log('queryOverbook: true');
    return true;
  }
}
