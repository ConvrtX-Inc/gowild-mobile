// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_many_currency_response_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetManyCurrencyResponseDto extends GetManyCurrencyResponseDto {
  @override
  final BuiltList<Currency> data;
  @override
  final num count;
  @override
  final num total;
  @override
  final num page;
  @override
  final num pageCount;

  factory _$GetManyCurrencyResponseDto(
          [void Function(GetManyCurrencyResponseDtoBuilder)? updates]) =>
      (new GetManyCurrencyResponseDtoBuilder()..update(updates))._build();

  _$GetManyCurrencyResponseDto._(
      {required this.data,
      required this.count,
      required this.total,
      required this.page,
      required this.pageCount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'GetManyCurrencyResponseDto', 'data');
    BuiltValueNullFieldError.checkNotNull(
        count, r'GetManyCurrencyResponseDto', 'count');
    BuiltValueNullFieldError.checkNotNull(
        total, r'GetManyCurrencyResponseDto', 'total');
    BuiltValueNullFieldError.checkNotNull(
        page, r'GetManyCurrencyResponseDto', 'page');
    BuiltValueNullFieldError.checkNotNull(
        pageCount, r'GetManyCurrencyResponseDto', 'pageCount');
  }

  @override
  GetManyCurrencyResponseDto rebuild(
          void Function(GetManyCurrencyResponseDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetManyCurrencyResponseDtoBuilder toBuilder() =>
      new GetManyCurrencyResponseDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetManyCurrencyResponseDto &&
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
    return (newBuiltValueToStringHelper(r'GetManyCurrencyResponseDto')
          ..add('data', data)
          ..add('count', count)
          ..add('total', total)
          ..add('page', page)
          ..add('pageCount', pageCount))
        .toString();
  }
}

class GetManyCurrencyResponseDtoBuilder
    implements
        Builder<GetManyCurrencyResponseDto, GetManyCurrencyResponseDtoBuilder> {
  _$GetManyCurrencyResponseDto? _$v;

  ListBuilder<Currency>? _data;
  ListBuilder<Currency> get data =>
      _$this._data ??= new ListBuilder<Currency>();
  set data(ListBuilder<Currency>? data) => _$this._data = data;

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

  GetManyCurrencyResponseDtoBuilder() {
    GetManyCurrencyResponseDto._defaults(this);
  }

  GetManyCurrencyResponseDtoBuilder get _$this {
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
  void replace(GetManyCurrencyResponseDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetManyCurrencyResponseDto;
  }

  @override
  void update(void Function(GetManyCurrencyResponseDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetManyCurrencyResponseDto build() => _build();

  _$GetManyCurrencyResponseDto _build() {
    _$GetManyCurrencyResponseDto _$result;
    try {
      _$result = _$v ??
          new _$GetManyCurrencyResponseDto._(
              data: data.build(),
              count: BuiltValueNullFieldError.checkNotNull(
                  count, r'GetManyCurrencyResponseDto', 'count'),
              total: BuiltValueNullFieldError.checkNotNull(
                  total, r'GetManyCurrencyResponseDto', 'total'),
              page: BuiltValueNullFieldError.checkNotNull(
                  page, r'GetManyCurrencyResponseDto', 'page'),
              pageCount: BuiltValueNullFieldError.checkNotNull(
                  pageCount, r'GetManyCurrencyResponseDto', 'pageCount'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GetManyCurrencyResponseDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
