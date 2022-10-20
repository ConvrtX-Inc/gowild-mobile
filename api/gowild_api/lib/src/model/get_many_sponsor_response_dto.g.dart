// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_many_sponsor_response_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetManySponsorResponseDto extends GetManySponsorResponseDto {
  @override
  final BuiltList<Sponsor> data;
  @override
  final num count;
  @override
  final num total;
  @override
  final num page;
  @override
  final num pageCount;

  factory _$GetManySponsorResponseDto(
          [void Function(GetManySponsorResponseDtoBuilder)? updates]) =>
      (new GetManySponsorResponseDtoBuilder()..update(updates))._build();

  _$GetManySponsorResponseDto._(
      {required this.data,
      required this.count,
      required this.total,
      required this.page,
      required this.pageCount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'GetManySponsorResponseDto', 'data');
    BuiltValueNullFieldError.checkNotNull(
        count, r'GetManySponsorResponseDto', 'count');
    BuiltValueNullFieldError.checkNotNull(
        total, r'GetManySponsorResponseDto', 'total');
    BuiltValueNullFieldError.checkNotNull(
        page, r'GetManySponsorResponseDto', 'page');
    BuiltValueNullFieldError.checkNotNull(
        pageCount, r'GetManySponsorResponseDto', 'pageCount');
  }

  @override
  GetManySponsorResponseDto rebuild(
          void Function(GetManySponsorResponseDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetManySponsorResponseDtoBuilder toBuilder() =>
      new GetManySponsorResponseDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetManySponsorResponseDto &&
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
    return (newBuiltValueToStringHelper(r'GetManySponsorResponseDto')
          ..add('data', data)
          ..add('count', count)
          ..add('total', total)
          ..add('page', page)
          ..add('pageCount', pageCount))
        .toString();
  }
}

class GetManySponsorResponseDtoBuilder
    implements
        Builder<GetManySponsorResponseDto, GetManySponsorResponseDtoBuilder> {
  _$GetManySponsorResponseDto? _$v;

  ListBuilder<Sponsor>? _data;
  ListBuilder<Sponsor> get data => _$this._data ??= new ListBuilder<Sponsor>();
  set data(ListBuilder<Sponsor>? data) => _$this._data = data;

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

  GetManySponsorResponseDtoBuilder() {
    GetManySponsorResponseDto._defaults(this);
  }

  GetManySponsorResponseDtoBuilder get _$this {
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
  void replace(GetManySponsorResponseDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetManySponsorResponseDto;
  }

  @override
  void update(void Function(GetManySponsorResponseDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetManySponsorResponseDto build() => _build();

  _$GetManySponsorResponseDto _build() {
    _$GetManySponsorResponseDto _$result;
    try {
      _$result = _$v ??
          new _$GetManySponsorResponseDto._(
              data: data.build(),
              count: BuiltValueNullFieldError.checkNotNull(
                  count, r'GetManySponsorResponseDto', 'count'),
              total: BuiltValueNullFieldError.checkNotNull(
                  total, r'GetManySponsorResponseDto', 'total'),
              page: BuiltValueNullFieldError.checkNotNull(
                  page, r'GetManySponsorResponseDto', 'page'),
              pageCount: BuiltValueNullFieldError.checkNotNull(
                  pageCount, r'GetManySponsorResponseDto', 'pageCount'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GetManySponsorResponseDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
