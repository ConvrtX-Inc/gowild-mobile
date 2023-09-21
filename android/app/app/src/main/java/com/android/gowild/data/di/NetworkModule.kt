package com.android.gowild.data.di

import android.content.Context
import com.android.gowild.BuildConfig
import com.android.gowild.networking.Api
import com.android.gowild.networking.HeaderInterceptor
import com.android.gowild.utils.ConnectivityInterceptor
import com.android.gowild.utils.TimberLoggingInterceptor
import com.android.gowild.utils.local.UserPrefs
import com.chuckerteam.chucker.api.ChuckerInterceptor
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.localebro.okhttpprofiler.OkHttpProfilerInterceptor
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit
import javax.inject.Qualifier
import javax.inject.Singleton

@Qualifier
annotation class BaseUrl

@InstallIn(SingletonComponent::class)
@Module
class NetworkModule {

    @Singleton
    @Provides
    fun getHttpClient(userPrefs: UserPrefs, @ApplicationContext context: Context): OkHttpClient {
        val okHttpClient = OkHttpClient.Builder()
        okHttpClient.addInterceptor(HeaderInterceptor(userPrefs))
//        okHttpClient.addInterceptor(ChuckerInterceptor.Builder(context).build())
        okHttpClient.addInterceptor(HttpLoggingInterceptor(TimberLoggingInterceptor()).setLevel(HttpLoggingInterceptor.Level.BODY))
        okHttpClient.addInterceptor(ConnectivityInterceptor(context))
        if (BuildConfig.DEBUG) {
            okHttpClient.addInterceptor(OkHttpProfilerInterceptor())
        }
        okHttpClient.connectTimeout(30, TimeUnit.SECONDS)
        okHttpClient.readTimeout(30, TimeUnit.SECONDS)
        okHttpClient.writeTimeout(30, TimeUnit.SECONDS)
        okHttpClient.callTimeout(30, TimeUnit.SECONDS)
        return okHttpClient.build()
    }

    @Singleton
    @Provides
    fun getGson(): Gson = GsonBuilder().setLenient().create()

    @Singleton
    @Provides
    fun getGsonFactory(gson: Gson): GsonConverterFactory = GsonConverterFactory.create(gson)

    @Singleton
    @Provides
    @BaseUrl
    fun getBaseUrl(): String = "${BuildConfig.BASE_URL}api/v1/"

    @Singleton
    @Provides
    fun getRetrofit(gsonConverterFactory: GsonConverterFactory, client: OkHttpClient, @BaseUrl baseUrl: String): Retrofit =
        Retrofit.Builder()
            .addConverterFactory(gsonConverterFactory)
            .client(client)
            .baseUrl(baseUrl)
            .build()

    @Provides
    @Singleton
    fun getApi(retrofit: Retrofit): Api = retrofit.create(Api::class.java)
}
