// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_controller_check200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HealthControllerCheck200Response
    extends HealthControllerCheck200Response {
  @override
  final String? status;
  @override
  final BuiltMap<String, HealthControllerCheck200ResponseInfoValue>? info;
  @override
  final BuiltMap<String, HealthControllerCheck200ResponseInfoValue>? error;
  @override
  final BuiltMap<String, HealthControllerCheck200ResponseInfoValue>? details;

  factory _$HealthControllerCheck200Response(
          [void Function(HealthControllerCheck200ResponseBuilder)? updates]) =>
      (new HealthControllerCheck200ResponseBuilder()..update(updates))._build();

  _$HealthControllerCheck200Response._(
      {this.status, this.info, this.error, this.details})
      : super._();

  @override
  HealthControllerCheck200Response rebuild(
          void Function(HealthControllerCheck200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HealthControllerCheck200ResponseBuilder toBuilder() =>
      new HealthControllerCheck200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HealthControllerCheck200Response &&
        status == other.status &&
        info == other.info &&
        error == other.error &&
        details == other.details;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, status.hashCode), info.hashCode), error.hashCode),
        details.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HealthControllerCheck200Response')
          ..add('status', status)
          ..add('info', info)
          ..add('error', error)
          ..add('details', details))
        .toString();
  }
}

class HealthControllerCheck200ResponseBuilder
    implements
        Builder<HealthControllerCheck200Response,
            HealthControllerCheck200ResponseBuilder> {
  _$HealthControllerCheck200Response? _$v;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  MapBuilder<String, HealthControllerCheck200ResponseInfoValue>? _info;
  MapBuilder<String, HealthControllerCheck200ResponseInfoValue> get info =>
      _$this._info ??=
          new MapBuilder<String, HealthControllerCheck200ResponseInfoValue>();
  set info(
          MapBuilder<String, HealthControllerCheck200ResponseInfoValue>?
              info) =>
      _$this._info = info;

  MapBuilder<String, HealthControllerCheck200ResponseInfoValue>? _error;
  MapBuilder<String, HealthControllerCheck200ResponseInfoValue> get error =>
      _$this._error ??=
          new MapBuilder<String, HealthControllerCheck200ResponseInfoValue>();
  set error(
          MapBuilder<String, HealthControllerCheck200ResponseInfoValue>?
              error) =>
      _$this._error = error;

  MapBuilder<String, HealthControllerCheck200ResponseInfoValue>? _details;
  MapBuilder<String, HealthControllerCheck200ResponseInfoValue> get details =>
      _$this._details ??=
          new MapBuilder<String, HealthControllerCheck200ResponseInfoValue>();
  set details(
          MapBuilder<String, HealthControllerCheck200ResponseInfoValue>?
              details) =>
      _$this._details = details;

  HealthControllerCheck200ResponseBuilder() {
    HealthControllerCheck200Response._defaults(this);
  }

  HealthControllerCheck200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _info = $v.info?.toBuilder();
      _error = $v.error?.toBuilder();
      _details = $v.details?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HealthControllerCheck200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HealthControllerCheck200Response;
  }

  @override
  void update(void Function(HealthControllerCheck200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HealthControllerCheck200Response build() => _build();

  _$HealthControllerCheck200Response _build() {
    _$HealthControllerCheck200Response _$result;
    try {
      _$result = _$v ??
          new _$HealthControllerCheck200Response._(
              status: status,
              info: _info?.build(),
              error: _error?.build(),
              details: _details?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'info';
        _info?.build();
        _$failedField = 'error';
        _error?.build();
        _$failedField = 'details';
        _details?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'HealthControllerCheck200Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
