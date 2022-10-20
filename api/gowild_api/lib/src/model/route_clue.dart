//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:gowild_api/src/model/app_point.dart';
import 'package:gowild_api/src/model/file_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'route_clue.g.dart';

/// RouteClue
///
/// Properties:
/// * [id] 
/// * [createdDate] 
/// * [updatedDate] 
/// * [routeId] 
/// * [point] 
/// * [title] 
/// * [description] 
/// * [medias] 
/// * [arClue] 
abstract class RouteClue implements Built<RouteClue, RouteClueBuilder> {
    @BuiltValueField(wireName: r'id')
    String get id;

    @BuiltValueField(wireName: r'createdDate')
    DateTime? get createdDate;

    @BuiltValueField(wireName: r'updatedDate')
    DateTime? get updatedDate;

    @BuiltValueField(wireName: r'route_id')
    String get routeId;

    @BuiltValueField(wireName: r'point')
    AppPoint get point;

    @BuiltValueField(wireName: r'title')
    String get title;

    @BuiltValueField(wireName: r'description')
    String get description;

    @BuiltValueField(wireName: r'medias')
    BuiltList<FileEntity>? get medias;

    @BuiltValueField(wireName: r'ar_clue')
    String get arClue;

    RouteClue._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(RouteClueBuilder b) => b;

    factory RouteClue([void updates(RouteClueBuilder b)]) = _$RouteClue;

    @BuiltValueSerializer(custom: true)
    static Serializer<RouteClue> get serializer => _$RouteClueSerializer();
}

class _$RouteClueSerializer implements StructuredSerializer<RouteClue> {
    @override
    final Iterable<Type> types = const [RouteClue, _$RouteClue];

    @override
    final String wireName = r'RouteClue';

    @override
    Iterable<Object?> serialize(Serializers serializers, RouteClue object,
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
            ..add(r'route_id')
            ..add(serializers.serialize(object.routeId,
                specifiedType: const FullType(String)));
        result
            ..add(r'point')
            ..add(serializers.serialize(object.point,
                specifiedType: const FullType(AppPoint)));
        result
            ..add(r'title')
            ..add(serializers.serialize(object.title,
                specifiedType: const FullType(String)));
        result
            ..add(r'description')
            ..add(serializers.serialize(object.description,
                specifiedType: const FullType(String)));
        result
            ..add(r'medias')
            ..add(object.medias == null ? null : serializers.serialize(object.medias,
                specifiedType: const FullType.nullable(BuiltList, [FullType(FileEntity)])));
        result
            ..add(r'ar_clue')
            ..add(serializers.serialize(object.arClue,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    RouteClue deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = RouteClueBuilder();

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
                case r'route_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.routeId = valueDes;
                    break;
                case r'point':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(AppPoint)) as AppPoint;
                    result.point.replace(valueDes);
                    break;
                case r'title':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.title = valueDes;
                    break;
                case r'description':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.description = valueDes;
                    break;
                case r'medias':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType.nullable(BuiltList, [FullType(FileEntity)])) as BuiltList<FileEntity>?;
                    if (valueDes == null) continue;
                    result.medias.replace(valueDes);
                    break;
                case r'ar_clue':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.arClue = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

