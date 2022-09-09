// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_picture.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserPicture extends UserPicture {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final String path;
  @override
  final double size;
  @override
  final String mimetype;
  @override
  final String? fileName;
  @override
  final FileEntityMetaData? metaData;

  factory _$UserPicture([void Function(UserPictureBuilder)? updates]) =>
      (new UserPictureBuilder()..update(updates))._build();

  _$UserPicture._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      required this.path,
      required this.size,
      required this.mimetype,
      this.fileName,
      this.metaData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'UserPicture', 'id');
    BuiltValueNullFieldError.checkNotNull(path, r'UserPicture', 'path');
    BuiltValueNullFieldError.checkNotNull(size, r'UserPicture', 'size');
    BuiltValueNullFieldError.checkNotNull(mimetype, r'UserPicture', 'mimetype');
  }

  @override
  UserPicture rebuild(void Function(UserPictureBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserPictureBuilder toBuilder() => new UserPictureBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserPicture &&
        id == other.id &&
        createdDate == other.createdDate &&
        updatedDate == other.updatedDate &&
        path == other.path &&
        size == other.size &&
        mimetype == other.mimetype &&
        fileName == other.fileName &&
        metaData == other.metaData;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, id.hashCode), createdDate.hashCode),
                            updatedDate.hashCode),
                        path.hashCode),
                    size.hashCode),
                mimetype.hashCode),
            fileName.hashCode),
        metaData.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserPicture')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('path', path)
          ..add('size', size)
          ..add('mimetype', mimetype)
          ..add('fileName', fileName)
          ..add('metaData', metaData))
        .toString();
  }
}

class UserPictureBuilder implements Builder<UserPicture, UserPictureBuilder> {
  _$UserPicture? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  DateTime? _updatedDate;
  DateTime? get updatedDate => _$this._updatedDate;
  set updatedDate(DateTime? updatedDate) => _$this._updatedDate = updatedDate;

  String? _path;
  String? get path => _$this._path;
  set path(String? path) => _$this._path = path;

  double? _size;
  double? get size => _$this._size;
  set size(double? size) => _$this._size = size;

  String? _mimetype;
  String? get mimetype => _$this._mimetype;
  set mimetype(String? mimetype) => _$this._mimetype = mimetype;

  String? _fileName;
  String? get fileName => _$this._fileName;
  set fileName(String? fileName) => _$this._fileName = fileName;

  FileEntityMetaDataBuilder? _metaData;
  FileEntityMetaDataBuilder get metaData =>
      _$this._metaData ??= new FileEntityMetaDataBuilder();
  set metaData(FileEntityMetaDataBuilder? metaData) =>
      _$this._metaData = metaData;

  UserPictureBuilder() {
    UserPicture._defaults(this);
  }

  UserPictureBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _path = $v.path;
      _size = $v.size;
      _mimetype = $v.mimetype;
      _fileName = $v.fileName;
      _metaData = $v.metaData?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserPicture other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserPicture;
  }

  @override
  void update(void Function(UserPictureBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserPicture build() => _build();

  _$UserPicture _build() {
    _$UserPicture _$result;
    try {
      _$result = _$v ??
          new _$UserPicture._(
              id: BuiltValueNullFieldError.checkNotNull(
                  id, r'UserPicture', 'id'),
              createdDate: createdDate,
              updatedDate: updatedDate,
              path: BuiltValueNullFieldError.checkNotNull(
                  path, r'UserPicture', 'path'),
              size: BuiltValueNullFieldError.checkNotNull(
                  size, r'UserPicture', 'size'),
              mimetype: BuiltValueNullFieldError.checkNotNull(
                  mimetype, r'UserPicture', 'mimetype'),
              fileName: fileName,
              metaData: _metaData?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'metaData';
        _metaData?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'UserPicture', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
