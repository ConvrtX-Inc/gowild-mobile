package com.android.gowild.networking

import com.android.gowild.data.model.ewaiver.EWaiverResponse
import com.android.gowild.data.model.feeds.*
import com.android.gowild.data.model.friendRequestReceived.FriendRequestReceivedModel
import com.android.gowild.data.model.friends.*
import com.android.gowild.data.model.googleMapRoutesModel.GoogleRoutesResponseModel
import com.android.gowild.data.model.homeModels.MessagesInboxResponseModel
import com.android.gowild.data.model.login.*
import com.android.gowild.data.model.message.MessageApiResponse
import com.android.gowild.data.model.myTrail.*
import com.android.gowild.data.model.notification.UserNotificationResponseModel
import com.android.gowild.data.model.register.RegisterRequest
import com.android.gowild.data.model.register.VerifyMobileOtpRequest
import com.android.gowild.data.model.register.VerifyMobileSendRequest
import com.android.gowild.data.model.register.VerifyOtpResponse
import com.android.gowild.data.model.routes.ApprovedRoutesResponse
import com.android.gowild.data.model.routes.CreateLeaderBoardResponse
import com.android.gowild.data.model.routes.CreateLeaderboardRequest
import com.android.gowild.data.model.routes.RouteDataModel
import com.android.gowild.data.model.settings.EditProfileRequestUpdateModel
import com.android.gowild.data.model.settings.EditProfileResponseModel
import com.android.gowild.data.model.settings.MyAchievementsResponseModel
import com.android.gowild.data.model.support.*
import com.android.gowild.data.model.treasureWild.RegisterTreasureWildResponse
import com.android.gowild.data.model.treasureWild.TreasureWildResponse
import com.android.gowild.data.model.user.SelfieVerificationResponse
import com.android.gowild.data.model.user.Token
import com.android.gowild.data.model.user.User
import okhttp3.MultipartBody
import okhttp3.RequestBody
import okhttp3.ResponseBody
import retrofit2.Response
import retrofit2.http.*

interface Api {

    /**
     * --------------------------------------------
     * Authentication
     */

    @POST("auth/register")
    suspend fun register(
        @Body request: RegisterRequest
    ): Response<User>

    @POST("auth/login")
    suspend fun login(
        @Body loginRequest: LoginRequest?,
    ): Response<Token>

    @POST("auth/facebook/login")
    suspend fun facebookLogin(
        @Body facebookLoginRequest: FacebookLoginRequest?,
    ): Response<FacebookLoginResponse>

    @POST("auth/google/login")
    suspend fun googleLogin(
        @Body googleLoginRequest: GoogleLoginRequest?
    ): Response<GoogleLoginResponse>

    @GET("auth/logout")
    suspend fun logout(
        @Header("Authorization") accessToken: String?,
    ): Response<ResponseBody>

    @POST("verify/mobile/send")
    suspend fun verifyMobileSend(
        @Body verifyMobileSendRequest: VerifyMobileSendRequest
    ): Response<ResponseBody>

    @POST("auth/verify/mobile")
    suspend fun verifyMobileOtp(
        @Body verifyMobileOtpRequest: VerifyMobileOtpRequest
    ): Response<ResponseBody>

    @FormUrlEncoded
    @POST("auth/reset/verify/mobile")
    suspend fun resetVerifyMobileOtp(
        @Field("hash") otp: String,
        @Field("emailPhone") phone: String
    ): Response<ResponseBody>

    @FormUrlEncoded
    @POST("verify/mobile/send")
    suspend fun resendOtp(
        @Field("phone") phone: String,
    ): Response<ResponseBody>

    @FormUrlEncoded
    @POST("verify/mobile/send")
    suspend fun verifyOtp(
        @Field("otp") otp: String, @Field("phone") phone: String
    ): Response<VerifyOtpResponse>

    @FormUrlEncoded
    @POST("auth/forgot/password")
    suspend fun forgotPassword(
        @Field("email") otp: String,
        @Field("phone") phone: String
    ): Response<ResponseBody>

    @FormUrlEncoded
    @POST("auth/reset/password")
    suspend fun resetPassword(
        @Field("password") password: String,
        @Field("hash") otp: String,
        @Field("email") email: String,
        @Field("phone") phone: String
    ): Response<ResponseBody>
    /**
     * Authentication
     * --------------------------------------------
     */


    /**
     * --------------------------------------------
     * User
     */

