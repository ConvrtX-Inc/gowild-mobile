// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_many_ticket_message_response_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetManyTicketMessageResponseDto
    extends GetManyTicketMessageResponseDto {
  @override
  final BuiltList<TicketMessage> data;
  @override
  final num count;
  @override
  final num total;
  @override
  final num page;
  @override
  final num pageCount;

  factory _$GetManyTicketMessageResponseDto(
          [void Function(GetManyTicketMessageResponseDtoBuilder)? updates]) =>
      (new GetManyTicketMessageResponseDtoBuilder()..update(updates))._build();

  _$GetManyTicketMessageResponseDto._(
      {required this.data,
      required this.count,
      required this.total,
      required this.page,
      required this.pageCount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'GetManyTicketMessageResponseDto', 'data');
    BuiltValueNullFieldError.checkNotNull(
        count, r'GetManyTicketMessageResponseDto', 'count');
    BuiltValueNullFieldError.checkNotNull(
        total, r'GetManyTicketMessageResponseDto', 'total');
    BuiltValueNullFieldError.checkNotNull(
        page, r'GetManyTicketMessageResponseDto', 'page');
    BuiltValueNullFieldError.checkNotNull(
        pageCount, r'GetManyTicketMessageResponseDto', 'pageCount');
  }

  @override
  GetManyTicketMessageResponseDto rebuild(
          void Function(GetManyTicketMessageResponseDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetManyTicketMessageResponseDtoBuilder toBuilder() =>
      new GetManyTicketMessageResponseDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetManyTicketMessageResponseDto &&
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
    return (newBuiltValueToStringHelper(r'GetManyTicketMessageResponseDto')
          ..add('data', data)
          ..add('count', count)
          ..add('total', total)
          ..add('page', page)
          ..add('pageCount', pageCount))
        .toString();
  }
}

class GetManyTicketMessageResponseDtoBuilder
    implements
        Builder<GetManyTicketMessageResponseDto,
            GetManyTicketMessageResponseDtoBuilder> {
  _$GetManyTicketMessageResponseDto? _$v;

  ListBuilder<TicketMessage>? _data;
  ListBuilder<TicketMessage> get data =>
      _$this._data ??= new ListBuilder<TicketMessage>();
  set data(ListBuilder<TicketMessage>? data) => _$this._data = data;

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

  GetManyTicketMessageResponseDtoBuilder() {
    GetManyTicketMessageResponseDto._defaults(this);
  }

  GetManyTicketMessageResponseDtoBuilder get _$this {
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
  void replace(GetManyTicketMessageResponseDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetManyTicketMessageResponseDto;
  }

  @override
  void update(void Function(GetManyTicketMessageResponseDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetManyTicketMessageResponseDto build() => _build();

  _$GetManyTicketMessageResponseDto _build() {
    _$GetManyTicketMessageResponseDto _$result;
    try {
      _$result = _$v ??
          new _$GetManyTicketMessageResponseDto._(
              data: data.build(),
              count: BuiltValueNullFieldError.checkNotNull(
                  count, r'GetManyTicketMessageResponseDto', 'count'),
              total: BuiltValueNullFieldError.checkNotNull(
                  total, r'GetManyTicketMessageResponseDto', 'total'),
              page: BuiltValueNullFieldError.checkNotNull(
                  page, r'GetManyTicketMessageResponseDto', 'page'),
              pageCount: BuiltValueNullFieldError.checkNotNull(
                  pageCount, r'GetManyTicketMessageResponseDto', 'pageCount'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GetManyTicketMessageResponseDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
