//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:gowild_api/src/date_serializer.dart';
import 'package:gowild_api/src/model/date.dart';

import 'package:gowild_api/src/model/access_token.dart';
import 'package:gowild_api/src/model/app_point.dart';
import 'package:gowild_api/src/model/auth_email_login_dto.dart';
import 'package:gowild_api/src/model/auth_facebook_login_dto.dart';
import 'package:gowild_api/src/model/auth_forgot_password_dto.dart';
import 'package:gowild_api/src/model/auth_google_login_dto.dart';
import 'package:gowild_api/src/model/auth_refresh_token_dto.dart';
import 'package:gowild_api/src/model/auth_register_login_dto.dart';
import 'package:gowild_api/src/model/auth_reset_password_admin_dto.dart';
import 'package:gowild_api/src/model/auth_reset_password_dto.dart';
import 'package:gowild_api/src/model/check_verification_token_dto.dart';
import 'package:gowild_api/src/model/comment.dart';
import 'package:gowild_api/src/model/currency.dart';
import 'package:gowild_api/src/model/file_entity.dart';
import 'package:gowild_api/src/model/file_entity_meta_data.dart';
import 'package:gowild_api/src/model/file_meta_data.dart';
import 'package:gowild_api/src/model/friends.dart';
import 'package:gowild_api/src/model/gender_enum.dart';
import 'package:gowild_api/src/model/get_many_comment_response_dto.dart';
import 'package:gowild_api/src/model/get_many_currency_response_dto.dart';
import 'package:gowild_api/src/model/get_many_friends_response_dto.dart';
import 'package:gowild_api/src/model/get_many_guideline_log_response_dto.dart';
import 'package:gowild_api/src/model/get_many_guideline_response_dto.dart';
import 'package:gowild_api/src/model/get_many_like_response_dto.dart';
import 'package:gowild_api/src/model/get_many_notification_response_dto.dart';
import 'package:gowild_api/src/model/get_many_participant_response_dto.dart';
import 'package:gowild_api/src/model/get_many_post_feed_response_dto.dart';
import 'package:gowild_api/src/model/get_many_room_response_dto.dart';
import 'package:gowild_api/src/model/get_many_route_clue_response_dto.dart';
import 'package:gowild_api/src/model/get_many_route_historical_event_response_dto.dart';
import 'package:gowild_api/src/model/get_many_route_response_dto.dart';
import 'package:gowild_api/src/model/get_many_share_response_dto.dart';
import 'package:gowild_api/src/model/get_many_social_account_response_dto.dart';
import 'package:gowild_api/src/model/get_many_sponsor_response_dto.dart';
import 'package:gowild_api/src/model/get_many_status_response_dto.dart';
import 'package:gowild_api/src/model/get_many_ticket_message_response_dto.dart';
import 'package:gowild_api/src/model/get_many_ticket_response_dto.dart';
import 'package:gowild_api/src/model/get_many_treasure_chest_response_dto.dart';
import 'package:gowild_api/src/model/get_many_user_entity_response_dto.dart';
import 'package:gowild_api/src/model/guideline.dart';
import 'package:gowild_api/src/model/guideline_log.dart';
import 'package:gowild_api/src/model/health_controller_check200_response.dart';
import 'package:gowild_api/src/model/health_controller_check200_response_info_value.dart';
import 'package:gowild_api/src/model/health_controller_check503_response.dart';
import 'package:gowild_api/src/model/image_update_dto.dart';
import 'package:gowild_api/src/model/like.dart';
import 'package:gowild_api/src/model/notification.dart';
import 'package:gowild_api/src/model/participant.dart';
import 'package:gowild_api/src/model/post_feed.dart';
import 'package:gowild_api/src/model/refresh_token.dart';
import 'package:gowild_api/src/model/room.dart';
import 'package:gowild_api/src/model/route.dart';
import 'package:gowild_api/src/model/route_clue.dart';
import 'package:gowild_api/src/model/route_historical_event.dart';
import 'package:gowild_api/src/model/route_historical_event_point.dart';
import 'package:gowild_api/src/model/route_historical_event_route.dart';
import 'package:gowild_api/src/model/route_user.dart';
import 'package:gowild_api/src/model/send_verification_token_dto.dart';
import 'package:gowild_api/src/model/share.dart';
import 'package:gowild_api/src/model/simple_user.dart';
import 'package:gowild_api/src/model/sms_dto.dart';
import 'package:gowild_api/src/model/social_account.dart';
import 'package:gowild_api/src/model/sponsor.dart';
import 'package:gowild_api/src/model/status.dart';
import 'package:gowild_api/src/model/ticket.dart';
import 'package:gowild_api/src/model/ticket_message.dart';
import 'package:gowild_api/src/model/token_response.dart';
import 'package:gowild_api/src/model/treasure_chest.dart';
import 'package:gowild_api/src/model/user_auth_response.dart';
import 'package:gowild_api/src/model/user_entity.dart';
import 'package:gowild_api/src/model/user_entity_picture.dart';
import 'package:gowild_api/src/model/user_entity_status.dart';

part 'serializers.g.dart';

@SerializersFor([
  AccessToken,
  AppPoint,
  AuthEmailLoginDto,
  AuthFacebookLoginDto,
  AuthForgotPasswordDto,
  AuthGoogleLoginDto,
  AuthRefreshTokenDto,
  AuthRegisterLoginDto,
  AuthResetPasswordAdminDto,
  AuthResetPasswordDto,
  CheckVerificationTokenDto,
  Comment,
  Currency,
  FileEntity,
  FileEntityMetaData,
  FileMetaData,
  Friends,
  GenderEnum,
  GetManyCommentResponseDto,
  GetManyCurrencyResponseDto,
  GetManyFriendsResponseDto,
  GetManyGuidelineLogResponseDto,
  GetManyGuidelineResponseDto,
  GetManyLikeResponseDto,
  GetManyNotificationResponseDto,
  GetManyParticipantResponseDto,
  GetManyPostFeedResponseDto,
  GetManyRoomResponseDto,
  GetManyRouteClueResponseDto,
  GetManyRouteHistoricalEventResponseDto,
  GetManyRouteResponseDto,
  GetManyShareResponseDto,
  GetManySocialAccountResponseDto,
  GetManySponsorResponseDto,
  GetManyStatusResponseDto,
  GetManyTicketMessageResponseDto,
  GetManyTicketResponseDto,
  GetManyTreasureChestResponseDto,
  GetManyUserEntityResponseDto,
  Guideline,
  GuidelineLog,
  HealthControllerCheck200Response,
  HealthControllerCheck200ResponseInfoValue,
  HealthControllerCheck503Response,
  ImageUpdateDto,
  Like,
  Notification,
  Participant,
  PostFeed,
  RefreshToken,
  Room,
  Route,
  RouteClue,
  RouteHistoricalEvent,
  RouteHistoricalEventPoint,
  RouteHistoricalEventRoute,
  RouteUser,
  SendVerificationTokenDto,
  Share,
  SimpleUser,
  SmsDto,
  SocialAccount,
  Sponsor,
  Status,
  Ticket,
  TicketMessage,
  TokenResponse,
  TreasureChest,
  UserAuthResponse,
  UserEntity,
  UserEntityPicture,
  UserEntityStatus,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ImageUpdateDto)]),
        () => ListBuilder<ImageUpdateDto>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(String)]),
        () => ListBuilder<String>(),
      )
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