    @GET("auth/me")
    suspend fun auth(
        @Header("Authorization") accessToken: String?,
    ): Response<User>

    @PATCH("users/update")
    suspend fun updateUserProfile(
        @Body request: EditProfileRequestUpdateModel
    ): Response<EditProfileResponseModel>

    @Multipart
    @POST("users/update-pictures")
    suspend fun updateUserImage(
        @Part image: MultipartBody.Part
    ): Response<EditProfileResponseModel>

    /**
     * User
     * --------------------------------------------
     */

    /**
     * --------------------------------------------
     * Friends
     */

    @GET("friends/suggested-friends")
    suspend fun getSuggestedFriends(): Response<FriendsListModel>

    @GET("friends/received")
    suspend fun getFriendRequests(): Response<FriendRequestReceivedModel>

    @GET(GET_FRIENDS)
    suspend fun getFriends(): Response<MyFriendsResponse>

    @FormUrlEncoded
    @POST("friends/send-friend-request")
    suspend fun sendFriendRequest(
        @Field("email") email: String
    ): Response<SendRequestResponseModel>

    @GET("friends/suggested/remove/{id}")
    suspend fun deleteSuggestedFriend(@Path("id") userId: String): Response<DeleteSuggestedFriendModel>

    @DELETE("friends/{id}")
    suspend fun deleteFriendRequest(@Path("id") id: String): Response<DeleteRequestResponseModel>

    @FormUrlEncoded
    @POST("friends/confirm")
    suspend fun acceptFriendRequest(
        @Field("id") id: String
    ): Response<AcceptRequestResponseModel>
    /**
     * Friends
     * --------------------------------------------
     */

    /**
     * TreasureWild
     * --------------------------------------------
     */


    @GET("admin-guidelines/{type}")
    suspend fun getEWaiverData(@Path("type") type: String): Response<EWaiverResponse>

    @POST(CREATE_TREASURE_WILD_WINNER)
    suspend fun createTreasureWildWinner(@Path("chestID") chestID: String): Response<ResponseBody>

    /**
     * TermsAndConditions
     * --------------------------------------------
     */

    /**
     * --------------------------------------------
     * Messages
     */

    @GET(GET_MESSAGES_INBOX)
    suspend fun getMessagesInbox(): Response<MessagesInboxResponseModel>


    @GET("notifications/user/{user_id}")
    suspend fun getUserNotification(@Path("user_id") user_id: String): Response<UserNotificationResponseModel>

    /**
     * Messages
     * --------------------------------------------
     */
    @GET("treasure-wild/listings")
    suspend fun getTreasureWildListings(@Query("page") page: Int): Response<TreasureWildResponse>

    @FormUrlEncoded
    @POST("treasure-wild/register")
    suspend fun registerTreasureHunt(@Field("treasure_chest_id") treasureChestId: String): Response<RegisterTreasureWildResponse>

    @FormUrlEncoded
    @POST("treasure-wild/verify")
    suspend fun verifyHuntStartOtp(
        @Field("treasure_chest_id") treasureChestId: String,
        @Field("code") code: String
    ): Response<ResponseBody>

    @FormUrlEncoded
    @POST("treasure-wild/resend-code")
    suspend fun resendTreasureHuntCode(@Field("treasure_chest_id") treasureChestId: String): Response<ResponseBody>


    /**
     * --------------------------------------------
     * Feed
     */

    @GET(GET_FEEDS)
    suspend fun getFeeds(): Response<FeedsResponseModel>

    @GET(GET_FEED_DETAILS)
    suspend fun getFeedDetails(
        @Path("postID") id: String
    ): Response<FeedDetailsResponse>

    @POST(CREATE_FEED)
    suspend fun createFeed(
        @Body createFeedPostRequestModel: CreateFeedPostRequestModel
    ): Response<CreateFeedPostResponseModel>

    @Multipart
    @POST(UPDATE_FEED_IMAGE)
    suspend fun updateFeedImage(
        @Path("id") id: String,
        @Part file: MultipartBody.Part
    ): Response<CreateFeedPostResponseModel>

    @Multipart
    @POST(UPDATE_FEED_IMAGE)
    suspend fun updateFeedAttachment(
        @Path("id") id: String,
        @Part attachment: MultipartBody.Part
    ): Response<CreateFeedPostResponseModel>

