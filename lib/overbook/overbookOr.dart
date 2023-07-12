import 'dart:developer';

import 'package:fluxus_dart/event/entity/event_b4a.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../event/entity/event_entity.dart';
import '../room/entity/room_entity.dart';
import '../room/model/room_model.dart';

void overbookOr() async {
  print('overbook');
  String? currentId = 'ZNFXxkfImC';
  DateTime start = DateTime(2023, 07, 12, 07, 00);
  DateTime end = DateTime(2023, 07, 12, 08, 00);
  RoomModel room = RoomModel(id: 'e0e5Zzx2ZC');

  //  BD------S----------E------
  // 1 N---S------E-------------
  final QueryBuilder<ParseObject> query1 =
      QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
  // if (currentId != null) {
  //   query1.whereNotEqualTo(EventEntity.id, currentId);
  // }
  query1.whereEqualTo(EventEntity.room,
      (ParseObject(RoomEntity.className)..objectId = room.id).toPointer());
  query1.whereGreaterThanOrEqualsTo(EventEntity.start, start);
  query1.whereLessThanOrEqualTo(EventEntity.start, end);

  log('+++ overbook: Teste 2');
  //  BD------S----------E------
  // 2 N--------S------E--------
  final QueryBuilder<ParseObject> query2 =
      QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
  // if (currentId != null) {
  //   query2.whereNotEqualTo(EventEntity.id, currentId);
  // }
  query2.whereEqualTo(EventEntity.room,
      (ParseObject(RoomEntity.className)..objectId = room.id).toPointer());
  query2.whereLessThanOrEqualTo(EventEntity.start, start);
  query2.whereGreaterThanOrEqualsTo(EventEntity.end, end);

  log('+++ overbook: Teste 3');
  //  BD------S----------E------
  // 3 N--------------S------E--
  final QueryBuilder<ParseObject> query3 =
      QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
  // if (currentId != null) {
  //   query3.whereNotEqualTo(EventEntity.id, currentId);
  // }
  query3.whereEqualTo(EventEntity.room,
      (ParseObject(RoomEntity.className)..objectId = room.id).toPointer());
  query3.whereGreaterThanOrEqualsTo(EventEntity.end, start);
  query3.whereLessThanOrEqualTo(EventEntity.end, end);

  log('+++ overbook: Teste 4');
  //  BD------S----------E------
  // 4 N---S---------------E----
  final QueryBuilder<ParseObject> query4 =
      QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
  // if (currentId != null) {
  //   query4.whereNotEqualTo(EventEntity.id, currentId);
  // }
  query4.whereEqualTo(EventEntity.room,
      (ParseObject(RoomEntity.className)..objectId = room.id).toPointer());
  query4.whereGreaterThanOrEqualsTo(EventEntity.start, start);
  query4.whereLessThanOrEqualTo(EventEntity.end, end);

  final QueryBuilder<ParseObject> queryFinal = QueryBuilder.or(
      ParseObject(EventEntity.className), [query1, query2, query3, query4]);
  queryFinal.whereNotEqualTo(EventEntity.id, currentId);

  final result = await queryOverbook(queryFinal);
  log('overbookOr: $result');
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
