package com.android.gowild.utils.compassUtils

data class RotationVector(val x: Float, val y: Float, val z: Float) {

    fun toArray(): FloatArray = floatArrayOf(x, y, z)
}
