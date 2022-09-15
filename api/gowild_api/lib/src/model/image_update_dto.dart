//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'image_update_dto.g.dart';

/// ImageUpdateDto
///
/// Properties:
/// * [fileId] 
abstract class ImageUpdateDto implements Built<ImageUpdateDto, ImageUpdateDtoBuilder> {
    @BuiltValueField(wireName: r'fileId')
    String get fileId;

    ImageUpdateDto._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(ImageUpdateDtoBuilder b) => b;

    factory ImageUpdateDto([void updates(ImageUpdateDtoBuilder b)]) = _$ImageUpdateDto;

    @BuiltValueSerializer(custom: true)
    static Serializer<ImageUpdateDto> get serializer => _$ImageUpdateDtoSerializer();
}

class _$ImageUpdateDtoSerializer implements StructuredSerializer<ImageUpdateDto> {
    @override
    final Iterable<Type> types = const [ImageUpdateDto, _$ImageUpdateDto];

    @override
    final String wireName = r'ImageUpdateDto';

    @override
    Iterable<Object?> serialize(Serializers serializers, ImageUpdateDto object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'fileId')
            ..add(serializers.serialize(object.fileId,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    ImageUpdateDto deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = ImageUpdateDtoBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'fileId':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.fileId = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

