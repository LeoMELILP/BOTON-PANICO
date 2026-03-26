package com.example.panicobutton

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.widget.Button
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import kotlin.concurrent.thread

class MainActivity : AppCompatActivity() {
    
    private lateinit var panicButton: Button
    private lateinit var contactsButton: Button
    private lateinit var statusButton: Button
    
    companion object {
        const val PERMISSION_REQUEST_CODE = 100
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        
        panicButton = findViewById(R.id.panic_button)
        contactsButton = findViewById(R.id.contacts_button)
        statusButton = findViewById(R.id.status_button)
        
        requestPermissions()
        
        panicButton.setOnClickListener {
            activatePanic()
        }
        
        contactsButton.setOnClickListener {
            startActivity(Intent(this, EmergencyContactsActivity::class.java))
        }
        
        statusButton.setOnClickListener {
            checkSharedLocationStatus()
        }
    }

    private fun requestPermissions() {
        val permissionsNeeded = mutableListOf<String>()
        
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION)
            != PackageManager.PERMISSION_GRANTED) {
            permissionsNeeded.add(Manifest.permission.ACCESS_FINE_LOCATION)
        }
        
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.SEND_SMS)
            != PackageManager.PERMISSION_GRANTED) {
            permissionsNeeded.add(Manifest.permission.SEND_SMS)
        }
        
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_CONTACTS)
            != PackageManager.PERMISSION_GRANTED) {
            permissionsNeeded.add(Manifest.permission.READ_CONTACTS)
        }
        
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU &&
            ContextCompat.checkSelfPermission(this, Manifest.permission.POST_NOTIFICATIONS)
            != PackageManager.PERMISSION_GRANTED) {
            permissionsNeeded.add(Manifest.permission.POST_NOTIFICATIONS)
        }
        
        if (permissionsNeeded.isNotEmpty()) {
            ActivityCompat.requestPermissions(this, permissionsNeeded.toTypedArray(), PERMISSION_REQUEST_CODE)
        }
    }

    private fun activatePanic() {
        Toast.makeText(this, "¡Botón de pánico activado!", Toast.LENGTH_SHORT).show()
        
        // Iniciar el servicio de compartir ubicación
        val intent = Intent(this, LocationSharingService::class.java)
        intent.action = LocationSharingService.ACTION_START_SHARING
        ContextCompat.startForegroundService(this, intent)
        
        // Cambiar estado del botón
        panicButton.isEnabled = false
        panicButton.text = "Compartiendo ubicación (8 horas)"
        
        // Re-habilitar después de 8 horas
        thread {
            Thread.sleep(8 * 60 * 60 * 1000) // 8 horas en milisegundos
            runOnUiThread {
                panicButton.isEnabled = true
                panicButton.text = "Botón de Pánico"
                Toast.makeText(this, "Compartir ubicación finalizado", Toast.LENGTH_SHORT).show()
                
                // Detener el servicio
                val stopIntent = Intent(this, LocationSharingService::class.java)
                stopIntent.action = LocationSharingService.ACTION_STOP_SHARING
                startService(stopIntent)
            }
        }
    }
    
    private fun checkSharedLocationStatus() {
        val shared = PreferenceManager.isLocationSharing(this)
        val endTime = PreferenceManager.getShareEndTime(this)
        
        if (shared && endTime > System.currentTimeMillis()) {
            val remainingHours = (endTime - System.currentTimeMillis()) / (60 * 60 * 1000)
            Toast.makeText(this, "Ubicación se comparte en ${remainingHours.toInt()} horas", Toast.LENGTH_SHORT).show()
        } else {
            Toast.makeText(this, "No hay ubicación siendo compartida", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == PERMISSION_REQUEST_CODE) {
            val allGranted = grantResults.all { it == PackageManager.PERMISSION_GRANTED }
            val message = if (allGranted) "Permisos otorgados" else "Algunos permisos fueron denegados"
            Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
        }
    }
}
