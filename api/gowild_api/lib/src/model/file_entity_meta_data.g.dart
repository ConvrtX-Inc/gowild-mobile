// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_entity_meta_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FileEntityMetaData extends FileEntityMetaData {
  @override
  final String? encoding;

  factory _$FileEntityMetaData(
          [void Function(FileEntityMetaDataBuilder)? updates]) =>
      (new FileEntityMetaDataBuilder()..update(updates))._build();

  _$FileEntityMetaData._({this.encoding}) : super._();

  @override
  FileEntityMetaData rebuild(
          void Function(FileEntityMetaDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FileEntityMetaDataBuilder toBuilder() =>
      new FileEntityMetaDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FileEntityMetaData && encoding == other.encoding;
  }

  @override
  int get hashCode {
    return $jf($jc(0, encoding.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FileEntityMetaData')
          ..add('encoding', encoding))
        .toString();
  }
}

class FileEntityMetaDataBuilder
    implements Builder<FileEntityMetaData, FileEntityMetaDataBuilder> {
  _$FileEntityMetaData? _$v;

  String? _encoding;
  String? get encoding => _$this._encoding;
  set encoding(String? encoding) => _$this._encoding = encoding;

  FileEntityMetaDataBuilder() {
    FileEntityMetaData._defaults(this);
  }

  FileEntityMetaDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _encoding = $v.encoding;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FileEntityMetaData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FileEntityMetaData;
  }

  @override
  void update(void Function(FileEntityMetaDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FileEntityMetaData build() => _build();

  _$FileEntityMetaData _build() {
    final _$result = _$v ?? new _$FileEntityMetaData._(encoding: encoding);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
