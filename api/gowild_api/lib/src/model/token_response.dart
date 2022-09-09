//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'token_response.g.dart';

/// TokenResponse
///
/// Properties:
/// * [accessToken] 
/// * [refreshToken] 
abstract class TokenResponse implements Built<TokenResponse, TokenResponseBuilder> {
    @BuiltValueField(wireName: r'accessToken')
    String get accessToken;

    @BuiltValueField(wireName: r'refreshToken')
    String get refreshToken;

    TokenResponse._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(TokenResponseBuilder b) => b;

    factory TokenResponse([void updates(TokenResponseBuilder b)]) = _$TokenResponse;

    @BuiltValueSerializer(custom: true)
    static Serializer<TokenResponse> get serializer => _$TokenResponseSerializer();
}

class _$TokenResponseSerializer implements StructuredSerializer<TokenResponse> {
    @override
    final Iterable<Type> types = const [TokenResponse, _$TokenResponse];

    @override
    final String wireName = r'TokenResponse';

    @override
    Iterable<Object?> serialize(Serializers serializers, TokenResponse object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'accessToken')
            ..add(serializers.serialize(object.accessToken,
                specifiedType: const FullType(String)));
        result
            ..add(r'refreshToken')
            ..add(serializers.serialize(object.refreshToken,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    TokenResponse deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = TokenResponseBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'accessToken':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.accessToken = valueDes;
                    break;
                case r'refreshToken':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.refreshToken = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

