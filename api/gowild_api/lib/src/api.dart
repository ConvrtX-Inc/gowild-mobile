//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:dio/dio.dart';
import 'package:built_value/serializer.dart';
import 'package:gowild_api/src/serializers.dart';
import 'package:gowild_api/src/auth/api_key_auth.dart';
import 'package:gowild_api/src/auth/basic_auth.dart';
import 'package:gowild_api/src/auth/bearer_auth.dart';
import 'package:gowild_api/src/auth/oauth.dart';
import 'package:gowild_api/src/api/auth_api.dart';
import 'package:gowild_api/src/api/comment_api.dart';
import 'package:gowild_api/src/api/currencies_api.dart';
import 'package:gowild_api/src/api/files_api.dart';
import 'package:gowild_api/src/api/friends_api.dart';
import 'package:gowild_api/src/api/guideline_logs_api.dart';
import 'package:gowild_api/src/api/guidelines_api.dart';
import 'package:gowild_api/src/api/home_api.dart';
import 'package:gowild_api/src/api/like_api.dart';
import 'package:gowild_api/src/api/notification_api.dart';
import 'package:gowild_api/src/api/participant_api.dart';
import 'package:gowild_api/src/api/post_feed_api.dart';
import 'package:gowild_api/src/api/room_api.dart';
import 'package:gowild_api/src/api/route_api.dart';
import 'package:gowild_api/src/api/route_clues_api.dart';
import 'package:gowild_api/src/api/route_historical_event_api.dart';
import 'package:gowild_api/src/api/route_historical_event_photo_api.dart';
import 'package:gowild_api/src/api/share_api.dart';
import 'package:gowild_api/src/api/sms_api.dart';
import 'package:gowild_api/src/api/sponsor_api.dart';
import 'package:gowild_api/src/api/status_api.dart';
import 'package:gowild_api/src/api/ticket_api.dart';
import 'package:gowild_api/src/api/ticket_messages_api.dart';
import 'package:gowild_api/src/api/treasure_chest_api.dart';
import 'package:gowild_api/src/api/users_api.dart';
import 'package:gowild_api/src/api/verify_api.dart';

class GowildApi {
  static const String basePath = r'http://localhost';

  final Dio dio;
  final Serializers serializers;

  GowildApi({
    Dio? dio,
    Serializers? serializers,
    String? basePathOverride,
    List<Interceptor>? interceptors,
  })  : this.serializers = serializers ?? standardSerializers,
        this.dio = dio ??
            Dio(BaseOptions(
              baseUrl: basePathOverride ?? basePath,
              connectTimeout: 5000,
              receiveTimeout: 3000,
            )) {
    if (interceptors == null) {
      this.dio.interceptors.addAll([
        OAuthInterceptor(),
        BasicAuthInterceptor(),
        BearerAuthInterceptor(),
        ApiKeyAuthInterceptor(),
      ]);
    } else {
      this.dio.interceptors.addAll(interceptors);
    }
  }

  void setOAuthToken(String name, String token) {
    if (this.dio.interceptors.any((i) => i is OAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is OAuthInterceptor) as OAuthInterceptor).tokens[name] = token;
    }
  }

  void setBearerAuth(String name, String token) {
    if (this.dio.interceptors.any((i) => i is BearerAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BearerAuthInterceptor) as BearerAuthInterceptor).tokens[name] = token;
    }
  }

  void setBasicAuth(String name, String username, String password) {
    if (this.dio.interceptors.any((i) => i is BasicAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BasicAuthInterceptor) as BasicAuthInterceptor).authInfo[name] = BasicAuthInfo(username, password);
    }
  }

  void setApiKey(String name, String apiKey) {
    if (this.dio.interceptors.any((i) => i is ApiKeyAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((element) => element is ApiKeyAuthInterceptor) as ApiKeyAuthInterceptor).apiKeys[name] = apiKey;
    }
  }

  /// Get AuthApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AuthApi getAuthApi() {
    return AuthApi(dio, serializers);
  }

  /// Get CommentApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  CommentApi getCommentApi() {
    return CommentApi(dio, serializers);
  }

  /// Get CurrenciesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  CurrenciesApi getCurrenciesApi() {
    return CurrenciesApi(dio, serializers);
  }

  /// Get FilesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  FilesApi getFilesApi() {
    return FilesApi(dio, serializers);
  }

  /// Get FriendsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  FriendsApi getFriendsApi() {
    return FriendsApi(dio, serializers);
  }

  /// Get GuidelineLogsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  GuidelineLogsApi getGuidelineLogsApi() {
    return GuidelineLogsApi(dio, serializers);
  }

  /// Get GuidelinesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  GuidelinesApi getGuidelinesApi() {
    return GuidelinesApi(dio, serializers);
  }

  /// Get HomeApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  HomeApi getHomeApi() {
    return HomeApi(dio, serializers);
  }

  /// Get LikeApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  LikeApi getLikeApi() {
    return LikeApi(dio, serializers);
  }

  /// Get NotificationApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  NotificationApi getNotificationApi() {
    return NotificationApi(dio, serializers);
  }

  /// Get ParticipantApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ParticipantApi getParticipantApi() {
    return ParticipantApi(dio, serializers);
  }

  /// Get PostFeedApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  PostFeedApi getPostFeedApi() {
    return PostFeedApi(dio, serializers);
  }

  /// Get RoomApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  RoomApi getRoomApi() {
    return RoomApi(dio, serializers);
  }

  /// Get RouteApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  RouteApi getRouteApi() {
    return RouteApi(dio, serializers);
  }

  /// Get RouteCluesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  RouteCluesApi getRouteCluesApi() {
    return RouteCluesApi(dio, serializers);
  }

  /// Get RouteHistoricalEventApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  RouteHistoricalEventApi getRouteHistoricalEventApi() {
    return RouteHistoricalEventApi(dio, serializers);
  }

  /// Get RouteHistoricalEventPhotoApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  RouteHistoricalEventPhotoApi getRouteHistoricalEventPhotoApi() {
    return RouteHistoricalEventPhotoApi(dio, serializers);
  }

  /// Get ShareApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ShareApi getShareApi() {
    return ShareApi(dio, serializers);
  }

  /// Get SmsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  SmsApi getSmsApi() {
    return SmsApi(dio, serializers);
  }

  /// Get SponsorApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  SponsorApi getSponsorApi() {
    return SponsorApi(dio, serializers);
  }

  /// Get StatusApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  StatusApi getStatusApi() {
    return StatusApi(dio, serializers);
  }

  /// Get TicketApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TicketApi getTicketApi() {
    return TicketApi(dio, serializers);
  }

  /// Get TicketMessagesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TicketMessagesApi getTicketMessagesApi() {
    return TicketMessagesApi(dio, serializers);
  }

  /// Get TreasureChestApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TreasureChestApi getTreasureChestApi() {
    return TreasureChestApi(dio, serializers);
  }

  /// Get UsersApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  UsersApi getUsersApi() {
    return UsersApi(dio, serializers);
  }

  /// Get VerifyApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  VerifyApi getVerifyApi() {
    return VerifyApi(dio, serializers);
  }
}
