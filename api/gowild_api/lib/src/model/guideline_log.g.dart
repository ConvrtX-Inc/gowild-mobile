// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guideline_log.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GuidelineLog extends GuidelineLog {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final String userId;
  @override
  final String guidelineType;

  factory _$GuidelineLog([void Function(GuidelineLogBuilder)? updates]) =>
      (new GuidelineLogBuilder()..update(updates))._build();

  _$GuidelineLog._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      required this.userId,
      required this.guidelineType})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'GuidelineLog', 'id');
    BuiltValueNullFieldError.checkNotNull(userId, r'GuidelineLog', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        guidelineType, r'GuidelineLog', 'guidelineType');
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
        id == other.id &&
        createdDate == other.createdDate &&
        updatedDate == other.updatedDate &&
        userId == other.userId &&
        guidelineType == other.guidelineType;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, id.hashCode), createdDate.hashCode),
                updatedDate.hashCode),
            userId.hashCode),
        guidelineType.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GuidelineLog')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('userId', userId)
          ..add('guidelineType', guidelineType))
        .toString();
  }
}

class GuidelineLogBuilder
    implements Builder<GuidelineLog, GuidelineLogBuilder> {
  _$GuidelineLog? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  DateTime? _updatedDate;
  DateTime? get updatedDate => _$this._updatedDate;
  set updatedDate(DateTime? updatedDate) => _$this._updatedDate = updatedDate;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _guidelineType;
  String? get guidelineType => _$this._guidelineType;
  set guidelineType(String? guidelineType) =>
      _$this._guidelineType = guidelineType;

  GuidelineLogBuilder() {
    GuidelineLog._defaults(this);
  }

  GuidelineLogBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _userId = $v.userId;
      _guidelineType = $v.guidelineType;
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
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GuidelineLog', 'id'),
            createdDate: createdDate,
            updatedDate: updatedDate,
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GuidelineLog', 'userId'),
            guidelineType: BuiltValueNullFieldError.checkNotNull(
                guidelineType, r'GuidelineLog', 'guidelineType'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
