//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'check_verification_token_dto.g.dart';

/// CheckVerificationTokenDto
///
/// Properties:
/// * [phoneNumber] 
/// * [verifyCode] 
abstract class CheckVerificationTokenDto implements Built<CheckVerificationTokenDto, CheckVerificationTokenDtoBuilder> {
    @BuiltValueField(wireName: r'phone_number')
    String get phoneNumber;

    @BuiltValueField(wireName: r'verify_code')
    String get verifyCode;

    CheckVerificationTokenDto._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(CheckVerificationTokenDtoBuilder b) => b;

    factory CheckVerificationTokenDto([void updates(CheckVerificationTokenDtoBuilder b)]) = _$CheckVerificationTokenDto;

    @BuiltValueSerializer(custom: true)
    static Serializer<CheckVerificationTokenDto> get serializer => _$CheckVerificationTokenDtoSerializer();
}

class _$CheckVerificationTokenDtoSerializer implements StructuredSerializer<CheckVerificationTokenDto> {
    @override
    final Iterable<Type> types = const [CheckVerificationTokenDto, _$CheckVerificationTokenDto];

    @override
    final String wireName = r'CheckVerificationTokenDto';

    @override
    Iterable<Object?> serialize(Serializers serializers, CheckVerificationTokenDto object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'phone_number')
            ..add(serializers.serialize(object.phoneNumber,
                specifiedType: const FullType(String)));
        result
            ..add(r'verify_code')
            ..add(serializers.serialize(object.verifyCode,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    CheckVerificationTokenDto deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = CheckVerificationTokenDtoBuilder();

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
                case r'verify_code':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.verifyCode = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

