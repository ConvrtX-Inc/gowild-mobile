// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_meta_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FileMetaData extends FileMetaData {
  @override
  final String? encoding;

  factory _$FileMetaData([void Function(FileMetaDataBuilder)? updates]) =>
      (new FileMetaDataBuilder()..update(updates))._build();

  _$FileMetaData._({this.encoding}) : super._();

  @override
  FileMetaData rebuild(void Function(FileMetaDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FileMetaDataBuilder toBuilder() => new FileMetaDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FileMetaData && encoding == other.encoding;
  }

  @override
  int get hashCode {
    return $jf($jc(0, encoding.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FileMetaData')
          ..add('encoding', encoding))
        .toString();
  }
}

class FileMetaDataBuilder
    implements Builder<FileMetaData, FileMetaDataBuilder> {
  _$FileMetaData? _$v;

  String? _encoding;
  String? get encoding => _$this._encoding;
  set encoding(String? encoding) => _$this._encoding = encoding;

  FileMetaDataBuilder() {
    FileMetaData._defaults(this);
  }

  FileMetaDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _encoding = $v.encoding;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FileMetaData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FileMetaData;
  }

  @override
  void update(void Function(FileMetaDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FileMetaData build() => _build();

  _$FileMetaData _build() {
    final _$result = _$v ?? new _$FileMetaData._(encoding: encoding);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
