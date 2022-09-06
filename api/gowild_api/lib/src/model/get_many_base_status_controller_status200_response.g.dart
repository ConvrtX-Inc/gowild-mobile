// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_many_base_status_controller_status200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetManyBaseStatusControllerStatus200Response
    extends GetManyBaseStatusControllerStatus200Response {
  @override
  final BuiltList<Status> data;
  @override
  final num count;
  @override
  final num total;
  @override
  final num page;
  @override
  final num pageCount;

  factory _$GetManyBaseStatusControllerStatus200Response(
          [void Function(GetManyBaseStatusControllerStatus200ResponseBuilder)?
              updates]) =>
      (new GetManyBaseStatusControllerStatus200ResponseBuilder()
            ..update(updates))
          ._build();

  _$GetManyBaseStatusControllerStatus200Response._(
      {required this.data,
      required this.count,
      required this.total,
      required this.page,
      required this.pageCount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'GetManyBaseStatusControllerStatus200Response', 'data');
    BuiltValueNullFieldError.checkNotNull(
        count, r'GetManyBaseStatusControllerStatus200Response', 'count');
    BuiltValueNullFieldError.checkNotNull(
        total, r'GetManyBaseStatusControllerStatus200Response', 'total');
    BuiltValueNullFieldError.checkNotNull(
        page, r'GetManyBaseStatusControllerStatus200Response', 'page');
    BuiltValueNullFieldError.checkNotNull(pageCount,
        r'GetManyBaseStatusControllerStatus200Response', 'pageCount');
  }

  @override
  GetManyBaseStatusControllerStatus200Response rebuild(
          void Function(GetManyBaseStatusControllerStatus200ResponseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetManyBaseStatusControllerStatus200ResponseBuilder toBuilder() =>
      new GetManyBaseStatusControllerStatus200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetManyBaseStatusControllerStatus200Response &&
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
            r'GetManyBaseStatusControllerStatus200Response')
          ..add('data', data)
          ..add('count', count)
          ..add('total', total)
          ..add('page', page)
          ..add('pageCount', pageCount))
        .toString();
  }
}

class GetManyBaseStatusControllerStatus200ResponseBuilder
    implements
        Builder<GetManyBaseStatusControllerStatus200Response,
            GetManyBaseStatusControllerStatus200ResponseBuilder> {
  _$GetManyBaseStatusControllerStatus200Response? _$v;

  ListBuilder<Status>? _data;
  ListBuilder<Status> get data => _$this._data ??= new ListBuilder<Status>();
  set data(ListBuilder<Status>? data) => _$this._data = data;

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

  GetManyBaseStatusControllerStatus200ResponseBuilder() {
    GetManyBaseStatusControllerStatus200Response._defaults(this);
  }

  GetManyBaseStatusControllerStatus200ResponseBuilder get _$this {
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
  void replace(GetManyBaseStatusControllerStatus200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetManyBaseStatusControllerStatus200Response;
  }

  @override
  void update(
      void Function(GetManyBaseStatusControllerStatus200ResponseBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GetManyBaseStatusControllerStatus200Response build() => _build();

  _$GetManyBaseStatusControllerStatus200Response _build() {
    _$GetManyBaseStatusControllerStatus200Response _$result;
    try {
      _$result = _$v ??
          new _$GetManyBaseStatusControllerStatus200Response._(
              data: data.build(),
              count: BuiltValueNullFieldError.checkNotNull(count,
                  r'GetManyBaseStatusControllerStatus200Response', 'count'),
              total: BuiltValueNullFieldError.checkNotNull(total,
                  r'GetManyBaseStatusControllerStatus200Response', 'total'),
              page: BuiltValueNullFieldError.checkNotNull(page,
                  r'GetManyBaseStatusControllerStatus200Response', 'page'),
              pageCount: BuiltValueNullFieldError.checkNotNull(
                  pageCount,
                  r'GetManyBaseStatusControllerStatus200Response',
                  'pageCount'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GetManyBaseStatusControllerStatus200Response',
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
