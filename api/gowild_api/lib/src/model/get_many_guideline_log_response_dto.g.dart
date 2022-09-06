// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_many_guideline_log_response_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetManyGuidelineLogResponseDto extends GetManyGuidelineLogResponseDto {
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

  factory _$GetManyGuidelineLogResponseDto(
          [void Function(GetManyGuidelineLogResponseDtoBuilder)? updates]) =>
      (new GetManyGuidelineLogResponseDtoBuilder()..update(updates))._build();

  _$GetManyGuidelineLogResponseDto._(
      {required this.data,
      required this.count,
      required this.total,
      required this.page,
      required this.pageCount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'GetManyGuidelineLogResponseDto', 'data');
    BuiltValueNullFieldError.checkNotNull(
        count, r'GetManyGuidelineLogResponseDto', 'count');
    BuiltValueNullFieldError.checkNotNull(
        total, r'GetManyGuidelineLogResponseDto', 'total');
    BuiltValueNullFieldError.checkNotNull(
        page, r'GetManyGuidelineLogResponseDto', 'page');
    BuiltValueNullFieldError.checkNotNull(
        pageCount, r'GetManyGuidelineLogResponseDto', 'pageCount');
  }

  @override
  GetManyGuidelineLogResponseDto rebuild(
          void Function(GetManyGuidelineLogResponseDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetManyGuidelineLogResponseDtoBuilder toBuilder() =>
      new GetManyGuidelineLogResponseDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetManyGuidelineLogResponseDto &&
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
    return (newBuiltValueToStringHelper(r'GetManyGuidelineLogResponseDto')
          ..add('data', data)
          ..add('count', count)
          ..add('total', total)
          ..add('page', page)
          ..add('pageCount', pageCount))
        .toString();
  }
}

class GetManyGuidelineLogResponseDtoBuilder
    implements
        Builder<GetManyGuidelineLogResponseDto,
            GetManyGuidelineLogResponseDtoBuilder> {
  _$GetManyGuidelineLogResponseDto? _$v;

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

  GetManyGuidelineLogResponseDtoBuilder() {
    GetManyGuidelineLogResponseDto._defaults(this);
  }

  GetManyGuidelineLogResponseDtoBuilder get _$this {
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
  void replace(GetManyGuidelineLogResponseDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetManyGuidelineLogResponseDto;
  }

  @override
  void update(void Function(GetManyGuidelineLogResponseDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetManyGuidelineLogResponseDto build() => _build();

  _$GetManyGuidelineLogResponseDto _build() {
    _$GetManyGuidelineLogResponseDto _$result;
    try {
      _$result = _$v ??
          new _$GetManyGuidelineLogResponseDto._(
              data: data.build(),
              count: BuiltValueNullFieldError.checkNotNull(
                  count, r'GetManyGuidelineLogResponseDto', 'count'),
              total: BuiltValueNullFieldError.checkNotNull(
                  total, r'GetManyGuidelineLogResponseDto', 'total'),
              page: BuiltValueNullFieldError.checkNotNull(
                  page, r'GetManyGuidelineLogResponseDto', 'page'),
              pageCount: BuiltValueNullFieldError.checkNotNull(
                  pageCount, r'GetManyGuidelineLogResponseDto', 'pageCount'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GetManyGuidelineLogResponseDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
