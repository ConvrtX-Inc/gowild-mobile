package com.android.gowild.utils.local

import android.content.Context
import android.content.SharedPreferences
import com.android.gowild.data.model.user.User
import com.android.gowild.utils.constant.NameConst
import com.google.gson.Gson
import dagger.hilt.android.qualifiers.ApplicationContext
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class UserPrefs @Inject constructor(@ApplicationContext val app: Context) {

    companion object {
        private const val USER = "user"
    }

    private val prefs: SharedPreferences = app.getSharedPreferences(
        NameConst.PREFS_USER,
        Context.MODE_PRIVATE
    )

    fun saveUser(user: User?) {
        prefs.edit().putString(USER, Gson().toJson(user)).apply()
    }

    fun updateUserWithoutAccessToken(user: User?) {
        if (user != null) {
            val accessToken = getUser()!!.accessToken
            val refreshToken = getUser()!!.refreshToken
            val newUser = User(
                user.firstName,
                user.lastName,
                user.gender,
                user.username,
                user.email,
                user.phoneNo,
                user.addressOne,
                user.addressTwo,
                user.about_me,
                user.picture,
                user.frontImage,
                user.backImage,
                user.phoneVerified,
                user.selfie_verified,
                user.status,
                user.role,
                user.birthDate,
                user.id,
                user.createdDate,
                user.updatedDate,
                accessToken,
                refreshToken,
                user.errors,
                user.base_url,
            )
            prefs.edit().putString(USER, Gson().toJson(newUser)).apply()
        }
    }

    fun getUser(): User? {
        val json = prefs.getString(USER, null) ?: return null
        return Gson().fromJson(json, User::class.java)
    }

    fun deleteUser() {
        prefs.edit().remove(USER).apply()
    }

}