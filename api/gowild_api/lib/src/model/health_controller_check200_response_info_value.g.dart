// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_controller_check200_response_info_value.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HealthControllerCheck200ResponseInfoValue
    extends HealthControllerCheck200ResponseInfoValue {
  @override
  final String? status;

  factory _$HealthControllerCheck200ResponseInfoValue(
          [void Function(HealthControllerCheck200ResponseInfoValueBuilder)?
              updates]) =>
      (new HealthControllerCheck200ResponseInfoValueBuilder()..update(updates))
          ._build();

  _$HealthControllerCheck200ResponseInfoValue._({this.status}) : super._();

  @override
  HealthControllerCheck200ResponseInfoValue rebuild(
          void Function(HealthControllerCheck200ResponseInfoValueBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HealthControllerCheck200ResponseInfoValueBuilder toBuilder() =>
      new HealthControllerCheck200ResponseInfoValueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HealthControllerCheck200ResponseInfoValue &&
        status == other.status;
  }

  @override
  int get hashCode {
    return $jf($jc(0, status.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'HealthControllerCheck200ResponseInfoValue')
          ..add('status', status))
        .toString();
  }
}

class HealthControllerCheck200ResponseInfoValueBuilder
    implements
        Builder<HealthControllerCheck200ResponseInfoValue,
            HealthControllerCheck200ResponseInfoValueBuilder> {
  _$HealthControllerCheck200ResponseInfoValue? _$v;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  HealthControllerCheck200ResponseInfoValueBuilder() {
    HealthControllerCheck200ResponseInfoValue._defaults(this);
  }

  HealthControllerCheck200ResponseInfoValueBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HealthControllerCheck200ResponseInfoValue other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HealthControllerCheck200ResponseInfoValue;
  }

  @override
  void update(
      void Function(HealthControllerCheck200ResponseInfoValueBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  HealthControllerCheck200ResponseInfoValue build() => _build();

  _$HealthControllerCheck200ResponseInfoValue _build() {
    final _$result = _$v ??
        new _$HealthControllerCheck200ResponseInfoValue._(status: status);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
