package com.android.gowild.data.repo

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
import com.android.gowild.networking.Api
import com.android.gowild.networking.BaseApiResponse
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.scopes.ViewModelScoped
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOn
import okhttp3.MultipartBody
import okhttp3.RequestBody
import okhttp3.ResponseBody
import javax.inject.Inject

@ViewModelScoped
class Repository @Inject constructor(val api: Api) : BaseApiResponse() {

    suspend fun register(request: RegisterRequest): Flow<NetworkResult<User>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.register(request) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun login(request: LoginRequest): Flow<NetworkResult<Token>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.login(request) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun facebookLogin(facebookLoginRequest: FacebookLoginRequest): Flow<NetworkResult<FacebookLoginResponse>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.facebookLogin(facebookLoginRequest) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun googleLogin(googleLoginRequest: GoogleLoginRequest): Flow<NetworkResult<GoogleLoginResponse>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.googleLogin(googleLoginRequest) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun auth(accessToken: String): Flow<NetworkResult<User>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.auth(accessToken) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun verifyMobileSend(verifyMobileSendRequest: VerifyMobileSendRequest): Flow<NetworkResult<ResponseBody>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.verifyMobileSend(verifyMobileSendRequest) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun verifyMobileOtp(verifyMobileOtpRequest: VerifyMobileOtpRequest): Flow<NetworkResult<ResponseBody>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.verifyMobileOtp(verifyMobileOtpRequest) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun verifyHuntStartOtp(huntId: String, otp: String): Flow<NetworkResult<ResponseBody>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.verifyHuntStartOtp(huntId, otp) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun resendTreasureHuntOtp(huntId: String): Flow<NetworkResult<ResponseBody>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.resendTreasureHuntCode(huntId) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun logout(accessToken: String): Flow<NetworkResult<ResponseBody>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.logout(accessToken) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun resendOtp(number: String): Flow<NetworkResult<ResponseBody>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.resendOtp(number) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun verifyOtp(otp: String, number: String): Flow<NetworkResult<VerifyOtpResponse>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.verifyOtp(otp, number) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun resetVerifyOtp(otp: String, number: String): Flow<NetworkResult<ResponseBody>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.resetVerifyMobileOtp(otp, number) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun forgotPassword(email: String, number: String): Flow<NetworkResult<ResponseBody>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.forgotPassword(email, number) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun resetPassword(password: String, otp: String, email: String, phone: String): Flow<NetworkResult<ResponseBody>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.resetPassword(password, otp, email, phone) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getSuggestedFriends(): Flow<NetworkResult<FriendsListModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getSuggestedFriends() })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getFriendRequests(): Flow<NetworkResult<FriendRequestReceivedModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getFriendRequests() })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getFriends(): Flow<NetworkResult<MyFriendsResponse>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getFriends() })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun sendFriendRequest(email: String): Flow<NetworkResult<SendRequestResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.sendFriendRequest(email) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun deleteSuggestedFriend(userId: String): Flow<NetworkResult<DeleteSuggestedFriendModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.deleteSuggestedFriend(userId) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun deleteFriendRequest(id: String): Flow<NetworkResult<DeleteRequestResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.deleteFriendRequest(id) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun acceptFriendRequest(id: String): Flow<NetworkResult<AcceptRequestResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.acceptFriendRequest(id) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getMessagesInbox(): Flow<NetworkResult<MessagesInboxResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getMessagesInbox() })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getFriendsMessages(friendId: String): Flow<NetworkResult<MessageApiResponse>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getFriendMessages(friendId, 1) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getEWaiver(type: String): Flow<NetworkResult<EWaiverResponse>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getEWaiverData(type) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun createTreasureWildWinner(chestID: String): Flow<NetworkResult<ResponseBody>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.createTreasureWildWinner(chestID) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getTreasureWildListings(page: Int): Flow<NetworkResult<TreasureWildResponse>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getTreasureWildListings(page) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun registerTreasureHunt(treasureHuntId: String): Flow<NetworkResult<RegisterTreasureWildResponse>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.registerTreasureHunt(treasureHuntId) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun updateUserProfile(request: EditProfileRequestUpdateModel): Flow<NetworkResult<EditProfileResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.updateUserProfile(request) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun updateUserImage(image: MultipartBody.Part): Flow<NetworkResult<EditProfileResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.updateUserImage(image) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getFeeds(): Flow<NetworkResult<FeedsResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getFeeds() })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getFeedDetails(postID: String): Flow<NetworkResult<FeedDetailsResponse>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getFeedDetails(postID) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getFeedComments(postID: String): Flow<NetworkResult<CommentsResponse>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getFeedComments(postID) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun addComment(addCommentRequest: AddCommentRequest): Flow<NetworkResult<AddCommentResponse>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.addComment(addCommentRequest) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun createFeed(createFeedPostRequestModel: CreateFeedPostRequestModel): Flow<NetworkResult<CreateFeedPostResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.createFeed(createFeedPostRequestModel) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun updateFeedImage(id: String, file: MultipartBody.Part): Flow<NetworkResult<CreateFeedPostResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.updateFeedImage(id, file) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun updateFeedAttachment(id: String, attachment: MultipartBody.Part): Flow<NetworkResult<CreateFeedPostResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.updateFeedAttachment(id, attachment) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun likeFeed(likeFeedRequest: LikeFeedRequest): Flow<NetworkResult<CreateFeedPostResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.likeFeed(likeFeedRequest) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun viewFeed(postID: String): Flow<NetworkResult<CreateFeedPostResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.viewFeed(postID) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getUserNotification(user_id: String): Flow<NetworkResult<UserNotificationResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getUserNotification(user_id) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getSupportTickets(user_id: String): Flow<NetworkResult<SupportResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getSupportTickets(user_id) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getSupportChat(ticketID: String): Flow<NetworkResult<SupportMessagesListResponse>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getSupportChat(ticketID) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun createNewTicket(request: SupportCreateNewTicketRequestModel): Flow<NetworkResult<SupportCreateNewTicketResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.createNewTicket(request) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun updateTicketImages(
        id: String,
        message_id: RequestBody,
        images: ArrayList<MultipartBody.Part>
    ): Flow<NetworkResult<SupportUploadImagesResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.updateTicketImages(id, message_id, images) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getApprovedRoutes(lat: Double, long: Double, page: Int): Flow<NetworkResult<ApprovedRoutesResponse>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getApprovedRoutes(lat, long, page) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun createLeaderboard(createLeaderboardRequest: CreateLeaderboardRequest): Flow<NetworkResult<CreateLeaderBoardResponse>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.createLeaderboard(createLeaderboardRequest) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getSaveRoutes(): Flow<NetworkResult<SaveRoutesResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getSaveRoutes() })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getCreatedRoutes(): Flow<NetworkResult<CreatedRoutesResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getCreatedRoutes() })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getGoogleRoutes(origin: String, destination: String): Flow<NetworkResult<GoogleRoutesResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getGoogleRoutes(origin, destination) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun createRoutes(addRoutesRequestModel: AddRoutesRequestModel): Flow<NetworkResult<UpdateRouteResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.createRoutes(addRoutesRequestModel) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun deleteCreatedRoute(id: String): Flow<NetworkResult<DeleteRequestResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.deleteCreatedRoute(id) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun updateCreatedRoute(id: String, addRoutesRequestModel: AddRoutesRequestModel): Flow<NetworkResult<UpdateRouteResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.updateCreatedRoute(id, addRoutesRequestModel) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun updateRoutePicture(id: String, file: MultipartBody.Part): Flow<NetworkResult<RouteDataModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.updateRoutePicture(id, file) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun userImageVerification(image1: MultipartBody.Part, image2: MultipartBody.Part): Flow<NetworkResult<SelfieVerificationResponse>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.userImageVerification(image1, image2) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getAchievementsLeaderboard(): Flow<NetworkResult<MyAchievementsResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getAchievementsLeaderboard() })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getRouteLeaderBoard(routeID: String): Flow<NetworkResult<MyAchievementsResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getRouteLeaderBoard(routeID) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun unSaveRoutes(unSaveRouteRequestModel: UnSaveRouteRequestModel): Flow<NetworkResult<UnSaveRouteResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.unSaveRoutes(unSaveRouteRequestModel) })
        }.flowOn(Dispatchers.IO)
    }

    suspend fun getRouteDetail(id: String): Flow<NetworkResult<RouteDetailsResponseModel>> {
        return flow {
            emit(NetworkResult.Loading())
            emit(safeApiCall { api.getRouteDetail(id) })
        }.flowOn(Dispatchers.IO)
    }
}