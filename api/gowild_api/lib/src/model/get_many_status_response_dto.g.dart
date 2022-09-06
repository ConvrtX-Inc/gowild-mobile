// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_many_status_response_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetManyStatusResponseDto extends GetManyStatusResponseDto {
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

  factory _$GetManyStatusResponseDto(
          [void Function(GetManyStatusResponseDtoBuilder)? updates]) =>
      (new GetManyStatusResponseDtoBuilder()..update(updates))._build();

  _$GetManyStatusResponseDto._(
      {required this.data,
      required this.count,
      required this.total,
      required this.page,
      required this.pageCount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'GetManyStatusResponseDto', 'data');
    BuiltValueNullFieldError.checkNotNull(
        count, r'GetManyStatusResponseDto', 'count');
    BuiltValueNullFieldError.checkNotNull(
        total, r'GetManyStatusResponseDto', 'total');
    BuiltValueNullFieldError.checkNotNull(
        page, r'GetManyStatusResponseDto', 'page');
    BuiltValueNullFieldError.checkNotNull(
        pageCount, r'GetManyStatusResponseDto', 'pageCount');
  }

  @override
  GetManyStatusResponseDto rebuild(
          void Function(GetManyStatusResponseDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetManyStatusResponseDtoBuilder toBuilder() =>
      new GetManyStatusResponseDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetManyStatusResponseDto &&
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
    return (newBuiltValueToStringHelper(r'GetManyStatusResponseDto')
          ..add('data', data)
          ..add('count', count)
          ..add('total', total)
          ..add('page', page)
          ..add('pageCount', pageCount))
        .toString();
  }
}

class GetManyStatusResponseDtoBuilder
    implements
        Builder<GetManyStatusResponseDto, GetManyStatusResponseDtoBuilder> {
  _$GetManyStatusResponseDto? _$v;

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

  GetManyStatusResponseDtoBuilder() {
    GetManyStatusResponseDto._defaults(this);
  }

  GetManyStatusResponseDtoBuilder get _$this {
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
  void replace(GetManyStatusResponseDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetManyStatusResponseDto;
  }

  @override
  void update(void Function(GetManyStatusResponseDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetManyStatusResponseDto build() => _build();

  _$GetManyStatusResponseDto _build() {
    _$GetManyStatusResponseDto _$result;
    try {
      _$result = _$v ??
          new _$GetManyStatusResponseDto._(
              data: data.build(),
              count: BuiltValueNullFieldError.checkNotNull(
                  count, r'GetManyStatusResponseDto', 'count'),
              total: BuiltValueNullFieldError.checkNotNull(
                  total, r'GetManyStatusResponseDto', 'total'),
              page: BuiltValueNullFieldError.checkNotNull(
                  page, r'GetManyStatusResponseDto', 'page'),
              pageCount: BuiltValueNullFieldError.checkNotNull(
                  pageCount, r'GetManyStatusResponseDto', 'pageCount'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GetManyStatusResponseDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
