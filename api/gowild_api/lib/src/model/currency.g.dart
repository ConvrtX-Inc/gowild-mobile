// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Currency extends Currency {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final String code;
  @override
  final String name;
  @override
  final String namePlural;
  @override
  final String symbol;

  factory _$Currency([void Function(CurrencyBuilder)? updates]) =>
      (new CurrencyBuilder()..update(updates))._build();

  _$Currency._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      required this.code,
      required this.name,
      required this.namePlural,
      required this.symbol})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Currency', 'id');
    BuiltValueNullFieldError.checkNotNull(code, r'Currency', 'code');
    BuiltValueNullFieldError.checkNotNull(name, r'Currency', 'name');
    BuiltValueNullFieldError.checkNotNull(
        namePlural, r'Currency', 'namePlural');
    BuiltValueNullFieldError.checkNotNull(symbol, r'Currency', 'symbol');
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
        id == other.id &&
        createdDate == other.createdDate &&
        updatedDate == other.updatedDate &&
        code == other.code &&
        name == other.name &&
        namePlural == other.namePlural &&
        symbol == other.symbol;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, id.hashCode), createdDate.hashCode),
                        updatedDate.hashCode),
                    code.hashCode),
                name.hashCode),
            namePlural.hashCode),
        symbol.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Currency')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('code', code)
          ..add('name', name)
          ..add('namePlural', namePlural)
          ..add('symbol', symbol))
        .toString();
  }
}

class CurrencyBuilder implements Builder<Currency, CurrencyBuilder> {
  _$Currency? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  DateTime? _updatedDate;
  DateTime? get updatedDate => _$this._updatedDate;
  set updatedDate(DateTime? updatedDate) => _$this._updatedDate = updatedDate;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _namePlural;
  String? get namePlural => _$this._namePlural;
  set namePlural(String? namePlural) => _$this._namePlural = namePlural;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  CurrencyBuilder() {
    Currency._defaults(this);
  }

  CurrencyBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _code = $v.code;
      _name = $v.name;
      _namePlural = $v.namePlural;
      _symbol = $v.symbol;
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
            id: BuiltValueNullFieldError.checkNotNull(id, r'Currency', 'id'),
            createdDate: createdDate,
            updatedDate: updatedDate,
            code: BuiltValueNullFieldError.checkNotNull(
                code, r'Currency', 'code'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'Currency', 'name'),
            namePlural: BuiltValueNullFieldError.checkNotNull(
                namePlural, r'Currency', 'namePlural'),
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'Currency', 'symbol'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
