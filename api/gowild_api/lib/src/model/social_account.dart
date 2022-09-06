//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'social_account.g.dart';

/// SocialAccount
///
/// Properties:
/// * [userId] 
/// * [description] 
/// * [accountEmail] 
/// * [socialId] 
/// * [provider] 
abstract class SocialAccount implements Built<SocialAccount, SocialAccountBuilder> {
    @BuiltValueField(wireName: r'user_id')
    String get userId;

    @BuiltValueField(wireName: r'description')
    String get description;

    @BuiltValueField(wireName: r'account_email')
    String get accountEmail;

    @BuiltValueField(wireName: r'social_id')
    String get socialId;

    @BuiltValueField(wireName: r'provider')
    String get provider;

    SocialAccount._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(SocialAccountBuilder b) => b;

    factory SocialAccount([void updates(SocialAccountBuilder b)]) = _$SocialAccount;

    @BuiltValueSerializer(custom: true)
    static Serializer<SocialAccount> get serializer => _$SocialAccountSerializer();
}

class _$SocialAccountSerializer implements StructuredSerializer<SocialAccount> {
    @override
    final Iterable<Type> types = const [SocialAccount, _$SocialAccount];

    @override
    final String wireName = r'SocialAccount';

    @override
    Iterable<Object?> serialize(Serializers serializers, SocialAccount object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'user_id')
            ..add(serializers.serialize(object.userId,
                specifiedType: const FullType(String)));
        result
            ..add(r'description')
            ..add(serializers.serialize(object.description,
                specifiedType: const FullType(String)));
        result
            ..add(r'account_email')
            ..add(serializers.serialize(object.accountEmail,
                specifiedType: const FullType(String)));
        result
            ..add(r'social_id')
            ..add(serializers.serialize(object.socialId,
                specifiedType: const FullType(String)));
        result
            ..add(r'provider')
            ..add(serializers.serialize(object.provider,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    SocialAccount deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = SocialAccountBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'user_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.userId = valueDes;
                    break;
                case r'description':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.description = valueDes;
                    break;
                case r'account_email':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.accountEmail = valueDes;
                    break;
                case r'social_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.socialId = valueDes;
                    break;
                case r'provider':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.provider = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

