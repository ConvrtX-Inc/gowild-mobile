// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_many_notification_response_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetManyNotificationResponseDto extends GetManyNotificationResponseDto {
  @override
  final BuiltList<Notification> data;
  @override
  final num count;
  @override
  final num total;
  @override
  final num page;
  @override
  final num pageCount;

  factory _$GetManyNotificationResponseDto(
          [void Function(GetManyNotificationResponseDtoBuilder)? updates]) =>
      (new GetManyNotificationResponseDtoBuilder()..update(updates))._build();

  _$GetManyNotificationResponseDto._(
      {required this.data,
      required this.count,
      required this.total,
      required this.page,
      required this.pageCount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'GetManyNotificationResponseDto', 'data');
    BuiltValueNullFieldError.checkNotNull(
        count, r'GetManyNotificationResponseDto', 'count');
    BuiltValueNullFieldError.checkNotNull(
        total, r'GetManyNotificationResponseDto', 'total');
    BuiltValueNullFieldError.checkNotNull(
        page, r'GetManyNotificationResponseDto', 'page');
    BuiltValueNullFieldError.checkNotNull(
        pageCount, r'GetManyNotificationResponseDto', 'pageCount');
  }

  @override
  GetManyNotificationResponseDto rebuild(
          void Function(GetManyNotificationResponseDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetManyNotificationResponseDtoBuilder toBuilder() =>
      new GetManyNotificationResponseDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetManyNotificationResponseDto &&
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
    return (newBuiltValueToStringHelper(r'GetManyNotificationResponseDto')
          ..add('data', data)
          ..add('count', count)
          ..add('total', total)
          ..add('page', page)
          ..add('pageCount', pageCount))
        .toString();
  }
}

class GetManyNotificationResponseDtoBuilder
    implements
        Builder<GetManyNotificationResponseDto,
            GetManyNotificationResponseDtoBuilder> {
  _$GetManyNotificationResponseDto? _$v;

  ListBuilder<Notification>? _data;
  ListBuilder<Notification> get data =>
      _$this._data ??= new ListBuilder<Notification>();
  set data(ListBuilder<Notification>? data) => _$this._data = data;

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

  GetManyNotificationResponseDtoBuilder() {
    GetManyNotificationResponseDto._defaults(this);
  }

  GetManyNotificationResponseDtoBuilder get _$this {
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
  void replace(GetManyNotificationResponseDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetManyNotificationResponseDto;
  }

  @override
  void update(void Function(GetManyNotificationResponseDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetManyNotificationResponseDto build() => _build();

  _$GetManyNotificationResponseDto _build() {
    _$GetManyNotificationResponseDto _$result;
    try {
      _$result = _$v ??
          new _$GetManyNotificationResponseDto._(
              data: data.build(),
              count: BuiltValueNullFieldError.checkNotNull(
                  count, r'GetManyNotificationResponseDto', 'count'),
              total: BuiltValueNullFieldError.checkNotNull(
                  total, r'GetManyNotificationResponseDto', 'total'),
              page: BuiltValueNullFieldError.checkNotNull(
                  page, r'GetManyNotificationResponseDto', 'page'),
              pageCount: BuiltValueNullFieldError.checkNotNull(
                  pageCount, r'GetManyNotificationResponseDto', 'pageCount'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GetManyNotificationResponseDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
