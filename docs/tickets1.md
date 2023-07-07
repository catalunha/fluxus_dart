Olá Suporte,

Estou tentando resolver uma query e não estou conseguindo. E já fiz muitos testes. Espero conseguir o precioso tempo e experiencia de vcs para ver se isto tem solução.
O trecho a seguir me fornece em list todos os atendimentos do usuario hE0Ng2FSwQ:
´´´
  final QueryBuilder<ParseObject> queryAttendance =
      QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
  queryAttendance.whereEqualTo(
      AttendanceEntity.professional,
      (ParseObject(UserProfileEntity.className)..objectId = 'hE0Ng2FSwQ')
          .toPointer());

  final list = await AttendanceB4a().list(
    queryAttendance,
    cols: {
      "${AttendanceEntity.className}.cols": [AttendanceEntity.id]
    },
  );
´´´
O trecho a seguir me fornece todos os eventos quer pertencem aos atendimentos anteriores daquele usuario.
```
  List<QueryBuilder<ParseObject>> listQueries = [];
  for (var element in list) {
    final QueryBuilder<ParseObject> queryTemp =
        QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
      queryTemp.whereEqualTo(
        EventEntity.attendances,
        (ParseObject(AttendanceEntity.className)..objectId = element.id)
            .toPointer());
    listQueries.add(queryTemp);
  }
  QueryBuilder<ParseObject> eventsByUser = QueryBuilder.or(
    ParseObject(EventEntity.className),
    listQueries,
  );
```
Ate ai tudo certo.
Destes eventos eu quero apenas os que estão na data do trecho a seguir
```
  final QueryBuilder<ParseObject> queryByDate =
      QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
  final start = DateTime(2023, 06, 25);
  final end = DateTime(2023, 06, 27);

  queryByDate.whereGreaterThanOrEqualsTo(
      EventEntity.day, DateTime(start.year, start.month, start.day));
  queryByDate.whereLessThanOrEqualTo(
      EventEntity.day, DateTime(end.year, end.month, end.day, 23, 59));
```
Penso que o trecho a seguir me daria o and entre eles. Ou seja os eventos por data e por usuario.
```
  QueryBuilder<ParseObject> mainQuery2 =
      QueryBuilder.and(ParseObject(EventEntity.className), [queryByDate, eventsByUser]);
```
Mas nao me retorna nada.

A query de queryByDate retorna os eventos:
ZVf7WTd6cM
qAvT71CMAL

A query eventsByUser retorna os eventos:
HMsggKqGmz
P5F1D6dsJz
ZVf7WTd6cM
rFHpMtVkaE

Veja que o que quero é justamente o evento ZVf7WTd6cM que pertence ao usuario do atendimento na data especificada.




