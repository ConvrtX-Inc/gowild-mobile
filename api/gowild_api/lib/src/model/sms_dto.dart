//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sms_dto.g.dart';

/// SmsDto
///
/// Properties:
/// * [phoneNumber] 
/// * [message] 
abstract class SmsDto implements Built<SmsDto, SmsDtoBuilder> {
    @BuiltValueField(wireName: r'phone_number')
    String get phoneNumber;

    @BuiltValueField(wireName: r'message')
    String get message;

    SmsDto._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(SmsDtoBuilder b) => b;

    factory SmsDto([void updates(SmsDtoBuilder b)]) = _$SmsDto;

    @BuiltValueSerializer(custom: true)
    static Serializer<SmsDto> get serializer => _$SmsDtoSerializer();
}

class _$SmsDtoSerializer implements StructuredSerializer<SmsDto> {
    @override
    final Iterable<Type> types = const [SmsDto, _$SmsDto];

    @override
    final String wireName = r'SmsDto';

    @override
    Iterable<Object?> serialize(Serializers serializers, SmsDto object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'phone_number')
            ..add(serializers.serialize(object.phoneNumber,
                specifiedType: const FullType(String)));
        result
            ..add(r'message')
            ..add(serializers.serialize(object.message,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    SmsDto deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = SmsDtoBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'phone_number':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.phoneNumber = valueDes;
                    break;
                case r'message':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.message = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

