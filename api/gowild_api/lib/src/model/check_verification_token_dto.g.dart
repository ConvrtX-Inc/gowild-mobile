// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_verification_token_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CheckVerificationTokenDto extends CheckVerificationTokenDto {
  @override
  final String phoneNumber;
  @override
  final String verifyCode;

  factory _$CheckVerificationTokenDto(
          [void Function(CheckVerificationTokenDtoBuilder)? updates]) =>
      (new CheckVerificationTokenDtoBuilder()..update(updates))._build();

  _$CheckVerificationTokenDto._(
      {required this.phoneNumber, required this.verifyCode})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        phoneNumber, r'CheckVerificationTokenDto', 'phoneNumber');
    BuiltValueNullFieldError.checkNotNull(
        verifyCode, r'CheckVerificationTokenDto', 'verifyCode');
  }

  @override
  CheckVerificationTokenDto rebuild(
          void Function(CheckVerificationTokenDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CheckVerificationTokenDtoBuilder toBuilder() =>
      new CheckVerificationTokenDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CheckVerificationTokenDto &&
        phoneNumber == other.phoneNumber &&
        verifyCode == other.verifyCode;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, phoneNumber.hashCode), verifyCode.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CheckVerificationTokenDto')
          ..add('phoneNumber', phoneNumber)
          ..add('verifyCode', verifyCode))
        .toString();
  }
}

class CheckVerificationTokenDtoBuilder
    implements
        Builder<CheckVerificationTokenDto, CheckVerificationTokenDtoBuilder> {
  _$CheckVerificationTokenDto? _$v;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  String? _verifyCode;
  String? get verifyCode => _$this._verifyCode;
  set verifyCode(String? verifyCode) => _$this._verifyCode = verifyCode;

  CheckVerificationTokenDtoBuilder() {
    CheckVerificationTokenDto._defaults(this);
  }

  CheckVerificationTokenDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _phoneNumber = $v.phoneNumber;
      _verifyCode = $v.verifyCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CheckVerificationTokenDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CheckVerificationTokenDto;
  }

  @override
  void update(void Function(CheckVerificationTokenDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CheckVerificationTokenDto build() => _build();

  _$CheckVerificationTokenDto _build() {
    final _$result = _$v ??
        new _$CheckVerificationTokenDto._(
            phoneNumber: BuiltValueNullFieldError.checkNotNull(
                phoneNumber, r'CheckVerificationTokenDto', 'phoneNumber'),
            verifyCode: BuiltValueNullFieldError.checkNotNull(
                verifyCode, r'CheckVerificationTokenDto', 'verifyCode'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
