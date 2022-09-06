// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Comment extends Comment {
  @override
  final String userId;
  @override
  final String postfeedId;
  @override
  final String message;

  factory _$Comment([void Function(CommentBuilder)? updates]) =>
      (new CommentBuilder()..update(updates))._build();

  _$Comment._(
      {required this.userId, required this.postfeedId, required this.message})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(userId, r'Comment', 'userId');
    BuiltValueNullFieldError.checkNotNull(postfeedId, r'Comment', 'postfeedId');
    BuiltValueNullFieldError.checkNotNull(message, r'Comment', 'message');
  }

  @override
  Comment rebuild(void Function(CommentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CommentBuilder toBuilder() => new CommentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Comment &&
        userId == other.userId &&
        postfeedId == other.postfeedId &&
        message == other.message;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, userId.hashCode), postfeedId.hashCode), message.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Comment')
          ..add('userId', userId)
          ..add('postfeedId', postfeedId)
          ..add('message', message))
        .toString();
  }
}

class CommentBuilder implements Builder<Comment, CommentBuilder> {
  _$Comment? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _postfeedId;
  String? get postfeedId => _$this._postfeedId;
  set postfeedId(String? postfeedId) => _$this._postfeedId = postfeedId;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  CommentBuilder() {
    Comment._defaults(this);
  }

  CommentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _postfeedId = $v.postfeedId;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Comment other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Comment;
  }

  @override
  void update(void Function(CommentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Comment build() => _build();

  _$Comment _build() {
    final _$result = _$v ??
        new _$Comment._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'Comment', 'userId'),
            postfeedId: BuiltValueNullFieldError.checkNotNull(
                postfeedId, r'Comment', 'postfeedId'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'Comment', 'message'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
