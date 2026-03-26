# Guía de Desarrollo - Botón de Pánico

## Tareas Completadas ✓

- [x] Estructura base del proyecto Android
- [x] Pantalla principal con botón de pánico
- [x] Activity para gestión de contactos de emergencia
- [x] Servicio de ubicación en tiempo real
- [x] Envío de ubicación por SMS
- [x] Notificación persistente (8 horas)
- [x] Manejo de permisos
- [x] Layouts XML
- [x] Configuración Gradle

## Tareas Pendientes para Completar la Aplicación

### 1. Persistencia de Contactos (Alta Prioridad)
**Archivo:** `PreferenceManager.kt`
```kotlin
// Implementar guardado y lectura de contactos de emergencia
// Opciones: SharedPreferences, DataStore o Room Database
```

**Pasos:**
- [ ] Crear funciones para guardar contacto
- [ ] Crear funciones para leer todos los contactos
- [ ] Crear funciones para eliminar contacto
- [ ] Usar DataStore para persistencia

### 2. Pantalla de Contactos Mejorada
**Archivo:** `EmergencyContactsActivity.kt`
```kotlin
// Mejorar la carga de contactos de emergencia en la lista
// Agregar botones para eliminar contactos
// Validar números de teléfono
```

**Pasos:**
- [ ] Crear adaptador personalizado para la lista
- [ ] Implementar botón de eliminar
- [ ] Validar formato de teléfono
- [ ] Agregar búsqueda de contactos del dispositivo

### 3. Completar getEmergencyContacts()
**Archivo:** `LocationSharingService.kt`
```kotlin
private fun getEmergencyContacts(): List<String> {
    // Actualmente retorna lista vacía
    // Necesita leer desde PreferenceManager
}
```

### 4. Mejorar UI/UX
**Archivos:** `activity_main.xml`, `activity_emergency_contacts.xml`

Mejoras sugeridas:
- [ ] Agregar ícono personalizado
- [ ] Mejorar diseño del botón de pánico (shadow, ripple, animación)
- [ ] Agregar indicador visual de estado
- [ ] Agregar contador de contactos agregados

### 5. Testing
- [ ] Probar en dispositivo real
- [ ] Probar permisos en Android 6+, 10+, 12+, 13+
- [ ] Probar envío de SMS
- [ ] Probar ubicación en foreground service

### 6. Características Adicionales (Opcional)
- [ ] Integración con WhatsApp/Telegram (Intent)
- [ ] Envío de múltiples SMS simultáneamente
- [ ] Historial de activaciones
- [ ] Alertas por sonido/vibración
- [ ] Pantalla de emergencia (lock screen)
- [ ] Foto automática en activación
- [ ] Alertas de batería baja

## Cómo Ejecutar el Proyecto Actual

### Opción 1: Con Android Studio
1. Abre Android Studio
2. Open Project → Selecciona carpeta "boton de panico"
3. Espera sincronización de Gradle
4. Conecta dispositivo o abre emulador
5. Run (Mayús + F10)

### Opción 2: Línea de Comandos
```bash
cd c:\Users\lcanett\Desktop\boton de panico
gradlew installDebug
```

## Dependencias del Proyecto

- androidx.core:core-ktx:1.10.1
- androidx.appcompat:appcompat:1.6.1
- com.google.android.material:material:1.9.0
- com.google.android.gms:play-services-location:21.0.1
- androidx.datastore:datastore-preferences:1.0.0
- Kotlin Coroutines

## Notas de Seguridad

⚠️ Consideraciones importantes:
- La aplicación requiere permiso `SEND_SMS` para enviar ubicación
- En Android 11+, hay restricciones para SMS en Telefony
- Considera usar Firebase Cloud Messaging como alternativa
- Guarda números de teléfono de forma segura
- Implementa cifrado para datos sensibles

## Estructura de Carpetas Final

```
boton de panico/
├── app/
│   ├── src/main/
│   │   ├── kotlin/com/example/panicobutton/
│   │   │   ├── MainActivity.kt
│   │   │   ├── EmergencyContactsActivity.kt
│   │   │   ├── LocationSharingService.kt
│   │   │   └── PreferenceManager.kt
│   │   ├── res/
│   │   │   ├── layout/
│   │   │   ├── values/
│   │   │   └── xml/
│   │   └── AndroidManifest.xml
│   ├── build.gradle
│   └── proguard-rules.pro
├── build.gradle
├── settings.gradle
├── README.md
└── DEVELOPMENT.md (este archivo)
```

## Recursos Útiles

- [Android Location Services](https://developer.android.com/training/location)
- [Foreground Services](https://developer.android.com/guide/components/foreground-services)
- [Permissions](https://developer.android.com/guide/topics/permissions)
- [SMS Manager](https://developer.android.com/reference/android/telephony/SmsManager)
- [DataStore](https://developer.android.com/topic/libraries/architecture/datastore)

---

**Última actualización:** March 26, 2026
**Estado:** En desarrollo base completada
