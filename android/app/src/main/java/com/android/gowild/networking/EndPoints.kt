package com.android.gowild.networking

// TODO: need to add all endpoints here

const val GET_FEEDS = "post-feed"
const val GET_FEED_DETAILS = "post-feed/{postID}"
const val GET_FEED_COMMENTS = "comment/{postID}"
const val ADD_COMMENT = "comment"
const val GET_MESSAGES_INBOX = "messages/inbox"
const val CREATE_TREASURE_WILD_WINNER = "treasure-wild/{chestID}"
const val LIKE_FEED = "like"
const val VIEW_FEED = "post-feed/{postID}"
const val CREATE_FEED = "post-feed"
const val UPDATE_FEED_IMAGE = "post-feed/{id}/update-picture"
const val GET_APPROVED_ROUTES = "route/approved"
const val GET_FRIENDS = "friends/my"
const val GET_SUPPORT_CHAT = "ticket-messages/{ticketID}"
const val CREATE_LEADERBOARD = "leaderboard"
const val USER_IMAGE_VERIFICATION = "users/image-verification"
const val GET_ROUTE_LEADERBOARD = "leaderboard/{routeID}"