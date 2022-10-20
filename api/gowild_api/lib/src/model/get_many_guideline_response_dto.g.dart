// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_many_guideline_response_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetManyGuidelineResponseDto extends GetManyGuidelineResponseDto {
  @override
  final BuiltList<Guideline> data;
  @override
  final num count;
  @override
  final num total;
  @override
  final num page;
  @override
  final num pageCount;

  factory _$GetManyGuidelineResponseDto(
          [void Function(GetManyGuidelineResponseDtoBuilder)? updates]) =>
      (new GetManyGuidelineResponseDtoBuilder()..update(updates))._build();

  _$GetManyGuidelineResponseDto._(
      {required this.data,
      required this.count,
      required this.total,
      required this.page,
      required this.pageCount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'GetManyGuidelineResponseDto', 'data');
    BuiltValueNullFieldError.checkNotNull(
        count, r'GetManyGuidelineResponseDto', 'count');
    BuiltValueNullFieldError.checkNotNull(
        total, r'GetManyGuidelineResponseDto', 'total');
    BuiltValueNullFieldError.checkNotNull(
        page, r'GetManyGuidelineResponseDto', 'page');
    BuiltValueNullFieldError.checkNotNull(
        pageCount, r'GetManyGuidelineResponseDto', 'pageCount');
  }

  @override
  GetManyGuidelineResponseDto rebuild(
          void Function(GetManyGuidelineResponseDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetManyGuidelineResponseDtoBuilder toBuilder() =>
      new GetManyGuidelineResponseDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetManyGuidelineResponseDto &&
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
    return (newBuiltValueToStringHelper(r'GetManyGuidelineResponseDto')
          ..add('data', data)
          ..add('count', count)
          ..add('total', total)
          ..add('page', page)
          ..add('pageCount', pageCount))
        .toString();
  }
}

class GetManyGuidelineResponseDtoBuilder
    implements
        Builder<GetManyGuidelineResponseDto,
            GetManyGuidelineResponseDtoBuilder> {
  _$GetManyGuidelineResponseDto? _$v;

  ListBuilder<Guideline>? _data;
  ListBuilder<Guideline> get data =>
      _$this._data ??= new ListBuilder<Guideline>();
  set data(ListBuilder<Guideline>? data) => _$this._data = data;

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

  GetManyGuidelineResponseDtoBuilder() {
    GetManyGuidelineResponseDto._defaults(this);
  }

  GetManyGuidelineResponseDtoBuilder get _$this {
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
  void replace(GetManyGuidelineResponseDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetManyGuidelineResponseDto;
  }

  @override
  void update(void Function(GetManyGuidelineResponseDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetManyGuidelineResponseDto build() => _build();

  _$GetManyGuidelineResponseDto _build() {
    _$GetManyGuidelineResponseDto _$result;
    try {
      _$result = _$v ??
          new _$GetManyGuidelineResponseDto._(
              data: data.build(),
              count: BuiltValueNullFieldError.checkNotNull(
                  count, r'GetManyGuidelineResponseDto', 'count'),
              total: BuiltValueNullFieldError.checkNotNull(
                  total, r'GetManyGuidelineResponseDto', 'total'),
              page: BuiltValueNullFieldError.checkNotNull(
                  page, r'GetManyGuidelineResponseDto', 'page'),
              pageCount: BuiltValueNullFieldError.checkNotNull(
                  pageCount, r'GetManyGuidelineResponseDto', 'pageCount'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GetManyGuidelineResponseDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
