// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guideline_log.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GuidelineLog extends GuidelineLog {
  @override
  final String userId;
  @override
  final String guidelineType;
  @override
  final DateTime lastUpdateDate;

  factory _$GuidelineLog([void Function(GuidelineLogBuilder)? updates]) =>
      (new GuidelineLogBuilder()..update(updates))._build();

  _$GuidelineLog._(
      {required this.userId,
      required this.guidelineType,
      required this.lastUpdateDate})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(userId, r'GuidelineLog', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        guidelineType, r'GuidelineLog', 'guidelineType');
    BuiltValueNullFieldError.checkNotNull(
        lastUpdateDate, r'GuidelineLog', 'lastUpdateDate');
  }

  @override
  GuidelineLog rebuild(void Function(GuidelineLogBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GuidelineLogBuilder toBuilder() => new GuidelineLogBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GuidelineLog &&
        userId == other.userId &&
        guidelineType == other.guidelineType &&
        lastUpdateDate == other.lastUpdateDate;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, userId.hashCode), guidelineType.hashCode),
        lastUpdateDate.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GuidelineLog')
          ..add('userId', userId)
          ..add('guidelineType', guidelineType)
          ..add('lastUpdateDate', lastUpdateDate))
        .toString();
  }
}

class GuidelineLogBuilder
    implements Builder<GuidelineLog, GuidelineLogBuilder> {
  _$GuidelineLog? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _guidelineType;
  String? get guidelineType => _$this._guidelineType;
  set guidelineType(String? guidelineType) =>
      _$this._guidelineType = guidelineType;

  DateTime? _lastUpdateDate;
  DateTime? get lastUpdateDate => _$this._lastUpdateDate;
  set lastUpdateDate(DateTime? lastUpdateDate) =>
      _$this._lastUpdateDate = lastUpdateDate;

  GuidelineLogBuilder() {
    GuidelineLog._defaults(this);
  }

  GuidelineLogBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _guidelineType = $v.guidelineType;
      _lastUpdateDate = $v.lastUpdateDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GuidelineLog other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GuidelineLog;
  }

  @override
  void update(void Function(GuidelineLogBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GuidelineLog build() => _build();

  _$GuidelineLog _build() {
    final _$result = _$v ??
        new _$GuidelineLog._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GuidelineLog', 'userId'),
            guidelineType: BuiltValueNullFieldError.checkNotNull(
                guidelineType, r'GuidelineLog', 'guidelineType'),
            lastUpdateDate: BuiltValueNullFieldError.checkNotNull(
                lastUpdateDate, r'GuidelineLog', 'lastUpdateDate'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
