//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sponsor.g.dart';

/// Sponsor
///
/// Properties:
/// * [treasureChestId] 
/// * [imgUrl] 
/// * [img] 
/// * [link] 
abstract class Sponsor implements Built<Sponsor, SponsorBuilder> {
    @BuiltValueField(wireName: r'treasure_chest_id')
    String get treasureChestId;

    @BuiltValueField(wireName: r'img_url')
    String get imgUrl;

    @BuiltValueField(wireName: r'img')
    JsonObject get img;

    @BuiltValueField(wireName: r'link')
    String get link;

    Sponsor._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(SponsorBuilder b) => b;

    factory Sponsor([void updates(SponsorBuilder b)]) = _$Sponsor;

    @BuiltValueSerializer(custom: true)
    static Serializer<Sponsor> get serializer => _$SponsorSerializer();
}

class _$SponsorSerializer implements StructuredSerializer<Sponsor> {
    @override
    final Iterable<Type> types = const [Sponsor, _$Sponsor];

    @override
    final String wireName = r'Sponsor';

    @override
    Iterable<Object?> serialize(Serializers serializers, Sponsor object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'treasure_chest_id')
            ..add(serializers.serialize(object.treasureChestId,
                specifiedType: const FullType(String)));
        result
            ..add(r'img_url')
            ..add(serializers.serialize(object.imgUrl,
                specifiedType: const FullType(String)));
        result
            ..add(r'img')
            ..add(serializers.serialize(object.img,
                specifiedType: const FullType(JsonObject)));
        result
            ..add(r'link')
            ..add(serializers.serialize(object.link,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    Sponsor deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = SponsorBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'treasure_chest_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.treasureChestId = valueDes;
                    break;
                case r'img_url':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.imgUrl = valueDes;
                    break;
                case r'img':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(JsonObject)) as JsonObject;
                    result.img = valueDes;
                    break;
                case r'link':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.link = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

