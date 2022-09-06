// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'dio_client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BuildDioOptions {
  bool get withCookies => throw _privateConstructorUsedError;
  bool get withLogger => throw _privateConstructorUsedError;
  bool get withCache => throw _privateConstructorUsedError;
  bool get withRetry => throw _privateConstructorUsedError;
  String get baseUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BuildDioOptionsCopyWith<BuildDioOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuildDioOptionsCopyWith<$Res> {
  factory $BuildDioOptionsCopyWith(
          BuildDioOptions value, $Res Function(BuildDioOptions) then) =
      _$BuildDioOptionsCopyWithImpl<$Res>;
  $Res call(
      {bool withCookies,
      bool withLogger,
      bool withCache,
      bool withRetry,
      String baseUrl});
}

/// @nodoc
class _$BuildDioOptionsCopyWithImpl<$Res>
    implements $BuildDioOptionsCopyWith<$Res> {
  _$BuildDioOptionsCopyWithImpl(this._value, this._then);

  final BuildDioOptions _value;
  // ignore: unused_field
  final $Res Function(BuildDioOptions) _then;

  @override
  $Res call({
    Object? withCookies = freezed,
    Object? withLogger = freezed,
    Object? withCache = freezed,
    Object? withRetry = freezed,
    Object? baseUrl = freezed,
  }) {
    return _then(_value.copyWith(
      withCookies: withCookies == freezed
          ? _value.withCookies
          : withCookies // ignore: cast_nullable_to_non_nullable
              as bool,
      withLogger: withLogger == freezed
          ? _value.withLogger
          : withLogger // ignore: cast_nullable_to_non_nullable
              as bool,
      withCache: withCache == freezed
          ? _value.withCache
          : withCache // ignore: cast_nullable_to_non_nullable
              as bool,
      withRetry: withRetry == freezed
          ? _value.withRetry
          : withRetry // ignore: cast_nullable_to_non_nullable
              as bool,
      baseUrl: baseUrl == freezed
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_BuildDioOptionsCopyWith<$Res>
    implements $BuildDioOptionsCopyWith<$Res> {
  factory _$$_BuildDioOptionsCopyWith(
          _$_BuildDioOptions value, $Res Function(_$_BuildDioOptions) then) =
      __$$_BuildDioOptionsCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool withCookies,
      bool withLogger,
      bool withCache,
      bool withRetry,
      String baseUrl});
}

/// @nodoc
class __$$_BuildDioOptionsCopyWithImpl<$Res>
    extends _$BuildDioOptionsCopyWithImpl<$Res>
    implements _$$_BuildDioOptionsCopyWith<$Res> {
  __$$_BuildDioOptionsCopyWithImpl(
      _$_BuildDioOptions _value, $Res Function(_$_BuildDioOptions) _then)
      : super(_value, (v) => _then(v as _$_BuildDioOptions));

  @override
  _$_BuildDioOptions get _value => super._value as _$_BuildDioOptions;

  @override
  $Res call({
    Object? withCookies = freezed,
    Object? withLogger = freezed,
    Object? withCache = freezed,
    Object? withRetry = freezed,
    Object? baseUrl = freezed,
  }) {
    return _then(_$_BuildDioOptions(
      withCookies: withCookies == freezed
          ? _value.withCookies
          : withCookies // ignore: cast_nullable_to_non_nullable
              as bool,
      withLogger: withLogger == freezed
          ? _value.withLogger
          : withLogger // ignore: cast_nullable_to_non_nullable
              as bool,
      withCache: withCache == freezed
          ? _value.withCache
          : withCache // ignore: cast_nullable_to_non_nullable
              as bool,
      withRetry: withRetry == freezed
          ? _value.withRetry
          : withRetry // ignore: cast_nullable_to_non_nullable
              as bool,
      baseUrl: baseUrl == freezed
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_BuildDioOptions implements _BuildDioOptions {
  _$_BuildDioOptions(
      {required this.withCookies,
      required this.withLogger,
      required this.withCache,
      required this.withRetry,
      required this.baseUrl});

  @override
  final bool withCookies;
  @override
  final bool withLogger;
  @override
  final bool withCache;
  @override
  final bool withRetry;
  @override
  final String baseUrl;

  @override
  String toString() {
    return 'BuildDioOptions(withCookies: $withCookies, withLogger: $withLogger, withCache: $withCache, withRetry: $withRetry, baseUrl: $baseUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BuildDioOptions &&
            const DeepCollectionEquality()
                .equals(other.withCookies, withCookies) &&
            const DeepCollectionEquality()
                .equals(other.withLogger, withLogger) &&
            const DeepCollectionEquality().equals(other.withCache, withCache) &&
            const DeepCollectionEquality().equals(other.withRetry, withRetry) &&
            const DeepCollectionEquality().equals(other.baseUrl, baseUrl));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(withCookies),
      const DeepCollectionEquality().hash(withLogger),
      const DeepCollectionEquality().hash(withCache),
      const DeepCollectionEquality().hash(withRetry),
      const DeepCollectionEquality().hash(baseUrl));

  @JsonKey(ignore: true)
  @override
  _$$_BuildDioOptionsCopyWith<_$_BuildDioOptions> get copyWith =>
      __$$_BuildDioOptionsCopyWithImpl<_$_BuildDioOptions>(this, _$identity);
}

abstract class _BuildDioOptions implements BuildDioOptions {
  factory _BuildDioOptions(
      {required final bool withCookies,
      required final bool withLogger,
      required final bool withCache,
      required final bool withRetry,
      required final String baseUrl}) = _$_BuildDioOptions;

  @override
  bool get withCookies;
  @override
  bool get withLogger;
  @override
  bool get withCache;
  @override
  bool get withRetry;
  @override
  String get baseUrl;
  @override
  @JsonKey(ignore: true)
  _$$_BuildDioOptionsCopyWith<_$_BuildDioOptions> get copyWith =>
      throw _privateConstructorUsedError;
}
