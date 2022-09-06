// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_many_base_comment_controller_comment200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetManyBaseCommentControllerComment200Response
    extends GetManyBaseCommentControllerComment200Response {
  @override
  final BuiltList<Comment> data;
  @override
  final num count;
  @override
  final num total;
  @override
  final num page;
  @override
  final num pageCount;

  factory _$GetManyBaseCommentControllerComment200Response(
          [void Function(GetManyBaseCommentControllerComment200ResponseBuilder)?
              updates]) =>
      (new GetManyBaseCommentControllerComment200ResponseBuilder()
            ..update(updates))
          ._build();

  _$GetManyBaseCommentControllerComment200Response._(
      {required this.data,
      required this.count,
      required this.total,
      required this.page,
      required this.pageCount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        data, r'GetManyBaseCommentControllerComment200Response', 'data');
    BuiltValueNullFieldError.checkNotNull(
        count, r'GetManyBaseCommentControllerComment200Response', 'count');
    BuiltValueNullFieldError.checkNotNull(
        total, r'GetManyBaseCommentControllerComment200Response', 'total');
    BuiltValueNullFieldError.checkNotNull(
        page, r'GetManyBaseCommentControllerComment200Response', 'page');
    BuiltValueNullFieldError.checkNotNull(pageCount,
        r'GetManyBaseCommentControllerComment200Response', 'pageCount');
  }

  @override
  GetManyBaseCommentControllerComment200Response rebuild(
          void Function(GetManyBaseCommentControllerComment200ResponseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetManyBaseCommentControllerComment200ResponseBuilder toBuilder() =>
      new GetManyBaseCommentControllerComment200ResponseBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetManyBaseCommentControllerComment200Response &&
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
            r'GetManyBaseCommentControllerComment200Response')
          ..add('data', data)
          ..add('count', count)
          ..add('total', total)
          ..add('page', page)
          ..add('pageCount', pageCount))
        .toString();
  }
}

class GetManyBaseCommentControllerComment200ResponseBuilder
    implements
        Builder<GetManyBaseCommentControllerComment200Response,
            GetManyBaseCommentControllerComment200ResponseBuilder> {
  _$GetManyBaseCommentControllerComment200Response? _$v;

  ListBuilder<Comment>? _data;
  ListBuilder<Comment> get data => _$this._data ??= new ListBuilder<Comment>();
  set data(ListBuilder<Comment>? data) => _$this._data = data;

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

  GetManyBaseCommentControllerComment200ResponseBuilder() {
    GetManyBaseCommentControllerComment200Response._defaults(this);
  }

  GetManyBaseCommentControllerComment200ResponseBuilder get _$this {
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
  void replace(GetManyBaseCommentControllerComment200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetManyBaseCommentControllerComment200Response;
  }

  @override
  void update(
      void Function(GetManyBaseCommentControllerComment200ResponseBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GetManyBaseCommentControllerComment200Response build() => _build();

  _$GetManyBaseCommentControllerComment200Response _build() {
    _$GetManyBaseCommentControllerComment200Response _$result;
    try {
      _$result = _$v ??
          new _$GetManyBaseCommentControllerComment200Response._(
              data: data.build(),
              count: BuiltValueNullFieldError.checkNotNull(count,
                  r'GetManyBaseCommentControllerComment200Response', 'count'),
              total: BuiltValueNullFieldError.checkNotNull(total,
                  r'GetManyBaseCommentControllerComment200Response', 'total'),
              page: BuiltValueNullFieldError.checkNotNull(page,
                  r'GetManyBaseCommentControllerComment200Response', 'page'),
              pageCount: BuiltValueNullFieldError.checkNotNull(
                  pageCount,
                  r'GetManyBaseCommentControllerComment200Response',
                  'pageCount'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GetManyBaseCommentControllerComment200Response',
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
