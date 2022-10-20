// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_clue.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RouteClue extends RouteClue {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final String routeId;
  @override
  final AppPoint point;
  @override
  final String title;
  @override
  final String description;
  @override
  final BuiltList<FileEntity>? medias;
  @override
  final String arClue;

  factory _$RouteClue([void Function(RouteClueBuilder)? updates]) =>
      (new RouteClueBuilder()..update(updates))._build();

  _$RouteClue._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      required this.routeId,
      required this.point,
      required this.title,
      required this.description,
      this.medias,
      required this.arClue})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'RouteClue', 'id');
    BuiltValueNullFieldError.checkNotNull(routeId, r'RouteClue', 'routeId');
    BuiltValueNullFieldError.checkNotNull(point, r'RouteClue', 'point');
    BuiltValueNullFieldError.checkNotNull(title, r'RouteClue', 'title');
    BuiltValueNullFieldError.checkNotNull(
        description, r'RouteClue', 'description');
    BuiltValueNullFieldError.checkNotNull(arClue, r'RouteClue', 'arClue');
  }

  @override
  RouteClue rebuild(void Function(RouteClueBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RouteClueBuilder toBuilder() => new RouteClueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RouteClue &&
        id == other.id &&
        createdDate == other.createdDate &&
        updatedDate == other.updatedDate &&
        routeId == other.routeId &&
        point == other.point &&
        title == other.title &&
        description == other.description &&
        medias == other.medias &&
        arClue == other.arClue;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, id.hashCode), createdDate.hashCode),
                                updatedDate.hashCode),
                            routeId.hashCode),
                        point.hashCode),
                    title.hashCode),
                description.hashCode),
            medias.hashCode),
        arClue.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RouteClue')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('routeId', routeId)
          ..add('point', point)
          ..add('title', title)
          ..add('description', description)
          ..add('medias', medias)
          ..add('arClue', arClue))
        .toString();
  }
}

class RouteClueBuilder implements Builder<RouteClue, RouteClueBuilder> {
  _$RouteClue? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  DateTime? _updatedDate;
  DateTime? get updatedDate => _$this._updatedDate;
  set updatedDate(DateTime? updatedDate) => _$this._updatedDate = updatedDate;

  String? _routeId;
  String? get routeId => _$this._routeId;
  set routeId(String? routeId) => _$this._routeId = routeId;

  AppPointBuilder? _point;
  AppPointBuilder get point => _$this._point ??= new AppPointBuilder();
  set point(AppPointBuilder? point) => _$this._point = point;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ListBuilder<FileEntity>? _medias;
  ListBuilder<FileEntity> get medias =>
      _$this._medias ??= new ListBuilder<FileEntity>();
  set medias(ListBuilder<FileEntity>? medias) => _$this._medias = medias;

  String? _arClue;
  String? get arClue => _$this._arClue;
  set arClue(String? arClue) => _$this._arClue = arClue;

  RouteClueBuilder() {
    RouteClue._defaults(this);
  }

  RouteClueBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _routeId = $v.routeId;
      _point = $v.point.toBuilder();
      _title = $v.title;
      _description = $v.description;
      _medias = $v.medias?.toBuilder();
      _arClue = $v.arClue;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RouteClue other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RouteClue;
  }

  @override
  void update(void Function(RouteClueBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RouteClue build() => _build();

  _$RouteClue _build() {
    _$RouteClue _$result;
    try {
      _$result = _$v ??
          new _$RouteClue._(
              id: BuiltValueNullFieldError.checkNotNull(id, r'RouteClue', 'id'),
              createdDate: createdDate,
              updatedDate: updatedDate,
              routeId: BuiltValueNullFieldError.checkNotNull(
                  routeId, r'RouteClue', 'routeId'),
              point: point.build(),
              title: BuiltValueNullFieldError.checkNotNull(
                  title, r'RouteClue', 'title'),
              description: BuiltValueNullFieldError.checkNotNull(
                  description, r'RouteClue', 'description'),
              medias: _medias?.build(),
              arClue: BuiltValueNullFieldError.checkNotNull(
                  arClue, r'RouteClue', 'arClue'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'point';
        point.build();

        _$failedField = 'medias';
        _medias?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'RouteClue', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
