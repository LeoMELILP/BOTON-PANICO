package com.example.panicobutton

import android.content.Context
import androidx.datastore.preferences.preferencesDataStore

private val Context.dataStore by preferencesDataStore("settings")

object PreferenceManager {
    
    suspend fun saveEmergencyContact(context: Context, name: String, phone: String) {
        val settings = context.dataStore.data
        // Implementar guardado de contacto
    }
    
    fun isLocationSharing(context: Context): Boolean {
        // Implementar verificación
        return false
    }
    
    fun getShareEndTime(context: Context): Long {
        // Implementar obtención de tiempo final
        return 0L
    }
    
    fun setLocationSharing(context: Context, isSharing: Boolean, endTime: Long) {
        // Implementar guardado de estado de ubicación
    }
}
