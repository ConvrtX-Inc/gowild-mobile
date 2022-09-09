// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(AccessToken.serializer)
      ..add(AuthEmailLoginDto.serializer)
      ..add(AuthFacebookLoginDto.serializer)
      ..add(AuthForgotPasswordDto.serializer)
      ..add(AuthGoogleLoginDto.serializer)
      ..add(AuthRefreshTokenDto.serializer)
      ..add(AuthRegisterLoginDto.serializer)
      ..add(AuthResetPasswordAdminDto.serializer)
      ..add(AuthResetPasswordDto.serializer)
      ..add(CheckVerificationTokenDto.serializer)
      ..add(Comment.serializer)
      ..add(Currency.serializer)
      ..add(FileEntity.serializer)
      ..add(FileEntityMetaData.serializer)
      ..add(FileMetaData.serializer)
      ..add(Friends.serializer)
      ..add(GenderEnum.serializer)
      ..add(GetManyCommentResponseDto.serializer)
      ..add(GetManyCurrencyResponseDto.serializer)
      ..add(GetManyFriendsResponseDto.serializer)
      ..add(GetManyGuidelineLogResponseDto.serializer)
      ..add(GetManyGuidelineResponseDto.serializer)
      ..add(GetManyLikeResponseDto.serializer)
      ..add(GetManyNotificationResponseDto.serializer)
      ..add(GetManyParticipantResponseDto.serializer)
      ..add(GetManyPostFeedResponseDto.serializer)
      ..add(GetManyRoomResponseDto.serializer)
      ..add(GetManyRouteClueResponseDto.serializer)
      ..add(GetManyRouteHistoricalEventPhotoResponseDto.serializer)
      ..add(GetManyRouteHistoricalEventResponseDto.serializer)
      ..add(GetManyRouteResponseDto.serializer)
      ..add(GetManyShareResponseDto.serializer)
      ..add(GetManySocialAccountResponseDto.serializer)
      ..add(GetManySponsorResponseDto.serializer)
      ..add(GetManyStatusResponseDto.serializer)
      ..add(GetManyTicketMessageResponseDto.serializer)
      ..add(GetManyTicketResponseDto.serializer)
      ..add(GetManyTreasureChestResponseDto.serializer)
      ..add(GetManyUserResponseDto.serializer)
      ..add(Guideline.serializer)
      ..add(GuidelineLog.serializer)
      ..add(HealthControllerCheck200Response.serializer)
      ..add(HealthControllerCheck200ResponseInfoValue.serializer)
      ..add(HealthControllerCheck503Response.serializer)
      ..add(Like.serializer)
      ..add(Notification.serializer)
      ..add(Participant.serializer)
      ..add(PictureUpdateDto.serializer)
      ..add(PostFeed.serializer)
      ..add(RefreshToken.serializer)
      ..add(Room.serializer)
      ..add(Route.serializer)
      ..add(RouteClue.serializer)
      ..add(RouteHistoricalEvent.serializer)
      ..add(RouteHistoricalEventPhoto.serializer)
      ..add(SendVerificationTokenDto.serializer)
      ..add(Share.serializer)
      ..add(SimpleUser.serializer)
      ..add(SmsDto.serializer)
      ..add(SocialAccount.serializer)
      ..add(Sponsor.serializer)
      ..add(Status.serializer)
      ..add(StatusStatusNameEnum.serializer)
      ..add(Ticket.serializer)
      ..add(TicketMessage.serializer)
      ..add(TokenResponse.serializer)
      ..add(TreasureChest.serializer)
      ..add(User.serializer)
      ..add(UserAuthResponse.serializer)
      ..add(UserPicture.serializer)
      ..add(UserStatus.serializer)
      ..add(UserStatusStatusNameEnum.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Comment)]),
          () => new ListBuilder<Comment>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Currency)]),
          () => new ListBuilder<Currency>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Friends)]),
          () => new ListBuilder<Friends>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Guideline)]),
          () => new ListBuilder<Guideline>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GuidelineLog)]),
          () => new ListBuilder<GuidelineLog>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Like)]),
          () => new ListBuilder<Like>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Notification)]),
          () => new ListBuilder<Notification>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Participant)]),
          () => new ListBuilder<Participant>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(PostFeed)]),
          () => new ListBuilder<PostFeed>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Room)]),
          () => new ListBuilder<Room>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Route)]),
          () => new ListBuilder<Route>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(RouteClue)]),
          () => new ListBuilder<RouteClue>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(RouteHistoricalEvent)]),
          () => new ListBuilder<RouteHistoricalEvent>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(RouteHistoricalEventPhoto)]),
          () => new ListBuilder<RouteHistoricalEventPhoto>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Share)]),
          () => new ListBuilder<Share>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(SocialAccount)]),
          () => new ListBuilder<SocialAccount>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Sponsor)]),
          () => new ListBuilder<Sponsor>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Status)]),
          () => new ListBuilder<Status>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Ticket)]),
          () => new ListBuilder<Ticket>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(TicketMessage)]),
          () => new ListBuilder<TicketMessage>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(TreasureChest)]),
          () => new ListBuilder<TreasureChest>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(User)]),
          () => new ListBuilder<User>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(HealthControllerCheck200ResponseInfoValue)
          ]),
          () => new MapBuilder<String,
              HealthControllerCheck200ResponseInfoValue>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(HealthControllerCheck200ResponseInfoValue)
          ]),
          () => new MapBuilder<String,
              HealthControllerCheck200ResponseInfoValue>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(HealthControllerCheck200ResponseInfoValue)
          ]),
          () => new MapBuilder<String,
              HealthControllerCheck200ResponseInfoValue>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(HealthControllerCheck200ResponseInfoValue)
          ]),
          () => new MapBuilder<String,
              HealthControllerCheck200ResponseInfoValue>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(HealthControllerCheck200ResponseInfoValue)
          ]),
          () => new MapBuilder<String,
              HealthControllerCheck200ResponseInfoValue>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(HealthControllerCheck200ResponseInfoValue)
          ]),
          () => new MapBuilder<String,
              HealthControllerCheck200ResponseInfoValue>()))
    .build();

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
