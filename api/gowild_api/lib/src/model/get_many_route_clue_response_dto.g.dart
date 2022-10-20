// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_many_route_clue_response_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetManyRouteClueResponseDto extends GetManyRouteClueResponseDto {
  @override
  final BuiltList<RouteClue> data;
  @override
  final num count;
  @override
  final num total;
  @override
  final num page;
  @override
  final num pageCount;

  factory _$GetManyRouteClueResponseDto(
          [void Function(GetManyRouteClueResponseDtoBuilder)? updates]) =>
      (new GetManyRouteClueResponseDtoBuilder()..update(updates))._build();

  _$GetManyRouteClueResponseDto._(
      {required this.data,
      required this.count,
      required this.total,
      required this.page,
      required this.pageCount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'GetManyRouteClueResponseDto', 'data');
    BuiltValueNullFieldError.checkNotNull(
        count, r'GetManyRouteClueResponseDto', 'count');
    BuiltValueNullFieldError.checkNotNull(
        total, r'GetManyRouteClueResponseDto', 'total');
    BuiltValueNullFieldError.checkNotNull(
        page, r'GetManyRouteClueResponseDto', 'page');
    BuiltValueNullFieldError.checkNotNull(
        pageCount, r'GetManyRouteClueResponseDto', 'pageCount');
  }

  @override
  GetManyRouteClueResponseDto rebuild(
          void Function(GetManyRouteClueResponseDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetManyRouteClueResponseDtoBuilder toBuilder() =>
      new GetManyRouteClueResponseDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetManyRouteClueResponseDto &&
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
    return (newBuiltValueToStringHelper(r'GetManyRouteClueResponseDto')
          ..add('data', data)
          ..add('count', count)
          ..add('total', total)
          ..add('page', page)
          ..add('pageCount', pageCount))
        .toString();
  }
}

class GetManyRouteClueResponseDtoBuilder
    implements
        Builder<GetManyRouteClueResponseDto,
            GetManyRouteClueResponseDtoBuilder> {
  _$GetManyRouteClueResponseDto? _$v;

  ListBuilder<RouteClue>? _data;
  ListBuilder<RouteClue> get data =>
      _$this._data ??= new ListBuilder<RouteClue>();
  set data(ListBuilder<RouteClue>? data) => _$this._data = data;

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

  GetManyRouteClueResponseDtoBuilder() {
    GetManyRouteClueResponseDto._defaults(this);
  }

  GetManyRouteClueResponseDtoBuilder get _$this {
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
  void replace(GetManyRouteClueResponseDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetManyRouteClueResponseDto;
  }

  @override
  void update(void Function(GetManyRouteClueResponseDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetManyRouteClueResponseDto build() => _build();

  _$GetManyRouteClueResponseDto _build() {
    _$GetManyRouteClueResponseDto _$result;
    try {
      _$result = _$v ??
          new _$GetManyRouteClueResponseDto._(
              data: data.build(),
              count: BuiltValueNullFieldError.checkNotNull(
                  count, r'GetManyRouteClueResponseDto', 'count'),
              total: BuiltValueNullFieldError.checkNotNull(
                  total, r'GetManyRouteClueResponseDto', 'total'),
              page: BuiltValueNullFieldError.checkNotNull(
                  page, r'GetManyRouteClueResponseDto', 'page'),
              pageCount: BuiltValueNullFieldError.checkNotNull(
                  pageCount, r'GetManyRouteClueResponseDto', 'pageCount'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GetManyRouteClueResponseDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
