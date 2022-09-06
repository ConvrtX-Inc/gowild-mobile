// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SmsDto extends SmsDto {
  @override
  final String phoneNumber;
  @override
  final String message;

  factory _$SmsDto([void Function(SmsDtoBuilder)? updates]) =>
      (new SmsDtoBuilder()..update(updates))._build();

  _$SmsDto._({required this.phoneNumber, required this.message}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        phoneNumber, r'SmsDto', 'phoneNumber');
    BuiltValueNullFieldError.checkNotNull(message, r'SmsDto', 'message');
  }

  @override
  SmsDto rebuild(void Function(SmsDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SmsDtoBuilder toBuilder() => new SmsDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SmsDto &&
        phoneNumber == other.phoneNumber &&
        message == other.message;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, phoneNumber.hashCode), message.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SmsDto')
          ..add('phoneNumber', phoneNumber)
          ..add('message', message))
        .toString();
  }
}

class SmsDtoBuilder implements Builder<SmsDto, SmsDtoBuilder> {
  _$SmsDto? _$v;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  SmsDtoBuilder() {
    SmsDto._defaults(this);
  }

  SmsDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _phoneNumber = $v.phoneNumber;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SmsDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SmsDto;
  }

  @override
  void update(void Function(SmsDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SmsDto build() => _build();

  _$SmsDto _build() {
    final _$result = _$v ??
        new _$SmsDto._(
            phoneNumber: BuiltValueNullFieldError.checkNotNull(
                phoneNumber, r'SmsDto', 'phoneNumber'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'SmsDto', 'message'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
