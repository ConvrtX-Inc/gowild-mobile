// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Friends extends Friends {
  @override
  final String userId;
  @override
  final String friendId;
  @override
  final bool isApproved;

  factory _$Friends([void Function(FriendsBuilder)? updates]) =>
      (new FriendsBuilder()..update(updates))._build();

  _$Friends._(
      {required this.userId, required this.friendId, required this.isApproved})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(userId, r'Friends', 'userId');
    BuiltValueNullFieldError.checkNotNull(friendId, r'Friends', 'friendId');
    BuiltValueNullFieldError.checkNotNull(isApproved, r'Friends', 'isApproved');
  }

  @override
  Friends rebuild(void Function(FriendsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FriendsBuilder toBuilder() => new FriendsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Friends &&
        userId == other.userId &&
        friendId == other.friendId &&
        isApproved == other.isApproved;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, userId.hashCode), friendId.hashCode), isApproved.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Friends')
          ..add('userId', userId)
          ..add('friendId', friendId)
          ..add('isApproved', isApproved))
        .toString();
  }
}

class FriendsBuilder implements Builder<Friends, FriendsBuilder> {
  _$Friends? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _friendId;
  String? get friendId => _$this._friendId;
  set friendId(String? friendId) => _$this._friendId = friendId;

  bool? _isApproved;
  bool? get isApproved => _$this._isApproved;
  set isApproved(bool? isApproved) => _$this._isApproved = isApproved;

  FriendsBuilder() {
    Friends._defaults(this);
  }

  FriendsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _friendId = $v.friendId;
      _isApproved = $v.isApproved;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Friends other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Friends;
  }

  @override
  void update(void Function(FriendsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Friends build() => _build();

  _$Friends _build() {
    final _$result = _$v ??
        new _$Friends._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'Friends', 'userId'),
            friendId: BuiltValueNullFieldError.checkNotNull(
                friendId, r'Friends', 'friendId'),
            isApproved: BuiltValueNullFieldError.checkNotNull(
                isApproved, r'Friends', 'isApproved'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
