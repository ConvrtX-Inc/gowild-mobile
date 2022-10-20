// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RefreshToken extends RefreshToken {
  @override
  final String rid;
  @override
  final SimpleUser user;
  @override
  final String email;

  factory _$RefreshToken([void Function(RefreshTokenBuilder)? updates]) =>
      (new RefreshTokenBuilder()..update(updates))._build();

  _$RefreshToken._({required this.rid, required this.user, required this.email})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(rid, r'RefreshToken', 'rid');
    BuiltValueNullFieldError.checkNotNull(user, r'RefreshToken', 'user');
    BuiltValueNullFieldError.checkNotNull(email, r'RefreshToken', 'email');
  }

  @override
  RefreshToken rebuild(void Function(RefreshTokenBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RefreshTokenBuilder toBuilder() => new RefreshTokenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RefreshToken &&
        rid == other.rid &&
        user == other.user &&
        email == other.email;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, rid.hashCode), user.hashCode), email.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RefreshToken')
          ..add('rid', rid)
          ..add('user', user)
          ..add('email', email))
        .toString();
  }
}

class RefreshTokenBuilder
    implements Builder<RefreshToken, RefreshTokenBuilder> {
  _$RefreshToken? _$v;

  String? _rid;
  String? get rid => _$this._rid;
  set rid(String? rid) => _$this._rid = rid;

  SimpleUserBuilder? _user;
  SimpleUserBuilder get user => _$this._user ??= new SimpleUserBuilder();
  set user(SimpleUserBuilder? user) => _$this._user = user;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  RefreshTokenBuilder() {
    RefreshToken._defaults(this);
  }

  RefreshTokenBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rid = $v.rid;
      _user = $v.user.toBuilder();
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RefreshToken other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RefreshToken;
  }

  @override
  void update(void Function(RefreshTokenBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RefreshToken build() => _build();

  _$RefreshToken _build() {
    _$RefreshToken _$result;
    try {
      _$result = _$v ??
          new _$RefreshToken._(
              rid: BuiltValueNullFieldError.checkNotNull(
                  rid, r'RefreshToken', 'rid'),
              user: user.build(),
              email: BuiltValueNullFieldError.checkNotNull(
                  email, r'RefreshToken', 'email'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'RefreshToken', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
