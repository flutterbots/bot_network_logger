import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:drift_local_storage_inspector/drift_local_storage_inspector.dart';
import 'package:storage_inspector/storage_inspector.dart';

import 'db.dart';

class BotNetworkLogInterceptor extends Interceptor {
  static final RequestsDatabase _db = requestsDatabase();

  static RequestsDatabase requestsDatabase() {
    final driver = StorageServerDriver(
      bundleId: 'supy.io.dev',
    );

    final driftDb = RequestsDatabase();

    final sqlServer = DriftSQLDatabaseServer(
      id: "1",
      name: "SQL server",
      database: driftDb,
    );

    driver.addSQLServer(sqlServer);

    driver.start(paused: false);

    return driftDb;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final request = _request(options);
    options.logId = request.guid;
    _db.insertRequest(request);

    return super.onRequest(options, handler);
  }

  Request _request(RequestOptions options) {
    return Request(
      guid: _generateUuid(),
      method: RequestMethod.values.asNameMap()[options.method.toLowerCase()]!,
      url: options.uri.toString(),
      headers: _encodeOrToString(options.headers),
      body: options.data != null ? _encodeOrToString(options.data) : null,
      status: RequestStatus.pending,
      createdAt: DateTime.now(),
      queryParams: options.queryParameters.isNotEmpty
          ? _encodeOrToString(options.queryParameters)
          : null,
      extra: options.extra.isNotEmpty ? _encodeOrToString(options.extra) : null,
    );
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final logId = response.requestOptions.logId;
    if (logId != null) {
      _db.updateRequest(
        RequestsCompanion(
          status: const Value(RequestStatus.success),
          response: Value(jsonEncode(response.data)),
          statusCode: Value(response.statusCode),
        ),
        logId,
      );
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final logId = err.requestOptions.logId;
    if (logId != null) {
      _db.updateRequest(
          RequestsCompanion(
            status: const Value(RequestStatus.error),
            error: Value(err.toString()),
            statusCode: Value(err.response?.statusCode),
          ),
          logId);
    }
    return super.onError(err, handler);
  }
}

extension on RequestOptions {
  static const String _logIdKey = 'log_id';

  String? get logId => extra[_logIdKey] as String?;

  set logId(String? value) => extra[_logIdKey] = value;
}

String _encodeOrToString(dynamic value) {
  try {
    return jsonEncode(value);
  } on JsonUnsupportedObjectError {
    return value.toString();
  }
}

// generated by ChatGPT-3 :)
String _generateUuid() {
  final rnd = Random.secure();
  final data = Uint8List(16);
  for (int i = 0; i < data.length; i++) {
    data[i] = rnd.nextInt(256);
  }
  data[6] = (data[6] & 0x0f) | 0x40;
  data[8] = (data[8] & 0x3f) | 0x80;
  return Uint8List.view(data.buffer)
      .map((v) => v.toRadixString(16).padLeft(2, '0'))
      .join()
      .toUpperCase();
}
