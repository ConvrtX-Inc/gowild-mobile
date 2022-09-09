//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'picture_update_dto.g.dart';

/// PictureUpdateDto
///
/// Properties:
/// * [fileId] 
abstract class PictureUpdateDto implements Built<PictureUpdateDto, PictureUpdateDtoBuilder> {
    @BuiltValueField(wireName: r'fileId')
    String get fileId;

    PictureUpdateDto._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(PictureUpdateDtoBuilder b) => b;

    factory PictureUpdateDto([void updates(PictureUpdateDtoBuilder b)]) = _$PictureUpdateDto;

    @BuiltValueSerializer(custom: true)
    static Serializer<PictureUpdateDto> get serializer => _$PictureUpdateDtoSerializer();
}

class _$PictureUpdateDtoSerializer implements StructuredSerializer<PictureUpdateDto> {
    @override
    final Iterable<Type> types = const [PictureUpdateDto, _$PictureUpdateDto];

    @override
    final String wireName = r'PictureUpdateDto';

    @override
    Iterable<Object?> serialize(Serializers serializers, PictureUpdateDto object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'fileId')
            ..add(serializers.serialize(object.fileId,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    PictureUpdateDto deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = PictureUpdateDtoBuilder();

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

