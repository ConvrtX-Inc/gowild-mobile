// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture_update_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PictureUpdateDto extends PictureUpdateDto {
  @override
  final String fileId;

  factory _$PictureUpdateDto(
          [void Function(PictureUpdateDtoBuilder)? updates]) =>
      (new PictureUpdateDtoBuilder()..update(updates))._build();

  _$PictureUpdateDto._({required this.fileId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        fileId, r'PictureUpdateDto', 'fileId');
  }

  @override
  PictureUpdateDto rebuild(void Function(PictureUpdateDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PictureUpdateDtoBuilder toBuilder() =>
      new PictureUpdateDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PictureUpdateDto && fileId == other.fileId;
  }

  @override
  int get hashCode {
    return $jf($jc(0, fileId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PictureUpdateDto')
          ..add('fileId', fileId))
        .toString();
  }
}

class PictureUpdateDtoBuilder
    implements Builder<PictureUpdateDto, PictureUpdateDtoBuilder> {
  _$PictureUpdateDto? _$v;

  String? _fileId;
  String? get fileId => _$this._fileId;
  set fileId(String? fileId) => _$this._fileId = fileId;

  PictureUpdateDtoBuilder() {
    PictureUpdateDto._defaults(this);
  }

  PictureUpdateDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fileId = $v.fileId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PictureUpdateDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PictureUpdateDto;
  }

  @override
  void update(void Function(PictureUpdateDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PictureUpdateDto build() => _build();

  _$PictureUpdateDto _build() {
    final _$result = _$v ??
        new _$PictureUpdateDto._(
            fileId: BuiltValueNullFieldError.checkNotNull(
                fileId, r'PictureUpdateDto', 'fileId'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
