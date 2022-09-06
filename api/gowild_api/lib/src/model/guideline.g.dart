// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guideline.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Guideline extends Guideline {
  @override
  final String type;
  @override
  final String description;
  @override
  final String lastUpdatedUser;

  factory _$Guideline([void Function(GuidelineBuilder)? updates]) =>
      (new GuidelineBuilder()..update(updates))._build();

  _$Guideline._(
      {required this.type,
      required this.description,
      required this.lastUpdatedUser})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(type, r'Guideline', 'type');
    BuiltValueNullFieldError.checkNotNull(
        description, r'Guideline', 'description');
    BuiltValueNullFieldError.checkNotNull(
        lastUpdatedUser, r'Guideline', 'lastUpdatedUser');
  }

  @override
  Guideline rebuild(void Function(GuidelineBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GuidelineBuilder toBuilder() => new GuidelineBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Guideline &&
        type == other.type &&
        description == other.description &&
        lastUpdatedUser == other.lastUpdatedUser;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, type.hashCode), description.hashCode),
        lastUpdatedUser.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Guideline')
          ..add('type', type)
          ..add('description', description)
          ..add('lastUpdatedUser', lastUpdatedUser))
        .toString();
  }
}

class GuidelineBuilder implements Builder<Guideline, GuidelineBuilder> {
  _$Guideline? _$v;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _lastUpdatedUser;
  String? get lastUpdatedUser => _$this._lastUpdatedUser;
  set lastUpdatedUser(String? lastUpdatedUser) =>
      _$this._lastUpdatedUser = lastUpdatedUser;

  GuidelineBuilder() {
    Guideline._defaults(this);
  }

  GuidelineBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _description = $v.description;
      _lastUpdatedUser = $v.lastUpdatedUser;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Guideline other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Guideline;
  }

  @override
  void update(void Function(GuidelineBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Guideline build() => _build();

  _$Guideline _build() {
    final _$result = _$v ??
        new _$Guideline._(
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'Guideline', 'type'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'Guideline', 'description'),
            lastUpdatedUser: BuiltValueNullFieldError.checkNotNull(
                lastUpdatedUser, r'Guideline', 'lastUpdatedUser'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
