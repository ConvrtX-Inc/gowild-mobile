// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Like extends Like {
  @override
  final String userId;
  @override
  final String postfeedId;

  factory _$Like([void Function(LikeBuilder)? updates]) =>
      (new LikeBuilder()..update(updates))._build();

  _$Like._({required this.userId, required this.postfeedId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(userId, r'Like', 'userId');
    BuiltValueNullFieldError.checkNotNull(postfeedId, r'Like', 'postfeedId');
  }

  @override
  Like rebuild(void Function(LikeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LikeBuilder toBuilder() => new LikeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Like &&
        userId == other.userId &&
        postfeedId == other.postfeedId;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, userId.hashCode), postfeedId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Like')
          ..add('userId', userId)
          ..add('postfeedId', postfeedId))
        .toString();
  }
}

class LikeBuilder implements Builder<Like, LikeBuilder> {
  _$Like? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _postfeedId;
  String? get postfeedId => _$this._postfeedId;
  set postfeedId(String? postfeedId) => _$this._postfeedId = postfeedId;

  LikeBuilder() {
    Like._defaults(this);
  }

  LikeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _postfeedId = $v.postfeedId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Like other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Like;
  }

  @override
  void update(void Function(LikeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Like build() => _build();

  _$Like _build() {
    final _$result = _$v ??
        new _$Like._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'Like', 'userId'),
            postfeedId: BuiltValueNullFieldError.checkNotNull(
                postfeedId, r'Like', 'postfeedId'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
