package com.android.gowild.utils.compassUtils

class Azimuth(_degrees: Float) {

    operator fun plus(degrees: Float) = Azimuth(this.degrees + degrees)

    val degrees = normalizeAngle(_degrees)

    val cardinalDirection: CardinalDirection = when (degrees) {
        in 22.5f .. 67.5f -> CardinalDirection.NORTHEAST
        in 67.5f .. 112.5f -> CardinalDirection.EAST
        in 112.5f .. 157.5f -> CardinalDirection.SOUTHEAST
        in 157.5f .. 202.5f -> CardinalDirection.SOUTH
        in 202.5f .. 247.5f -> CardinalDirection.SOUTHWEST
        in 247.5f .. 292.5f -> CardinalDirection.WEST
        in 292.5f .. 337.5f -> CardinalDirection.NORTHWEST
        else -> CardinalDirection.NORTH
    }

    private fun normalizeAngle(angleInDegrees: Float): Float {
        return (angleInDegrees + 360f) % 360f
    }

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false

        other as Azimuth

        if (degrees != other.degrees) return false

        return true
    }

    override fun hashCode(): Int {
        return degrees.hashCode()
    }

    override fun toString(): String {
        return "Azimuth(degrees=$degrees)"
    }
}