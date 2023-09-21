package com.android.gowild.utils.compassUtils

import android.hardware.SensorManager
import com.android.gowild.utils.compassUtils.DisplayRotation.*

private const val AZIMUTH = 0
private const val AXIS_SIZE = 3
private const val ROTATION_MATRIX_SIZE = 9


object MathUtils {

    @JvmStatic
    fun calculateAzimuth(rotationVector: RotationVector, displayRotation: DisplayRotation): Azimuth {
        val rotationMatrix = getRotationMatrix(rotationVector)
        val remappedRotationMatrix = remapRotationMatrix(rotationMatrix, displayRotation)
        val orientationInRadians = SensorManager.getOrientation(remappedRotationMatrix, FloatArray(AXIS_SIZE))
        val azimuthInRadians = orientationInRadians[AZIMUTH]
        val azimuthInDegrees = Math.toDegrees(azimuthInRadians.toDouble()).toFloat()
        return Azimuth(azimuthInDegrees)
    }

    private fun getRotationMatrix(rotationVector: RotationVector): FloatArray {
        val rotationMatrix = FloatArray(ROTATION_MATRIX_SIZE)
        SensorManager.getRotationMatrixFromVector(rotationMatrix, rotationVector.toArray())
        return rotationMatrix
    }

    private fun remapRotationMatrix(rotationMatrix: FloatArray, displayRotation: DisplayRotation): FloatArray {
        return when (displayRotation) {
            ROTATION_0 -> remapRotationMatrix(rotationMatrix, SensorManager.AXIS_X, SensorManager.AXIS_Y)
            ROTATION_90 -> remapRotationMatrix(rotationMatrix, SensorManager.AXIS_Y, SensorManager.AXIS_MINUS_X)
            ROTATION_180 -> remapRotationMatrix(rotationMatrix, SensorManager.AXIS_MINUS_X, SensorManager.AXIS_MINUS_Y)
            ROTATION_270 -> remapRotationMatrix(rotationMatrix, SensorManager.AXIS_MINUS_Y, SensorManager.AXIS_X)
        }
    }

    private fun remapRotationMatrix(rotationMatrix: FloatArray, newX: Int, newY: Int): FloatArray {
        val remappedRotationMatrix = FloatArray(ROTATION_MATRIX_SIZE)
        SensorManager.remapCoordinateSystem(rotationMatrix, newX, newY, remappedRotationMatrix)
        return remappedRotationMatrix
    }
}