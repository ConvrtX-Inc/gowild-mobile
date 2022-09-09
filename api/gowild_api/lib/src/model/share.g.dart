// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Share extends Share {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final String userId;
  @override
  final String postfeedId;
  @override
  final String url;

  factory _$Share([void Function(ShareBuilder)? updates]) =>
      (new ShareBuilder()..update(updates))._build();

  _$Share._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      required this.userId,
      required this.postfeedId,
      required this.url})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Share', 'id');
    BuiltValueNullFieldError.checkNotNull(userId, r'Share', 'userId');
    BuiltValueNullFieldError.checkNotNull(postfeedId, r'Share', 'postfeedId');
    BuiltValueNullFieldError.checkNotNull(url, r'Share', 'url');
  }

  @override
  Share rebuild(void Function(ShareBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ShareBuilder toBuilder() => new ShareBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Share &&
        id == other.id &&
        createdDate == other.createdDate &&
        updatedDate == other.updatedDate &&
        userId == other.userId &&
        postfeedId == other.postfeedId &&
        url == other.url;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, id.hashCode), createdDate.hashCode),
                    updatedDate.hashCode),
                userId.hashCode),
            postfeedId.hashCode),
        url.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Share')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('userId', userId)
          ..add('postfeedId', postfeedId)
          ..add('url', url))
        .toString();
  }
}

class ShareBuilder implements Builder<Share, ShareBuilder> {
  _$Share? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  DateTime? _updatedDate;
  DateTime? get updatedDate => _$this._updatedDate;
  set updatedDate(DateTime? updatedDate) => _$this._updatedDate = updatedDate;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _postfeedId;
  String? get postfeedId => _$this._postfeedId;
  set postfeedId(String? postfeedId) => _$this._postfeedId = postfeedId;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  ShareBuilder() {
    Share._defaults(this);
  }

  ShareBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _userId = $v.userId;
      _postfeedId = $v.postfeedId;
      _url = $v.url;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Share other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Share;
  }

  @override
  void update(void Function(ShareBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Share build() => _build();

  _$Share _build() {
    final _$result = _$v ??
        new _$Share._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Share', 'id'),
            createdDate: createdDate,
            updatedDate: updatedDate,
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'Share', 'userId'),
            postfeedId: BuiltValueNullFieldError.checkNotNull(
                postfeedId, r'Share', 'postfeedId'),
            url: BuiltValueNullFieldError.checkNotNull(url, r'Share', 'url'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
