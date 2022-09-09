//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'file_meta_data.g.dart';

/// FileMetaData
///
/// Properties:
/// * [encoding] 
abstract class FileMetaData implements Built<FileMetaData, FileMetaDataBuilder> {
    @BuiltValueField(wireName: r'encoding')
    String? get encoding;

    FileMetaData._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(FileMetaDataBuilder b) => b;

    factory FileMetaData([void updates(FileMetaDataBuilder b)]) = _$FileMetaData;

    @BuiltValueSerializer(custom: true)
    static Serializer<FileMetaData> get serializer => _$FileMetaDataSerializer();
}

class _$FileMetaDataSerializer implements StructuredSerializer<FileMetaData> {
    @override
    final Iterable<Type> types = const [FileMetaData, _$FileMetaData];

    @override
    final String wireName = r'FileMetaData';

    @override
    Iterable<Object?> serialize(Serializers serializers, FileMetaData object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'encoding')
            ..add(object.encoding == null ? null : serializers.serialize(object.encoding,
                specifiedType: const FullType.nullable(String)));
        return result;
    }

    @override
    FileMetaData deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = FileMetaDataBuilder();

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

