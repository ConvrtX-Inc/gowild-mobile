//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_verification_token_dto.g.dart';

/// SendVerificationTokenDto
///
/// Properties:
/// * [phoneNumber] 
abstract class SendVerificationTokenDto implements Built<SendVerificationTokenDto, SendVerificationTokenDtoBuilder> {
    @BuiltValueField(wireName: r'phone_number')
    String get phoneNumber;

    SendVerificationTokenDto._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(SendVerificationTokenDtoBuilder b) => b;

    factory SendVerificationTokenDto([void updates(SendVerificationTokenDtoBuilder b)]) = _$SendVerificationTokenDto;

    @BuiltValueSerializer(custom: true)
    static Serializer<SendVerificationTokenDto> get serializer => _$SendVerificationTokenDtoSerializer();
}

class _$SendVerificationTokenDtoSerializer implements StructuredSerializer<SendVerificationTokenDto> {
    @override
    final Iterable<Type> types = const [SendVerificationTokenDto, _$SendVerificationTokenDto];

    @override
    final String wireName = r'SendVerificationTokenDto';

    @override
    Iterable<Object?> serialize(Serializers serializers, SendVerificationTokenDto object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'phone_number')
            ..add(serializers.serialize(object.phoneNumber,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    SendVerificationTokenDto deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = SendVerificationTokenDtoBuilder();

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
            }
        }
        return result.build();
    }
}

