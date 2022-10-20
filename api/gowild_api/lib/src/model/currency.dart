//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'currency.g.dart';

/// Currency
///
/// Properties:
/// * [id] 
/// * [createdDate] 
/// * [updatedDate] 
/// * [code] 
/// * [name] 
/// * [namePlural] 
/// * [symbol] 
abstract class Currency implements Built<Currency, CurrencyBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'createdDate')
    DateTime? get createdDate;

    @BuiltValueField(wireName: r'updatedDate')
    DateTime? get updatedDate;

    @BuiltValueField(wireName: r'code')
    String get code;

    @BuiltValueField(wireName: r'name')
    String get name;

    @BuiltValueField(wireName: r'namePlural')
    String get namePlural;

    @BuiltValueField(wireName: r'symbol')
    String get symbol;

    Currency._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(CurrencyBuilder b) => b;

    factory Currency([void updates(CurrencyBuilder b)]) = _$Currency;

    @BuiltValueSerializer(custom: true)
    static Serializer<Currency> get serializer => _$CurrencySerializer();
}

class _$CurrencySerializer implements StructuredSerializer<Currency> {
    @override
    final Iterable<Type> types = const [Currency, _$Currency];

    @override
    final String wireName = r'Currency';

    @override
    Iterable<Object?> serialize(Serializers serializers, Currency object,
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
            ..add(r'code')
            ..add(serializers.serialize(object.code,
                specifiedType: const FullType(String)));
        result
            ..add(r'name')
            ..add(serializers.serialize(object.name,
                specifiedType: const FullType(String)));
        result
            ..add(r'namePlural')
            ..add(serializers.serialize(object.namePlural,
                specifiedType: const FullType(String)));
        result
            ..add(r'symbol')
            ..add(serializers.serialize(object.symbol,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    Currency deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = CurrencyBuilder();

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
                case r'code':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.code = valueDes;
                    break;
                case r'name':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.name = valueDes;
                    break;
                case r'namePlural':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.namePlural = valueDes;
                    break;
                case r'symbol':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.symbol = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

