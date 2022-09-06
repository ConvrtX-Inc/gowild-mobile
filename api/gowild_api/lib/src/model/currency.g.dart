// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Currency extends Currency {
  @override
  final String currencyCode;
  @override
  final String currencyName;
  @override
  final String currencySymbol;

  factory _$Currency([void Function(CurrencyBuilder)? updates]) =>
      (new CurrencyBuilder()..update(updates))._build();

  _$Currency._(
      {required this.currencyCode,
      required this.currencyName,
      required this.currencySymbol})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        currencyCode, r'Currency', 'currencyCode');
    BuiltValueNullFieldError.checkNotNull(
        currencyName, r'Currency', 'currencyName');
    BuiltValueNullFieldError.checkNotNull(
        currencySymbol, r'Currency', 'currencySymbol');
  }

  @override
  Currency rebuild(void Function(CurrencyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CurrencyBuilder toBuilder() => new CurrencyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Currency &&
        currencyCode == other.currencyCode &&
        currencyName == other.currencyName &&
        currencySymbol == other.currencySymbol;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, currencyCode.hashCode), currencyName.hashCode),
        currencySymbol.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Currency')
          ..add('currencyCode', currencyCode)
          ..add('currencyName', currencyName)
          ..add('currencySymbol', currencySymbol))
        .toString();
  }
}

class CurrencyBuilder implements Builder<Currency, CurrencyBuilder> {
  _$Currency? _$v;

  String? _currencyCode;
  String? get currencyCode => _$this._currencyCode;
  set currencyCode(String? currencyCode) => _$this._currencyCode = currencyCode;

  String? _currencyName;
  String? get currencyName => _$this._currencyName;
  set currencyName(String? currencyName) => _$this._currencyName = currencyName;

  String? _currencySymbol;
  String? get currencySymbol => _$this._currencySymbol;
  set currencySymbol(String? currencySymbol) =>
      _$this._currencySymbol = currencySymbol;

  CurrencyBuilder() {
    Currency._defaults(this);
  }

  CurrencyBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _currencyCode = $v.currencyCode;
      _currencyName = $v.currencyName;
      _currencySymbol = $v.currencySymbol;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Currency other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Currency;
  }

  @override
  void update(void Function(CurrencyBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Currency build() => _build();

  _$Currency _build() {
    final _$result = _$v ??
        new _$Currency._(
            currencyCode: BuiltValueNullFieldError.checkNotNull(
                currencyCode, r'Currency', 'currencyCode'),
            currencyName: BuiltValueNullFieldError.checkNotNull(
                currencyName, r'Currency', 'currencyName'),
            currencySymbol: BuiltValueNullFieldError.checkNotNull(
                currencySymbol, r'Currency', 'currencySymbol'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
