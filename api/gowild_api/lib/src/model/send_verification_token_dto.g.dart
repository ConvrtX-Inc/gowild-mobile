// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_verification_token_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendVerificationTokenDto extends SendVerificationTokenDto {
  @override
  final String phoneNumber;

  factory _$SendVerificationTokenDto(
          [void Function(SendVerificationTokenDtoBuilder)? updates]) =>
      (new SendVerificationTokenDtoBuilder()..update(updates))._build();

  _$SendVerificationTokenDto._({required this.phoneNumber}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        phoneNumber, r'SendVerificationTokenDto', 'phoneNumber');
  }

  @override
  SendVerificationTokenDto rebuild(
          void Function(SendVerificationTokenDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SendVerificationTokenDtoBuilder toBuilder() =>
      new SendVerificationTokenDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendVerificationTokenDto &&
        phoneNumber == other.phoneNumber;
  }

  @override
  int get hashCode {
    return $jf($jc(0, phoneNumber.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SendVerificationTokenDto')
          ..add('phoneNumber', phoneNumber))
        .toString();
  }
}

class SendVerificationTokenDtoBuilder
    implements
        Builder<SendVerificationTokenDto, SendVerificationTokenDtoBuilder> {
  _$SendVerificationTokenDto? _$v;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  SendVerificationTokenDtoBuilder() {
    SendVerificationTokenDto._defaults(this);
  }

  SendVerificationTokenDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _phoneNumber = $v.phoneNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendVerificationTokenDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SendVerificationTokenDto;
  }

  @override
  void update(void Function(SendVerificationTokenDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SendVerificationTokenDto build() => _build();

  _$SendVerificationTokenDto _build() {
    final _$result = _$v ??
        new _$SendVerificationTokenDto._(
            phoneNumber: BuiltValueNullFieldError.checkNotNull(
                phoneNumber, r'SendVerificationTokenDto', 'phoneNumber'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
