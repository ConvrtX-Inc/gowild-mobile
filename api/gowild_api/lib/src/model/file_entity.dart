//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:gowild_api/src/model/file_entity_meta_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'file_entity.g.dart';

/// FileEntity
///
/// Properties:
/// * [id] 
/// * [createdDate] 
/// * [updatedDate] 
/// * [path] 
/// * [size] 
/// * [mimetype] 
/// * [fileName] 
/// * [metaData] 
abstract class FileEntity implements Built<FileEntity, FileEntityBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'createdDate')
    DateTime? get createdDate;

    @BuiltValueField(wireName: r'updatedDate')
    DateTime? get updatedDate;

    @BuiltValueField(wireName: r'path')
    String get path;

    @BuiltValueField(wireName: r'size')
    double get size;

    @BuiltValueField(wireName: r'mimetype')
    String get mimetype;

    @BuiltValueField(wireName: r'fileName')
    String? get fileName;

    @BuiltValueField(wireName: r'metaData')
    FileEntityMetaData? get metaData;

    FileEntity._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(FileEntityBuilder b) => b;

    factory FileEntity([void updates(FileEntityBuilder b)]) = _$FileEntity;

    @BuiltValueSerializer(custom: true)
    static Serializer<FileEntity> get serializer => _$FileEntitySerializer();
}

class _$FileEntitySerializer implements StructuredSerializer<FileEntity> {
    @override
    final Iterable<Type> types = const [FileEntity, _$FileEntity];

    @override
    final String wireName = r'FileEntity';

    @override
    Iterable<Object?> serialize(Serializers serializers, FileEntity object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id')
            ..add(serializers.serialize(object.id,
                specifiedType: const FullType(String)));
        result
            ..add(r'createdDate')
            ..add(object.createdDate == null ? null : serializers.serialize(object.createdDate,
                specifiedType: const FullType.nullable(DateTime)));
        result
            ..add(r'updatedDate')
            ..add(object.updatedDate == null ? null : serializers.serialize(object.updatedDate,
                specifiedType: const FullType.nullable(DateTime)));
        result
            ..add(r'path')
            ..add(serializers.serialize(object.path,
                specifiedType: const FullType(String)));
        result
            ..add(r'size')
            ..add(serializers.serialize(object.size,
                specifiedType: const FullType(double)));
        result
            ..add(r'mimetype')
            ..add(serializers.serialize(object.mimetype,
                specifiedType: const FullType(String)));
        result
            ..add(r'fileName')
            ..add(object.fileName == null ? null : serializers.serialize(object.fileName,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'metaData')
            ..add(object.metaData == null ? null : serializers.serialize(object.metaData,
                specifiedType: const FullType.nullable(FileEntityMetaData)));
        return result;
    }

    @override
    FileEntity deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = FileEntityBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.id = valueDes;
                    break;
                case r'createdDate':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(DateTime)) as DateTime?;
                    if (valueDes == null) continue;
                    result.createdDate = valueDes;
                    break;
                case r'updatedDate':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(DateTime)) as DateTime?;
                    if (valueDes == null) continue;
                    result.updatedDate = valueDes;
                    break;
                case r'path':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.path = valueDes;
                    break;
                case r'size':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(double)) as double;
                    result.size = valueDes;
                    break;
                case r'mimetype':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.mimetype = valueDes;
                    break;
                case r'fileName':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.fileName = valueDes;
                    break;
                case r'metaData':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(FileEntityMetaData)) as FileEntityMetaData?;
                    if (valueDes == null) continue;
                    result.metaData.replace(valueDes);
                    break;
            }
        }
        return result.build();
    }
}