    @GET(GET_FEED_COMMENTS)
    suspend fun getFeedComments(
        @Path("postID") postID: String
    ): Response<CommentsResponse>

    @POST(ADD_COMMENT)
    suspend fun addComment(
        @Body addCommentRequest: AddCommentRequest
    ): Response<AddCommentResponse>

    @POST(LIKE_FEED)
    suspend fun likeFeed(
        @Body likeFeedRequest: LikeFeedRequest
    ): Response<CreateFeedPostResponseModel>

    @GET(VIEW_FEED)
    suspend fun viewFeed(
        @Path("postID") postID: String
    ): Response<CreateFeedPostResponseModel>

    /**
     * Feed
     * --------------------------------------------
     */

    @GET("messages/{friendId}")
    suspend fun getFriendMessages(@Path("friendId") friendId: String, @Query("page") page: Int): Response<MessageApiResponse>

    @GET("ticket/users/{user_id}")
    suspend fun getSupportTickets(@Path("user_id") user_id: String): Response<SupportResponseModel>

    @GET(GET_SUPPORT_CHAT)
    suspend fun getSupportChat(@Path("ticketID") ticketID: String): Response<SupportMessagesListResponse>

    @POST("ticket")
    suspend fun createNewTicket(
        @Body request: SupportCreateNewTicketRequestModel
    ): Response<SupportCreateNewTicketResponseModel>

    @Multipart
    @POST("ticket/{id}/update-image")
    suspend fun updateTicketImages(
        @Path("id") id: String,
        @Part("message_id") message_id: RequestBody,
        @Part attachment: ArrayList<MultipartBody.Part>
    ): Response<SupportUploadImagesResponseModel>

    @GET(GET_APPROVED_ROUTES)
    suspend fun getApprovedRoutes(
        @Query("lat") lat: Double = 31.4550391,
        @Query("long") long: Double = 74.2746589,
        @Query("page") page: Int = 1,
        @Query("limit") limit : Int = 20
    ): Response<ApprovedRoutesResponse>

    @POST(CREATE_LEADERBOARD)
    suspend fun createLeaderboard(
        @Body createLeaderboardRequest: CreateLeaderboardRequest
    ): Response<CreateLeaderBoardResponse>

    @GET("route/save")
    suspend fun getSaveRoutes(): Response<SaveRoutesResponseModel>

    @GET("route/created-routes")
    suspend fun getCreatedRoutes(): Response<CreatedRoutesResponseModel>

    @GET("https://maps.googleapis.com/maps/api/directions/json")
    suspend fun getGoogleRoutes(
        @Query("origin") origin: String,
        @Query("destination") destination: String,
        @Query("key") key: String = "AIzaSyAoyevYqWkjKEJjq6vPXzfhulxkIecZhX0"
    ): Response<GoogleRoutesResponseModel>

    @POST("route")
    suspend fun createRoutes(
        @Body addRoutesRequestModel: AddRoutesRequestModel
    ): Response<UpdateRouteResponseModel>

    @DELETE("route/{id}")
    suspend fun deleteCreatedRoute(
        @Path("id") id: String
    ): Response<DeleteRequestResponseModel>

    @PATCH("route/{id}")
    suspend fun updateCreatedRoute(
        @Path("id") id: String,
        @Body addRoutesRequestModel: AddRoutesRequestModel
    ): Response<UpdateRouteResponseModel>

    @Multipart
    @POST("route/{id}/update-picture")
    suspend fun updateRoutePicture(
        @Path("id") id: String,
        @Part file: MultipartBody.Part
    ): Response<RouteDataModel>

    @Multipart
    @POST(USER_IMAGE_VERIFICATION)
    suspend fun userImageVerification(
        @Part image1: MultipartBody.Part,
        @Part image2: MultipartBody.Part
    ): Response<SelfieVerificationResponse>

    @GET("leaderboard")
    suspend fun getAchievementsLeaderboard(): Response<MyAchievementsResponseModel>

    @GET(GET_ROUTE_LEADERBOARD)
    suspend fun getRouteLeaderBoard(
        @Path("routeID") id: String,
    ): Response<MyAchievementsResponseModel>

    @POST("route/save")
    suspend fun unSaveRoutes(
        @Body unSaveRouteRequestModel: UnSaveRouteRequestModel
    ): Response<UnSaveRouteResponseModel>

    @GET("route/{id}")
    suspend fun getRouteDetail(@Path("id") id: String): Response<RouteDetailsResponseModel>
}