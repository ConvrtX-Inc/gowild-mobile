package com.android.gowild.networking

data class Resource<out T>(
    val status: Status,
    val data: T?,
    val errors: List<String>?,
    val msg: String?
) {

    companion object {

        fun <T> success(data: T?): Resource<T> {
            return Resource(Status.SUCCESS, data, null, null)
        }

        fun <T> error(errors: List<String>, data: T?): Resource<T> {
            return Resource(Status.ERROR, data, errors, null)
        }

        fun <T> loading(data: T?): Resource<T> {
            return Resource(Status.LOADING, data, null, null)
        }

        fun <T> message(message: String): Resource<T> {
            return Resource(Status.ERROR, null, null, message)
        }

    }

}