import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'db.g.dart';

enum RequestMethod {
  get,
  post,
  put,
  delete,
  patch,
  head;
}

enum RequestStatus {
  pending,
  success,
  error,
}

class Requests extends Table {
  TextColumn get guid => text()();

  IntColumn get method => intEnum<RequestMethod>()();

  IntColumn get status => intEnum<RequestStatus>()();

  TextColumn get queryParams => text().nullable()();

  TextColumn get url => text()();

  TextColumn get body => text().nullable()();

  TextColumn get headers => text().nullable()();

  TextColumn get response => text().nullable()();

  TextColumn get responseHeaders => text().nullable()();

  TextColumn get error => text().nullable()();

  IntColumn get statusCode => integer().nullable()();

  TextColumn get extra => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {guid};
}

@DriftDatabase(tables: [Requests])
class RequestsDatabase extends _$RequestsDatabase {
  RequestsDatabase() : super(_openConnection());

  Future<int> insertRequest(Request request) {
    return transaction(
      () async {
        final countExpression = countAll();
        final query = selectOnly(requests)..addColumns([countExpression]);

        final count = await query
            .get()
            .then((value) => value.single.read(countExpression));

        if (count! >= 100) {
          final oldest = await (select(requests)
                ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
              .getSingle();

          await deleteRequest(oldest.guid);
        }
        return _insertRequest(request);
      },
    );
  }

  Future<int> _insertRequest(Request request) {
    return into(requests).insert(request);
  }

  Future<int> updateRequest(RequestsCompanion request, String guid) {
    return (update(requests)..where((tbl) => tbl.guid.equals(guid)))
        .write(request);
  }

  Future<int> deleteRequest(String uuid) {
    return (delete(requests)..where((tbl) => tbl.guid.equals(uuid))).go();
  }

  Future<List<Request>> search(String query) {
    return (select(requests)
          ..where((tbl) =>
              tbl.url.contains(query) |
              tbl.body.contains(query) |
              tbl.headers.contains(query) |
              tbl.response.contains(query) |
              tbl.error.contains(query) |
              tbl.extra.contains(query)))
        .get();
  }

  Stream<List<Request>> requestStream() {
    return select(requests).watch();
  }

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'bot_network_logger.sqlite'));
      return NativeDatabase.createInBackground(file);
    },
  );
}
