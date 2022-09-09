// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccessToken extends AccessToken {
  @override
  final SimpleUser user;
  @override
  final String email;

  factory _$AccessToken([void Function(AccessTokenBuilder)? updates]) =>
      (new AccessTokenBuilder()..update(updates))._build();

  _$AccessToken._({required this.user, required this.email}) : super._() {
    BuiltValueNullFieldError.checkNotNull(user, r'AccessToken', 'user');
    BuiltValueNullFieldError.checkNotNull(email, r'AccessToken', 'email');
  }

  @override
  AccessToken rebuild(void Function(AccessTokenBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccessTokenBuilder toBuilder() => new AccessTokenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccessToken && user == other.user && email == other.email;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, user.hashCode), email.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccessToken')
          ..add('user', user)
          ..add('email', email))
        .toString();
  }
}

class AccessTokenBuilder implements Builder<AccessToken, AccessTokenBuilder> {
  _$AccessToken? _$v;

  SimpleUserBuilder? _user;
  SimpleUserBuilder get user => _$this._user ??= new SimpleUserBuilder();
  set user(SimpleUserBuilder? user) => _$this._user = user;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  AccessTokenBuilder() {
    AccessToken._defaults(this);
  }

  AccessTokenBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user.toBuilder();
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccessToken other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AccessToken;
  }

  @override
  void update(void Function(AccessTokenBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccessToken build() => _build();

  _$AccessToken _build() {
    _$AccessToken _$result;
    try {
      _$result = _$v ??
          new _$AccessToken._(
              user: user.build(),
              email: BuiltValueNullFieldError.checkNotNull(
                  email, r'AccessToken', 'email'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AccessToken', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
