// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// ignore_for_file: type=lint
class $RequestsTable extends Requests with TableInfo<$RequestsTable, Request> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RequestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _guidMeta = const VerificationMeta('guid');
  @override
  late final GeneratedColumn<String> guid = GeneratedColumn<String>(
      'guid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumnWithTypeConverter<RequestMethod, int> method =
      GeneratedColumn<int>('method', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<RequestMethod>($RequestsTable.$convertermethod);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumnWithTypeConverter<RequestStatus, int> status =
      GeneratedColumn<int>('status', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<RequestStatus>($RequestsTable.$converterstatus);
  static const VerificationMeta _queryParamsMeta =
      const VerificationMeta('queryParams');
  @override
  late final GeneratedColumn<String> queryParams = GeneratedColumn<String>(
      'query_params', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _headersMeta =
      const VerificationMeta('headers');
  @override
  late final GeneratedColumn<String> headers = GeneratedColumn<String>(
      'headers', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _responseMeta =
      const VerificationMeta('response');
  @override
  late final GeneratedColumn<String> response = GeneratedColumn<String>(
      'response', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String> error = GeneratedColumn<String>(
      'error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusCodeMeta =
      const VerificationMeta('statusCode');
  @override
  late final GeneratedColumn<int> statusCode = GeneratedColumn<int>(
      'status_code', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _extraMeta = const VerificationMeta('extra');
  @override
  late final GeneratedColumn<String> extra = GeneratedColumn<String>(
      'extra', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        guid,
        method,
        status,
        queryParams,
        url,
        body,
        headers,
        response,
        error,
        statusCode,
        extra,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? 'requests';
  @override
  String get actualTableName => 'requests';
  @override
  VerificationContext validateIntegrity(Insertable<Request> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('guid')) {
      context.handle(
          _guidMeta, guid.isAcceptableOrUnknown(data['guid']!, _guidMeta));
    } else if (isInserting) {
      context.missing(_guidMeta);
    }
    context.handle(_methodMeta, const VerificationResult.success());
    context.handle(_statusMeta, const VerificationResult.success());
    if (data.containsKey('query_params')) {
      context.handle(
          _queryParamsMeta,
          queryParams.isAcceptableOrUnknown(
              data['query_params']!, _queryParamsMeta));
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    }
    if (data.containsKey('headers')) {
      context.handle(_headersMeta,
          headers.isAcceptableOrUnknown(data['headers']!, _headersMeta));
    }
    if (data.containsKey('response')) {
      context.handle(_responseMeta,
          response.isAcceptableOrUnknown(data['response']!, _responseMeta));
    }
    if (data.containsKey('error')) {
      context.handle(
          _errorMeta, error.isAcceptableOrUnknown(data['error']!, _errorMeta));
    }
    if (data.containsKey('status_code')) {
      context.handle(
          _statusCodeMeta,
          statusCode.isAcceptableOrUnknown(
              data['status_code']!, _statusCodeMeta));
    }
    if (data.containsKey('extra')) {
      context.handle(
          _extraMeta, extra.isAcceptableOrUnknown(data['extra']!, _extraMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {guid};
  @override
  Request map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Request(
      guid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}guid'])!,
      method: $RequestsTable.$convertermethod.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}method'])!),
      status: $RequestsTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!),
      queryParams: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}query_params']),
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body']),
      headers: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}headers']),
      response: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}response']),
      error: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error']),
      statusCode: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status_code']),
      extra: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}extra']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $RequestsTable createAlias(String alias) {
    return $RequestsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RequestMethod, int, int> $convertermethod =
      const EnumIndexConverter<RequestMethod>(RequestMethod.values);
  static JsonTypeConverter2<RequestStatus, int, int> $converterstatus =
      const EnumIndexConverter<RequestStatus>(RequestStatus.values);
}

class Request extends DataClass implements Insertable<Request> {
  final String guid;
  final RequestMethod method;
  final RequestStatus status;
  final String? queryParams;
  final String url;
  final String? body;
  final String? headers;
  final String? response;
  final String? error;
  final int? statusCode;
  final String? extra;
  final DateTime createdAt;
  const Request(
      {required this.guid,
      required this.method,
      required this.status,
      this.queryParams,
      required this.url,
      this.body,
      this.headers,
      this.response,
      this.error,
      this.statusCode,
      this.extra,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['guid'] = Variable<String>(guid);
    {
      final converter = $RequestsTable.$convertermethod;
      map['method'] = Variable<int>(converter.toSql(method));
    }
    {
      final converter = $RequestsTable.$converterstatus;
      map['status'] = Variable<int>(converter.toSql(status));
    }
    if (!nullToAbsent || queryParams != null) {
      map['query_params'] = Variable<String>(queryParams);
    }
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || body != null) {
      map['body'] = Variable<String>(body);
    }
    if (!nullToAbsent || headers != null) {
      map['headers'] = Variable<String>(headers);
    }
    if (!nullToAbsent || response != null) {
      map['response'] = Variable<String>(response);
    }
    if (!nullToAbsent || error != null) {
      map['error'] = Variable<String>(error);
    }
    if (!nullToAbsent || statusCode != null) {
      map['status_code'] = Variable<int>(statusCode);
    }
    if (!nullToAbsent || extra != null) {
      map['extra'] = Variable<String>(extra);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RequestsCompanion toCompanion(bool nullToAbsent) {
    return RequestsCompanion(
      guid: Value(guid),
      method: Value(method),
      status: Value(status),
      queryParams: queryParams == null && nullToAbsent
          ? const Value.absent()
          : Value(queryParams),
      url: Value(url),
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
      headers: headers == null && nullToAbsent
          ? const Value.absent()
          : Value(headers),
      response: response == null && nullToAbsent
          ? const Value.absent()
          : Value(response),
      error:
          error == null && nullToAbsent ? const Value.absent() : Value(error),
      statusCode: statusCode == null && nullToAbsent
          ? const Value.absent()
          : Value(statusCode),
      extra:
          extra == null && nullToAbsent ? const Value.absent() : Value(extra),
      createdAt: Value(createdAt),
    );
  }

  factory Request.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Request(
      guid: serializer.fromJson<String>(json['guid']),
      method: $RequestsTable.$convertermethod
          .fromJson(serializer.fromJson<int>(json['method'])),
      status: $RequestsTable.$converterstatus
          .fromJson(serializer.fromJson<int>(json['status'])),
      queryParams: serializer.fromJson<String?>(json['queryParams']),
      url: serializer.fromJson<String>(json['url']),
      body: serializer.fromJson<String?>(json['body']),
      headers: serializer.fromJson<String?>(json['headers']),
      response: serializer.fromJson<String?>(json['response']),
      error: serializer.fromJson<String?>(json['error']),
      statusCode: serializer.fromJson<int?>(json['statusCode']),
      extra: serializer.fromJson<String?>(json['extra']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'guid': serializer.toJson<String>(guid),
      'method': serializer
          .toJson<int>($RequestsTable.$convertermethod.toJson(method)),
      'status': serializer
          .toJson<int>($RequestsTable.$converterstatus.toJson(status)),
      'queryParams': serializer.toJson<String?>(queryParams),
      'url': serializer.toJson<String>(url),
      'body': serializer.toJson<String?>(body),
      'headers': serializer.toJson<String?>(headers),
      'response': serializer.toJson<String?>(response),
      'error': serializer.toJson<String?>(error),
      'statusCode': serializer.toJson<int?>(statusCode),
      'extra': serializer.toJson<String?>(extra),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Request copyWith(
          {String? guid,
          RequestMethod? method,
          RequestStatus? status,
          Value<String?> queryParams = const Value.absent(),
          String? url,
          Value<String?> body = const Value.absent(),
          Value<String?> headers = const Value.absent(),
          Value<String?> response = const Value.absent(),
          Value<String?> error = const Value.absent(),
          Value<int?> statusCode = const Value.absent(),
          Value<String?> extra = const Value.absent(),
          DateTime? createdAt}) =>
      Request(
        guid: guid ?? this.guid,
        method: method ?? this.method,
        status: status ?? this.status,
        queryParams: queryParams.present ? queryParams.value : this.queryParams,
        url: url ?? this.url,
        body: body.present ? body.value : this.body,
        headers: headers.present ? headers.value : this.headers,
        response: response.present ? response.value : this.response,
        error: error.present ? error.value : this.error,
        statusCode: statusCode.present ? statusCode.value : this.statusCode,
        extra: extra.present ? extra.value : this.extra,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('Request(')
          ..write('guid: $guid, ')
          ..write('method: $method, ')
          ..write('status: $status, ')
          ..write('queryParams: $queryParams, ')
          ..write('url: $url, ')
          ..write('body: $body, ')
          ..write('headers: $headers, ')
          ..write('response: $response, ')
          ..write('error: $error, ')
          ..write('statusCode: $statusCode, ')
          ..write('extra: $extra, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(guid, method, status, queryParams, url, body,
      headers, response, error, statusCode, extra, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Request &&
          other.guid == this.guid &&
          other.method == this.method &&
          other.status == this.status &&
          other.queryParams == this.queryParams &&
          other.url == this.url &&
          other.body == this.body &&
          other.headers == this.headers &&
          other.response == this.response &&
          other.error == this.error &&
          other.statusCode == this.statusCode &&
          other.extra == this.extra &&
          other.createdAt == this.createdAt);
}

class RequestsCompanion extends UpdateCompanion<Request> {
  final Value<String> guid;
  final Value<RequestMethod> method;
  final Value<RequestStatus> status;
  final Value<String?> queryParams;
  final Value<String> url;
  final Value<String?> body;
  final Value<String?> headers;
  final Value<String?> response;
  final Value<String?> error;
  final Value<int?> statusCode;
  final Value<String?> extra;
  final Value<DateTime> createdAt;
  const RequestsCompanion({
    this.guid = const Value.absent(),
    this.method = const Value.absent(),
    this.status = const Value.absent(),
    this.queryParams = const Value.absent(),
    this.url = const Value.absent(),
    this.body = const Value.absent(),
    this.headers = const Value.absent(),
    this.response = const Value.absent(),
    this.error = const Value.absent(),
    this.statusCode = const Value.absent(),
    this.extra = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RequestsCompanion.insert({
    required String guid,
    required RequestMethod method,
    required RequestStatus status,
    this.queryParams = const Value.absent(),
    required String url,
    this.body = const Value.absent(),
    this.headers = const Value.absent(),
    this.response = const Value.absent(),
    this.error = const Value.absent(),
    this.statusCode = const Value.absent(),
    this.extra = const Value.absent(),
    required DateTime createdAt,
  })  : guid = Value(guid),
        method = Value(method),
        status = Value(status),
        url = Value(url),
        createdAt = Value(createdAt);
  static Insertable<Request> custom({
    Expression<String>? guid,
    Expression<int>? method,
    Expression<int>? status,
    Expression<String>? queryParams,
    Expression<String>? url,
    Expression<String>? body,
    Expression<String>? headers,
    Expression<String>? response,
    Expression<String>? error,
    Expression<int>? statusCode,
    Expression<String>? extra,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (guid != null) 'guid': guid,
      if (method != null) 'method': method,
      if (status != null) 'status': status,
      if (queryParams != null) 'query_params': queryParams,
      if (url != null) 'url': url,
      if (body != null) 'body': body,
      if (headers != null) 'headers': headers,
      if (response != null) 'response': response,
      if (error != null) 'error': error,
      if (statusCode != null) 'status_code': statusCode,
      if (extra != null) 'extra': extra,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RequestsCompanion copyWith(
      {Value<String>? guid,
      Value<RequestMethod>? method,
      Value<RequestStatus>? status,
      Value<String?>? queryParams,
      Value<String>? url,
      Value<String?>? body,
      Value<String?>? headers,
      Value<String?>? response,
      Value<String?>? error,
      Value<int?>? statusCode,
      Value<String?>? extra,
      Value<DateTime>? createdAt}) {
    return RequestsCompanion(
      guid: guid ?? this.guid,
      method: method ?? this.method,
      status: status ?? this.status,
      queryParams: queryParams ?? this.queryParams,
      url: url ?? this.url,
      body: body ?? this.body,
      headers: headers ?? this.headers,
      response: response ?? this.response,
      error: error ?? this.error,
      statusCode: statusCode ?? this.statusCode,
      extra: extra ?? this.extra,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (guid.present) {
      map['guid'] = Variable<String>(guid.value);
    }
    if (method.present) {
      final converter = $RequestsTable.$convertermethod;
      map['method'] = Variable<int>(converter.toSql(method.value));
    }
    if (status.present) {
      final converter = $RequestsTable.$converterstatus;
      map['status'] = Variable<int>(converter.toSql(status.value));
    }
    if (queryParams.present) {
      map['query_params'] = Variable<String>(queryParams.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (headers.present) {
      map['headers'] = Variable<String>(headers.value);
    }
    if (response.present) {
      map['response'] = Variable<String>(response.value);
    }
    if (error.present) {
      map['error'] = Variable<String>(error.value);
    }
    if (statusCode.present) {
      map['status_code'] = Variable<int>(statusCode.value);
    }
    if (extra.present) {
      map['extra'] = Variable<String>(extra.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RequestsCompanion(')
          ..write('guid: $guid, ')
          ..write('method: $method, ')
          ..write('status: $status, ')
          ..write('queryParams: $queryParams, ')
          ..write('url: $url, ')
          ..write('body: $body, ')
          ..write('headers: $headers, ')
          ..write('response: $response, ')
          ..write('error: $error, ')
          ..write('statusCode: $statusCode, ')
          ..write('extra: $extra, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$RequestsDatabase extends GeneratedDatabase {
  _$RequestsDatabase(QueryExecutor e) : super(e);
  late final $RequestsTable requests = $RequestsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [requests];
}
