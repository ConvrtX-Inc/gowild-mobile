// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Route extends Route {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final RouteUser? user;
  @override
  final String? title;
  @override
  final RouteHistoricalEventPoint? start;
  @override
  final RouteHistoricalEventPoint? end;
  @override
  final BuiltList<RouteHistoricalEvent>? historicalEvents;
  @override
  final UserEntityPicture? picture;
  @override
  final String? description;

  factory _$Route([void Function(RouteBuilder)? updates]) =>
      (new RouteBuilder()..update(updates))._build();

  _$Route._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      this.user,
      this.title,
      this.start,
      this.end,
      this.historicalEvents,
      this.picture,
      this.description})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Route', 'id');
  }

  @override
  Route rebuild(void Function(RouteBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RouteBuilder toBuilder() => new RouteBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Route &&
        id == other.id &&
        createdDate == other.createdDate &&
        updatedDate == other.updatedDate &&
        user == other.user &&
        title == other.title &&
        start == other.start &&
        end == other.end &&
        historicalEvents == other.historicalEvents &&
        picture == other.picture &&
        description == other.description;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc($jc(0, id.hashCode),
                                        createdDate.hashCode),
                                    updatedDate.hashCode),
                                user.hashCode),
                            title.hashCode),
                        start.hashCode),
                    end.hashCode),
                historicalEvents.hashCode),
            picture.hashCode),
        description.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Route')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('user', user)
          ..add('title', title)
          ..add('start', start)
          ..add('end', end)
          ..add('historicalEvents', historicalEvents)
          ..add('picture', picture)
          ..add('description', description))
        .toString();
  }
}

class RouteBuilder implements Builder<Route, RouteBuilder> {
  _$Route? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  DateTime? _updatedDate;
  DateTime? get updatedDate => _$this._updatedDate;
  set updatedDate(DateTime? updatedDate) => _$this._updatedDate = updatedDate;

  RouteUserBuilder? _user;
  RouteUserBuilder get user => _$this._user ??= new RouteUserBuilder();
  set user(RouteUserBuilder? user) => _$this._user = user;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  RouteHistoricalEventPointBuilder? _start;
  RouteHistoricalEventPointBuilder get start =>
      _$this._start ??= new RouteHistoricalEventPointBuilder();
  set start(RouteHistoricalEventPointBuilder? start) => _$this._start = start;

  RouteHistoricalEventPointBuilder? _end;
  RouteHistoricalEventPointBuilder get end =>
      _$this._end ??= new RouteHistoricalEventPointBuilder();
  set end(RouteHistoricalEventPointBuilder? end) => _$this._end = end;

  ListBuilder<RouteHistoricalEvent>? _historicalEvents;
  ListBuilder<RouteHistoricalEvent> get historicalEvents =>
      _$this._historicalEvents ??= new ListBuilder<RouteHistoricalEvent>();
  set historicalEvents(ListBuilder<RouteHistoricalEvent>? historicalEvents) =>
      _$this._historicalEvents = historicalEvents;

  UserEntityPictureBuilder? _picture;
  UserEntityPictureBuilder get picture =>
      _$this._picture ??= new UserEntityPictureBuilder();
  set picture(UserEntityPictureBuilder? picture) => _$this._picture = picture;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  RouteBuilder() {
    Route._defaults(this);
  }

  RouteBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _user = $v.user?.toBuilder();
      _title = $v.title;
      _start = $v.start?.toBuilder();
      _end = $v.end?.toBuilder();
      _historicalEvents = $v.historicalEvents?.toBuilder();
      _picture = $v.picture?.toBuilder();
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Route other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Route;
  }

  @override
  void update(void Function(RouteBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Route build() => _build();

  _$Route _build() {
    _$Route _$result;
    try {
      _$result = _$v ??
          new _$Route._(
              id: BuiltValueNullFieldError.checkNotNull(id, r'Route', 'id'),
              createdDate: createdDate,
              updatedDate: updatedDate,
              user: _user?.build(),
              title: title,
              start: _start?.build(),
              end: _end?.build(),
              historicalEvents: _historicalEvents?.build(),
              picture: _picture?.build(),
              description: description);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();

        _$failedField = 'start';
        _start?.build();
        _$failedField = 'end';
        _end?.build();
        _$failedField = 'historicalEvents';
        _historicalEvents?.build();
        _$failedField = 'picture';
        _picture?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Route', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
