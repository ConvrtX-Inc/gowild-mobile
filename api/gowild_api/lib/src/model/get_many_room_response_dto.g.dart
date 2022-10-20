// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_many_room_response_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetManyRoomResponseDto extends GetManyRoomResponseDto {
  @override
  final BuiltList<Room> data;
  @override
  final num count;
  @override
  final num total;
  @override
  final num page;
  @override
  final num pageCount;

  factory _$GetManyRoomResponseDto(
          [void Function(GetManyRoomResponseDtoBuilder)? updates]) =>
      (new GetManyRoomResponseDtoBuilder()..update(updates))._build();

  _$GetManyRoomResponseDto._(
      {required this.data,
      required this.count,
      required this.total,
      required this.page,
      required this.pageCount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'GetManyRoomResponseDto', 'data');
    BuiltValueNullFieldError.checkNotNull(
        count, r'GetManyRoomResponseDto', 'count');
    BuiltValueNullFieldError.checkNotNull(
        total, r'GetManyRoomResponseDto', 'total');
    BuiltValueNullFieldError.checkNotNull(
        page, r'GetManyRoomResponseDto', 'page');
    BuiltValueNullFieldError.checkNotNull(
        pageCount, r'GetManyRoomResponseDto', 'pageCount');
  }

  @override
  GetManyRoomResponseDto rebuild(
          void Function(GetManyRoomResponseDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetManyRoomResponseDtoBuilder toBuilder() =>
      new GetManyRoomResponseDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetManyRoomResponseDto &&
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
    return (newBuiltValueToStringHelper(r'GetManyRoomResponseDto')
          ..add('data', data)
          ..add('count', count)
          ..add('total', total)
          ..add('page', page)
          ..add('pageCount', pageCount))
        .toString();
  }
}

class GetManyRoomResponseDtoBuilder
    implements Builder<GetManyRoomResponseDto, GetManyRoomResponseDtoBuilder> {
  _$GetManyRoomResponseDto? _$v;

  ListBuilder<Room>? _data;
  ListBuilder<Room> get data => _$this._data ??= new ListBuilder<Room>();
  set data(ListBuilder<Room>? data) => _$this._data = data;

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

  GetManyRoomResponseDtoBuilder() {
    GetManyRoomResponseDto._defaults(this);
  }

  GetManyRoomResponseDtoBuilder get _$this {
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
  void replace(GetManyRoomResponseDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetManyRoomResponseDto;
  }

  @override
  void update(void Function(GetManyRoomResponseDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetManyRoomResponseDto build() => _build();

  _$GetManyRoomResponseDto _build() {
    _$GetManyRoomResponseDto _$result;
    try {
      _$result = _$v ??
          new _$GetManyRoomResponseDto._(
              data: data.build(),
              count: BuiltValueNullFieldError.checkNotNull(
                  count, r'GetManyRoomResponseDto', 'count'),
              total: BuiltValueNullFieldError.checkNotNull(
                  total, r'GetManyRoomResponseDto', 'total'),
              page: BuiltValueNullFieldError.checkNotNull(
                  page, r'GetManyRoomResponseDto', 'page'),
              pageCount: BuiltValueNullFieldError.checkNotNull(
                  pageCount, r'GetManyRoomResponseDto', 'pageCount'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GetManyRoomResponseDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
