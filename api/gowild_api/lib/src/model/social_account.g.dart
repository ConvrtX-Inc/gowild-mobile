// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_account.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SocialAccount extends SocialAccount {
  @override
  final String userId;
  @override
  final String description;
  @override
  final String accountEmail;
  @override
  final String socialId;
  @override
  final String provider;

  factory _$SocialAccount([void Function(SocialAccountBuilder)? updates]) =>
      (new SocialAccountBuilder()..update(updates))._build();

  _$SocialAccount._(
      {required this.userId,
      required this.description,
      required this.accountEmail,
      required this.socialId,
      required this.provider})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(userId, r'SocialAccount', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        description, r'SocialAccount', 'description');
    BuiltValueNullFieldError.checkNotNull(
        accountEmail, r'SocialAccount', 'accountEmail');
    BuiltValueNullFieldError.checkNotNull(
        socialId, r'SocialAccount', 'socialId');
    BuiltValueNullFieldError.checkNotNull(
        provider, r'SocialAccount', 'provider');
  }

  @override
  SocialAccount rebuild(void Function(SocialAccountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SocialAccountBuilder toBuilder() => new SocialAccountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SocialAccount &&
        userId == other.userId &&
        description == other.description &&
        accountEmail == other.accountEmail &&
        socialId == other.socialId &&
        provider == other.provider;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, userId.hashCode), description.hashCode),
                accountEmail.hashCode),
            socialId.hashCode),
        provider.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SocialAccount')
          ..add('userId', userId)
          ..add('description', description)
          ..add('accountEmail', accountEmail)
          ..add('socialId', socialId)
          ..add('provider', provider))
        .toString();
  }
}

class SocialAccountBuilder
    implements Builder<SocialAccount, SocialAccountBuilder> {
  _$SocialAccount? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _accountEmail;
  String? get accountEmail => _$this._accountEmail;
  set accountEmail(String? accountEmail) => _$this._accountEmail = accountEmail;

  String? _socialId;
  String? get socialId => _$this._socialId;
  set socialId(String? socialId) => _$this._socialId = socialId;

  String? _provider;
  String? get provider => _$this._provider;
  set provider(String? provider) => _$this._provider = provider;

  SocialAccountBuilder() {
    SocialAccount._defaults(this);
  }

  SocialAccountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _description = $v.description;
      _accountEmail = $v.accountEmail;
      _socialId = $v.socialId;
      _provider = $v.provider;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SocialAccount other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SocialAccount;
  }

  @override
  void update(void Function(SocialAccountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SocialAccount build() => _build();

  _$SocialAccount _build() {
    final _$result = _$v ??
        new _$SocialAccount._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'SocialAccount', 'userId'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'SocialAccount', 'description'),
            accountEmail: BuiltValueNullFieldError.checkNotNull(
                accountEmail, r'SocialAccount', 'accountEmail'),
            socialId: BuiltValueNullFieldError.checkNotNull(
                socialId, r'SocialAccount', 'socialId'),
            provider: BuiltValueNullFieldError.checkNotNull(
                provider, r'SocialAccount', 'provider'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
