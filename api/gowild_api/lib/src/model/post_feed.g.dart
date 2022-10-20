// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_feed.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PostFeed extends PostFeed {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String description;
  @override
  final JsonObject img;
  @override
  final bool isPublished;
  @override
  final num views;

  factory _$PostFeed([void Function(PostFeedBuilder)? updates]) =>
      (new PostFeedBuilder()..update(updates))._build();

  _$PostFeed._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      required this.userId,
      required this.title,
      required this.description,
      required this.img,
      required this.isPublished,
      required this.views})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'PostFeed', 'id');
    BuiltValueNullFieldError.checkNotNull(userId, r'PostFeed', 'userId');
    BuiltValueNullFieldError.checkNotNull(title, r'PostFeed', 'title');
    BuiltValueNullFieldError.checkNotNull(
        description, r'PostFeed', 'description');
    BuiltValueNullFieldError.checkNotNull(img, r'PostFeed', 'img');
    BuiltValueNullFieldError.checkNotNull(
        isPublished, r'PostFeed', 'isPublished');
    BuiltValueNullFieldError.checkNotNull(views, r'PostFeed', 'views');
  }

  @override
  PostFeed rebuild(void Function(PostFeedBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PostFeedBuilder toBuilder() => new PostFeedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PostFeed &&
        id == other.id &&
        createdDate == other.createdDate &&
        updatedDate == other.updatedDate &&
        userId == other.userId &&
        title == other.title &&
        description == other.description &&
        img == other.img &&
        isPublished == other.isPublished &&
        views == other.views;
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
                            userId.hashCode),
                        title.hashCode),
                    description.hashCode),
                img.hashCode),
            isPublished.hashCode),
        views.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PostFeed')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('userId', userId)
          ..add('title', title)
          ..add('description', description)
          ..add('img', img)
          ..add('isPublished', isPublished)
          ..add('views', views))
        .toString();
  }
}

class PostFeedBuilder implements Builder<PostFeed, PostFeedBuilder> {
  _$PostFeed? _$v;

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

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  JsonObject? _img;
  JsonObject? get img => _$this._img;
  set img(JsonObject? img) => _$this._img = img;

  bool? _isPublished;
  bool? get isPublished => _$this._isPublished;
  set isPublished(bool? isPublished) => _$this._isPublished = isPublished;

  num? _views;
  num? get views => _$this._views;
  set views(num? views) => _$this._views = views;

  PostFeedBuilder() {
    PostFeed._defaults(this);
  }

  PostFeedBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _userId = $v.userId;
      _title = $v.title;
      _description = $v.description;
      _img = $v.img;
      _isPublished = $v.isPublished;
      _views = $v.views;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PostFeed other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PostFeed;
  }

  @override
  void update(void Function(PostFeedBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PostFeed build() => _build();

  _$PostFeed _build() {
    final _$result = _$v ??
        new _$PostFeed._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'PostFeed', 'id'),
            createdDate: createdDate,
            updatedDate: updatedDate,
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'PostFeed', 'userId'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'PostFeed', 'title'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'PostFeed', 'description'),
            img: BuiltValueNullFieldError.checkNotNull(img, r'PostFeed', 'img'),
            isPublished: BuiltValueNullFieldError.checkNotNull(
                isPublished, r'PostFeed', 'isPublished'),
            views: BuiltValueNullFieldError.checkNotNull(
                views, r'PostFeed', 'views'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
