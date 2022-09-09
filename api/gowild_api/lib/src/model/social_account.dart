//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'social_account.g.dart';

/// SocialAccount
///
/// Properties:
/// * [id] 
/// * [createdDate] 
/// * [updatedDate] 
/// * [userId] 
/// * [description] 
/// * [accountEmail] 
/// * [socialId] 
/// * [provider] 
abstract class SocialAccount implements Built<SocialAccount, SocialAccountBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'createdDate')
    DateTime? get createdDate;

    @BuiltValueField(wireName: r'updatedDate')
    DateTime? get updatedDate;

    @BuiltValueField(wireName: r'userId')
    String get userId;

    @BuiltValueField(wireName: r'description')
    String? get description;

    @BuiltValueField(wireName: r'accountEmail')
    String? get accountEmail;

    @BuiltValueField(wireName: r'socialId')
    String? get socialId;

    @BuiltValueField(wireName: r'provider')
    String? get provider;

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
            ..add(r'userId')
            ..add(serializers.serialize(object.userId,
                specifiedType: const FullType(String)));
        result
            ..add(r'description')
            ..add(object.description == null ? null : serializers.serialize(object.description,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'accountEmail')
            ..add(object.accountEmail == null ? null : serializers.serialize(object.accountEmail,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'socialId')
            ..add(object.socialId == null ? null : serializers.serialize(object.socialId,
                specifiedType: const FullType.nullable(String)));
        result
            ..add(r'provider')
            ..add(object.provider == null ? null : serializers.serialize(object.provider,
                specifiedType: const FullType.nullable(String)));
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
                case r'userId':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.userId = valueDes;
                    break;
                case r'description':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.description = valueDes;
                    break;
                case r'accountEmail':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.accountEmail = valueDes;
                    break;
                case r'socialId':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.socialId = valueDes;
                    break;
                case r'provider':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(String)) as String?;
                    if (valueDes == null) continue;
                    result.provider = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

