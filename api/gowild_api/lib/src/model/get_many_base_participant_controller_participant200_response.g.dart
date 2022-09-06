// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_many_base_participant_controller_participant200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetManyBaseParticipantControllerParticipant200Response
    extends GetManyBaseParticipantControllerParticipant200Response {
  @override
  final BuiltList<Participant> data;
  @override
  final num count;
  @override
  final num total;
  @override
  final num page;
  @override
  final num pageCount;

  factory _$GetManyBaseParticipantControllerParticipant200Response(
          [void Function(
                  GetManyBaseParticipantControllerParticipant200ResponseBuilder)?
              updates]) =>
      (new GetManyBaseParticipantControllerParticipant200ResponseBuilder()
            ..update(updates))
          ._build();

  _$GetManyBaseParticipantControllerParticipant200Response._(
      {required this.data,
      required this.count,
      required this.total,
      required this.page,
      required this.pageCount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(data,
        r'GetManyBaseParticipantControllerParticipant200Response', 'data');
    BuiltValueNullFieldError.checkNotNull(count,
        r'GetManyBaseParticipantControllerParticipant200Response', 'count');
    BuiltValueNullFieldError.checkNotNull(total,
        r'GetManyBaseParticipantControllerParticipant200Response', 'total');
    BuiltValueNullFieldError.checkNotNull(page,
        r'GetManyBaseParticipantControllerParticipant200Response', 'page');
    BuiltValueNullFieldError.checkNotNull(pageCount,
        r'GetManyBaseParticipantControllerParticipant200Response', 'pageCount');
  }

  @override
  GetManyBaseParticipantControllerParticipant200Response rebuild(
          void Function(
                  GetManyBaseParticipantControllerParticipant200ResponseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetManyBaseParticipantControllerParticipant200ResponseBuilder toBuilder() =>
      new GetManyBaseParticipantControllerParticipant200ResponseBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetManyBaseParticipantControllerParticipant200Response &&
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
            r'GetManyBaseParticipantControllerParticipant200Response')
          ..add('data', data)
          ..add('count', count)
          ..add('total', total)
          ..add('page', page)
          ..add('pageCount', pageCount))
        .toString();
  }
}

class GetManyBaseParticipantControllerParticipant200ResponseBuilder
    implements
        Builder<GetManyBaseParticipantControllerParticipant200Response,
            GetManyBaseParticipantControllerParticipant200ResponseBuilder> {
  _$GetManyBaseParticipantControllerParticipant200Response? _$v;

  ListBuilder<Participant>? _data;
  ListBuilder<Participant> get data =>
      _$this._data ??= new ListBuilder<Participant>();
  set data(ListBuilder<Participant>? data) => _$this._data = data;

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

  GetManyBaseParticipantControllerParticipant200ResponseBuilder() {
    GetManyBaseParticipantControllerParticipant200Response._defaults(this);
  }

  GetManyBaseParticipantControllerParticipant200ResponseBuilder get _$this {
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
  void replace(GetManyBaseParticipantControllerParticipant200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetManyBaseParticipantControllerParticipant200Response;
  }

  @override
  void update(
      void Function(
              GetManyBaseParticipantControllerParticipant200ResponseBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GetManyBaseParticipantControllerParticipant200Response build() => _build();

  _$GetManyBaseParticipantControllerParticipant200Response _build() {
    _$GetManyBaseParticipantControllerParticipant200Response _$result;
    try {
      _$result = _$v ??
          new _$GetManyBaseParticipantControllerParticipant200Response._(
              data: data.build(),
              count: BuiltValueNullFieldError.checkNotNull(
                  count,
                  r'GetManyBaseParticipantControllerParticipant200Response',
                  'count'),
              total: BuiltValueNullFieldError.checkNotNull(
                  total,
                  r'GetManyBaseParticipantControllerParticipant200Response',
                  'total'),
              page: BuiltValueNullFieldError.checkNotNull(
                  page,
                  r'GetManyBaseParticipantControllerParticipant200Response',
                  'page'),
              pageCount: BuiltValueNullFieldError.checkNotNull(
                  pageCount,
                  r'GetManyBaseParticipantControllerParticipant200Response',
                  'pageCount'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GetManyBaseParticipantControllerParticipant200Response',
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
