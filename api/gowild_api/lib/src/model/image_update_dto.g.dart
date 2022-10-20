// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_update_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ImageUpdateDto extends ImageUpdateDto {
  @override
  final String fileId;

  factory _$ImageUpdateDto([void Function(ImageUpdateDtoBuilder)? updates]) =>
      (new ImageUpdateDtoBuilder()..update(updates))._build();

  _$ImageUpdateDto._({required this.fileId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(fileId, r'ImageUpdateDto', 'fileId');
  }

  @override
  ImageUpdateDto rebuild(void Function(ImageUpdateDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ImageUpdateDtoBuilder toBuilder() =>
      new ImageUpdateDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ImageUpdateDto && fileId == other.fileId;
  }

  @override
  int get hashCode {
    return $jf($jc(0, fileId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ImageUpdateDto')
          ..add('fileId', fileId))
        .toString();
  }
}

class ImageUpdateDtoBuilder
    implements Builder<ImageUpdateDto, ImageUpdateDtoBuilder> {
  _$ImageUpdateDto? _$v;

  String? _fileId;
  String? get fileId => _$this._fileId;
  set fileId(String? fileId) => _$this._fileId = fileId;

  ImageUpdateDtoBuilder() {
    ImageUpdateDto._defaults(this);
  }

  ImageUpdateDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fileId = $v.fileId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ImageUpdateDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ImageUpdateDto;
  }

  @override
  void update(void Function(ImageUpdateDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ImageUpdateDto build() => _build();

  _$ImageUpdateDto _build() {
    final _$result = _$v ??
        new _$ImageUpdateDto._(
            fileId: BuiltValueNullFieldError.checkNotNull(
                fileId, r'ImageUpdateDto', 'fileId'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
