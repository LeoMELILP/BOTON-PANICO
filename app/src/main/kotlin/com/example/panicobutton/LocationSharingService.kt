package com.example.panicobutton

import android.app.Service
import android.content.Intent
import android.content.pm.PackageManager
import android.location.Location
import android.os.IBinder
import android.os.Looper
import android.telephony.SmsManager
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationResult
import com.google.android.gms.location.Priority
import com.google.android.gms.location.LocationServices

class LocationSharingService : Service() {

    companion object {
        const val ACTION_START_SHARING = "START_SHARING"
        const val ACTION_STOP_SHARING = "STOP_SHARING"
        const val NOTIFICATION_ID = 1001
        const val CHANNEL_ID = "location_sharing_channel"
        const val TAG = "LocationSharing"
    }

    private lateinit var fusedLocationClient: FusedLocationProviderClient
    private var locationCallback: LocationCallback? = null

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onCreate() {
        super.onCreate()
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(this)
        createNotificationChannel()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            ACTION_START_SHARING -> {
                startLocationSharing()
            }
            ACTION_STOP_SHARING -> {
                stopLocationSharing()
                stopSelf()
            }
        }
        return START_STICKY
    }

    private fun startLocationSharing() {
        val notification = NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("Compartiendo ubicación")
            .setContentText("Tu ubicación se está compartiendo por 8 horas")
            .setSmallIcon(android.R.drawable.ic_dialog_info)
            .setOngoing(true)
            .build()

        startForeground(NOTIFICATION_ID, notification)

        val locationRequest = LocationRequest.Builder(
            Priority.PRIORITY_HIGH_ACCURACY,
            5000 // cada 5 segundos
        ).build()

        locationCallback = object : LocationCallback() {
            override fun onLocationResult(locationResult: LocationResult) {
                for (location in locationResult.locations) {
                    try {
                        Log.d(TAG, "Nueva ubicación: ${location.latitude}, ${location.longitude}")
                        shareLocationWithContacts(location)
                    } catch (e: Exception) {
                        Log.e(TAG, "Error compartiendo ubicación: ${e.message}")
                    }
                }
            }
        }

        if (ActivityCompat.checkSelfPermission(
                this,
                android.Manifest.permission.ACCESS_FINE_LOCATION
            ) == PackageManager.PERMISSION_GRANTED
        ) {
            fusedLocationClient.requestLocationUpdates(
                locationRequest,
                locationCallback!!,
                Looper.getMainLooper()
            )
        }
    }

    private fun stopLocationSharing() {
        locationCallback?.let {
            fusedLocationClient.removeLocationUpdates(it)
        }
        stopForeground(STOP_FOREGROUND_REMOVE)
    }

    private fun shareLocationWithContacts(location: Location) {
        // Obtener contactos de emergencia desde preferencias
        val contacts = getEmergencyContacts()
        
        Log.d(TAG, "Compartiendo con ${contacts.size} contactos")
        
        for (contact in contacts) {
            sendLocationViaMessage(contact, location)
        }
    }

    private fun sendLocationViaMessage(phoneNumber: String, location: Location) {
        val message = buildLocationMessage(location)
        
        try {
            if (ActivityCompat.checkSelfPermission(
                    this,
                    android.Manifest.permission.SEND_SMS
                ) == PackageManager.PERMISSION_GRANTED
            ) {
                val smsManager = SmsManager.getDefault()
                smsManager.sendTextMessage(phoneNumber, null, message, null, null)
                Log.d(TAG, "SMS enviado a $phoneNumber")
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error enviando SMS a $phoneNumber: ${e.message}")
        }
    }

    private fun buildLocationMessage(location: Location): String {
        return """
            🚨 ¡ALERTA DE PÁNICO! 🚨
            
            Mi ubicación actual:
            📍 Latitud: ${location.latitude}
            📍 Longitud: ${location.longitude}
            📍 Precisión: ${location.accuracy.toInt()}m
            
            Ver en Google Maps:
            https://maps.google.com/?q=${location.latitude},${location.longitude}
            
            Tiempo: ${java.text.SimpleDateFormat("HH:mm:ss").format(java.util.Date())}
        """.trimIndent()
    }

    private fun getEmergencyContacts(): List<String> {
        // Implementar lectura de contactos de emergencia
        return emptyList()
    }

    private fun createNotificationChannel() {
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            val channel = android.app.NotificationChannel(
                CHANNEL_ID,
                "Location Sharing",
                android.app.NotificationManager.IMPORTANCE_LOW
            )
            val manager = getSystemService(android.app.NotificationManager::class.java)
            manager.createNotificationChannel(channel)
        }
    }
}
