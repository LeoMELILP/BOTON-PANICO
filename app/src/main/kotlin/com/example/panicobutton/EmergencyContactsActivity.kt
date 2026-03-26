package com.example.panicobutton

import android.content.ContentResolver
import android.content.pm.PackageManager
import android.database.Cursor
import android.os.Bundle
import android.provider.ContactsContract
import android.widget.Button
import android.widget.EditText
import android.widget.ListView
import android.widget.SimpleCursorAdapter
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat

class EmergencyContactsActivity : AppCompatActivity() {
    
    private lateinit var contactListView: ListView
    private lateinit var nameEditText: EditText
    private lateinit var phoneEditText: EditText
    private lateinit var addButton: Button
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_emergency_contacts)
        
        contactListView = findViewById(R.id.contact_list)
        nameEditText = findViewById(R.id.name_input)
        phoneEditText = findViewById(R.id.phone_input)
        addButton = findViewById(R.id.add_contact_button)
        
        addButton.setOnClickListener {
            addEmergencyContact()
        }
        
        loadEmergencyContacts()
    }
    
    private fun addEmergencyContact() {
        val name = nameEditText.text.toString().trim()
        val phone = phoneEditText.text.toString().trim()
        
        if (name.isEmpty() || phone.isEmpty()) {
            Toast.makeText(this, "Por favor completa nombre y teléfono", Toast.LENGTH_SHORT).show()
            return
        }
        
        // Guardar contacto de emergencia
        // saveEmergencyContact(name, phone)
        
        nameEditText.text.clear()
        phoneEditText.text.clear()
        Toast.makeText(this, "Contacto agregado", Toast.LENGTH_SHORT).show()
        
        loadEmergencyContacts()
    }
    
    private fun loadEmergencyContacts() {
        // Cargar lista de contactos de emergencia
        if (ActivityCompat.checkSelfPermission(
                this,
                android.Manifest.permission.READ_CONTACTS
            ) == PackageManager.PERMISSION_GRANTED
        ) {
            val contentResolver: ContentResolver = contentResolver
            val cursor: Cursor? = contentResolver.query(
                ContactsContract.Contacts.CONTENT_URI,
                null,
                null,
                null,
                null
            )
        }
    }
}
