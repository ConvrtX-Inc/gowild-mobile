package com.android.gowild.utils

import android.Manifest
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.app.TaskStackBuilder
import com.android.gowild.R
import com.android.gowild.data.model.pushNotifications.PushNotificationModel
import com.android.gowild.ui.main.MainActivity
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.google.gson.Gson
import org.json.JSONObject
import timber.log.Timber

class GoWildFirebaseMessagingService : FirebaseMessagingService() {

    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        Timber.tag("GoWildFirebaseMessagingService").wtf("From: ${remoteMessage.from}")
        if (remoteMessage.data.isNotEmpty()) {
            Timber.tag("GoWildFirebaseMessagingService").wtf("Message data payload: ${remoteMessage.data}")

            // TODO: make this generic and/or an extension
            val `object` = (remoteMessage.data as Map<*, *>?)?.let {
                JSONObject(it)
            }
            val finalJSON = `object`.toString().replace("\\\\".toRegex(), "").replace("\"[", "[").replace("]\"", "]")
            val data: PushNotificationModel = Gson().fromJson(finalJSON, PushNotificationModel::class.java)

            handleNow(data)
        } else
            remoteMessage.notification?.let {
                Timber.tag("GoWildFirebaseMessagingService").wtf("Message Notification Body: ${it.body}")
            }
    }

    private fun handleNow(data: PushNotificationModel) {
        Timber.tag("GoWildFirebaseMessagingService").wtf("Handle now")

        val resultIntent = Intent(this, MainActivity::class.java)
        resultIntent.putExtra("type",data.type)
// Create the TaskStackBuilder
        val resultPendingIntent: PendingIntent? = TaskStackBuilder.create(this).run {
            // Add the intent, which inflates the back stack
            addNextIntentWithParentStack(resultIntent)
            // Get the PendingIntent containing the entire back stack
            getPendingIntent(
                0,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
        }
        val builder = NotificationCompat.Builder(this, "5445")
            .setContentIntent(resultPendingIntent)
            .setSmallIcon(R.drawable.ic_app)
            .setContentTitle(data.title)
            .setContentText(
                data.title
            )
            .setStyle(
                NotificationCompat.BigTextStyle()
                    .bigText(
                        data.body
                    )
            )
            .setAutoCancel(true)
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)


        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name = "Go Wild Notifications"
            val descriptionText = "Updates about go wild events"
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val channel = NotificationChannel("5445", name, importance).apply {
                description = descriptionText
            }

            val notificationManager: NotificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
        with(NotificationManagerCompat.from(this)) {

            if (ActivityCompat.checkSelfPermission(
                    this@GoWildFirebaseMessagingService,
                    Manifest.permission.POST_NOTIFICATIONS
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                // TODO: Consider calling
                //    ActivityCompat#requestPermissions
                // here to request the missing permissions, and then overriding
                //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                //                                          int[] grantResults)
                // to handle the case where the user grants the permission. See the documentation
                // for ActivityCompat#requestPermissions for more details.
                return
            }
            notify(123, builder.build())
        }
    }

    override fun onNewToken(token: String) {
        Timber.tag("GoWildFirebaseMessagingService").wtf("Refreshed token: $token")
    }

}