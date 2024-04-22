import android.Manifest
import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import android.os.Bundle
import androidx.core.content.ContextCompat

class PlatformGeoLocationImpl(private val context: Context) : PlatformGeoLocation {
    private var locationManager: LocationManager? = null
    private var locationListener: LocationListener? = null
    private var callback: ((Result<CoordinatesMessage>) -> Unit)? = null

    override fun getCoordinates(callback: (Result<CoordinatesMessage>) -> Unit) {
        this.callback = callback
        this.locationManager = context.getSystemService(Context.LOCATION_SERVICE) as LocationManager?

        if (checkLocationPermission()) {
            requestLocationUpdates()
        } else {
            // Handle permission denial
            callback(Result.failure(FlutterError("0", "Permissions denied", "details")))
        }
    }

    @SuppressLint("MissingPermission")
    private fun requestLocationUpdates() {
        locationListener = object : LocationListener {
            override fun onLocationChanged(location: Location) {
                callback?.invoke(Result.success(CoordinatesMessage(location.latitude, location.longitude)))
                stopLocationUpdates()
            }

            override fun onProviderEnabled(provider: String) {}

            override fun onProviderDisabled(provider: String) {
                // Handle provider disabled
                callback?.invoke(Result.failure(
                    FlutterError("0", "Permissions denied", "details")))
                stopLocationUpdates()
            }

            override fun onStatusChanged(provider: String?, status: Int, extras: Bundle?) {}
        }

        locationManager?.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 0L, 0f, locationListener!!)
    }

    private fun stopLocationUpdates() {
        locationListener?.let { locationManager?.removeUpdates(it) }
    }

    private fun checkLocationPermission(): Boolean {
        return ContextCompat.checkSelfPermission(
            context,
            Manifest.permission.ACCESS_FINE_LOCATION
        ) == PackageManager.PERMISSION_GRANTED
    }
}
