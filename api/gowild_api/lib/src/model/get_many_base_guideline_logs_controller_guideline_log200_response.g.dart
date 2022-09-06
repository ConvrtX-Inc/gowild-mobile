// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_many_base_guideline_logs_controller_guideline_log200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetManyBaseGuidelineLogsControllerGuidelineLog200Response
    extends GetManyBaseGuidelineLogsControllerGuidelineLog200Response {
  @override
  final BuiltList<GuidelineLog> data;
  @override
  final num count;
  @override
  final num total;
  @override
  final num page;
  @override
  final num pageCount;

  factory _$GetManyBaseGuidelineLogsControllerGuidelineLog200Response(
          [void Function(
                  GetManyBaseGuidelineLogsControllerGuidelineLog200ResponseBuilder)?
              updates]) =>
      (new GetManyBaseGuidelineLogsControllerGuidelineLog200ResponseBuilder()
            ..update(updates))
          ._build();

  _$GetManyBaseGuidelineLogsControllerGuidelineLog200Response._(
      {required this.data,
      required this.count,
      required this.total,
      required this.page,
      required this.pageCount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(data,
        r'GetManyBaseGuidelineLogsControllerGuidelineLog200Response', 'data');
    BuiltValueNullFieldError.checkNotNull(count,
        r'GetManyBaseGuidelineLogsControllerGuidelineLog200Response', 'count');
    BuiltValueNullFieldError.checkNotNull(total,
        r'GetManyBaseGuidelineLogsControllerGuidelineLog200Response', 'total');
    BuiltValueNullFieldError.checkNotNull(page,
        r'GetManyBaseGuidelineLogsControllerGuidelineLog200Response', 'page');
    BuiltValueNullFieldError.checkNotNull(
        pageCount,
        r'GetManyBaseGuidelineLogsControllerGuidelineLog200Response',
        'pageCount');
  }

  @override
  GetManyBaseGuidelineLogsControllerGuidelineLog200Response rebuild(
          void Function(
                  GetManyBaseGuidelineLogsControllerGuidelineLog200ResponseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetManyBaseGuidelineLogsControllerGuidelineLog200ResponseBuilder
      toBuilder() =>
          new GetManyBaseGuidelineLogsControllerGuidelineLog200ResponseBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetManyBaseGuidelineLogsControllerGuidelineLog200Response &&
        data == other.data &&
        count == other.count &&
        total == other.total &&
        page == other.page &&
        pageCount == other.pageCount;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, data.hashCode), count.hashCode), total.hashCode),
            page.hashCode),
        pageCount.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GetManyBaseGuidelineLogsControllerGuidelineLog200Response')
          ..add('data', data)
          ..add('count', count)
          ..add('total', total)
          ..add('page', page)
          ..add('pageCount', pageCount))
        .toString();
  }
}

class GetManyBaseGuidelineLogsControllerGuidelineLog200ResponseBuilder
    implements
        Builder<GetManyBaseGuidelineLogsControllerGuidelineLog200Response,
            GetManyBaseGuidelineLogsControllerGuidelineLog200ResponseBuilder> {
  _$GetManyBaseGuidelineLogsControllerGuidelineLog200Response? _$v;

  ListBuilder<GuidelineLog>? _data;
  ListBuilder<GuidelineLog> get data =>
      _$this._data ??= new ListBuilder<GuidelineLog>();
  set data(ListBuilder<GuidelineLog>? data) => _$this._data = data;

  num? _count;
  num? get count => _$this._count;
  set count(num? count) => _$this._count = count;

  num? _total;
  num? get total => _$this._total;
  set total(num? total) => _$this._total = total;

  num? _page;
  num? get page => _$this._page;
  set page(num? page) => _$this._page = page;

  num? _pageCount;
  num? get pageCount => _$this._pageCount;
  set pageCount(num? pageCount) => _$this._pageCount = pageCount;

  GetManyBaseGuidelineLogsControllerGuidelineLog200ResponseBuilder() {
    GetManyBaseGuidelineLogsControllerGuidelineLog200Response._defaults(this);
  }

  GetManyBaseGuidelineLogsControllerGuidelineLog200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _count = $v.count;
      _total = $v.total;
      _page = $v.page;
      _pageCount = $v.pageCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GetManyBaseGuidelineLogsControllerGuidelineLog200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetManyBaseGuidelineLogsControllerGuidelineLog200Response;
  }

  @override
  void update(
      void Function(
              GetManyBaseGuidelineLogsControllerGuidelineLog200ResponseBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GetManyBaseGuidelineLogsControllerGuidelineLog200Response build() => _build();

  _$GetManyBaseGuidelineLogsControllerGuidelineLog200Response _build() {
    _$GetManyBaseGuidelineLogsControllerGuidelineLog200Response _$result;
    try {
      _$result = _$v ??
          new _$GetManyBaseGuidelineLogsControllerGuidelineLog200Response._(
              data: data.build(),
              count: BuiltValueNullFieldError.checkNotNull(
                  count,
                  r'GetManyBaseGuidelineLogsControllerGuidelineLog200Response',
                  'count'),
              total: BuiltValueNullFieldError.checkNotNull(
                  total,
                  r'GetManyBaseGuidelineLogsControllerGuidelineLog200Response',
                  'total'),
              page: BuiltValueNullFieldError.checkNotNull(
                  page,
                  r'GetManyBaseGuidelineLogsControllerGuidelineLog200Response',
                  'page'),
              pageCount: BuiltValueNullFieldError.checkNotNull(
                  pageCount,
                  r'GetManyBaseGuidelineLogsControllerGuidelineLog200Response',
                  'pageCount'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GetManyBaseGuidelineLogsControllerGuidelineLog200Response',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
