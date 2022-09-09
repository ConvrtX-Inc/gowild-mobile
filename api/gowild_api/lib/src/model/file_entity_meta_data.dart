//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:gowild_api/src/model/file_meta_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'file_entity_meta_data.g.dart';

/// FileEntityMetaData
///
/// Properties:
/// * [encoding] 
abstract class FileEntityMetaData implements Built<FileEntityMetaData, FileEntityMetaDataBuilder> {
    @BuiltValueField(wireName: r'encoding')
    String? get encoding;

    FileEntityMetaData._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(FileEntityMetaDataBuilder b) => b;

    factory FileEntityMetaData([void updates(FileEntityMetaDataBuilder b)]) = _$FileEntityMetaData;

    @BuiltValueSerializer(custom: true)
    static Serializer<FileEntityMetaData> get serializer => _$FileEntityMetaDataSerializer();
}

class _$FileEntityMetaDataSerializer implements StructuredSerializer<FileEntityMetaData> {
    @override
    final Iterable<Type> types = const [FileEntityMetaData, _$FileEntityMetaData];

    @override
    final String wireName = r'FileEntityMetaData';

    @override
    Iterable<Object?> serialize(Serializers serializers, FileEntityMetaData object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'encoding')
            ..add(object.encoding == null ? null : serializers.serialize(object.encoding,
                specifiedType: const FullType.nullable(String)));
        return result;
    }

    @override
    FileEntityMetaData deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = FileEntityMetaDataBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'encoding':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.encoding = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

