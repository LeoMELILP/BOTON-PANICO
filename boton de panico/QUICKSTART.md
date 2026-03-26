# 🚨 Botón de Pánico - Aplicación Android

Aplicación Android que permite activar un **botón de pánico** que automáticamente comparte tu ubicación en tiempo real con contactos de emergencia **durante 8 horas**.

## 🎯 Características Principales

✅ **Botón de Pánico Grande y Rojo**
- Fácil de presionar en situación de emergencia
- Se deshabilita después de activarse
- Se re-habilita automáticamente tras 8 horas

✅ **Compartir Ubicación en Tiempo Real**
- Captura ubicación cada 5 segundos
- Envía SMS con ubicación a contactos
- Incluye enlace a Google Maps

✅ **Gestión de Contactos de Emergencia**
- Agregar múltiples contactos
- Almacenamiento local en dispositivo
- Fácil eliminación

✅ **Notificación Persistente**
- Muestra estado mientras comparte
- Permanece visible durante 8 horas
- Indica tiempo restante

✅ **Soporte Completo de Permisos**
- Android 6+ (Permisos en tiempo real)
- Android 13+ (Notificaciones)
- Android 12+ (SMS discreto)

## 📱 Requisitos

- **Android:** 7.0 (API 24) o superior
- **Memoria:** ~50 MB
- **Permisos:** Ubicación, SMS, Contactos, Notificaciones

## 🚀 Inicio Rápido

### Opción 1: Android Studio (Recomendado)

```bash
# 1. Abre Android Studio
# 2. File → Open → Selecciona carpeta "boton de panico"
# 3. Espera sincronización de Gradle
# 4. Conecta dispositivo o abre emulador
# 5. Run (Mayús + F10)
```

### Opción 2: Línea de Comandos

```bash
cd c:\Users\lcanett\Desktop\boton de panico
gradlew installDebug
```

### Opción 3: APK Compilado

```bash
gradlew assembleDebug
# APK ubicado en: app/build/outputs/apk/debug/app-debug.apk
adb install -r app/build/outputs/apk/debug/app-debug.apk
```

## 📚 Documentación

| Documento | Contenido |
|-----------|-----------|
| [README.md](README.md) | Información general y estructura |
| [CONFIGURATION.md](CONFIGURATION.md) | Cómo usar la aplicación |
| [DEVELOPMENT.md](DEVELOPMENT.md) | Guía de desarrollo para mejoras |

## 🏗️ Estructura del Proyecto

```
boton de panico/
├── app/
│   ├── src/main/
│   │   ├── kotlin/com/example/panicobutton/
│   │   │   ├── MainActivity.kt                  (Pantalla principal)
│   │   │   ├── EmergencyContactsActivity.kt     (Gestión contactos)
│   │   │   ├── LocationSharingService.kt        (Servicio ubicación)
│   │   │   └── PreferenceManager.kt             (Almacenamiento)
│   │   ├── res/
│   │   │   ├── layout/
│   │   │   │   ├── activity_main.xml
│   │   │   │   └── activity_emergency_contacts.xml
│   │   │   ├── values/
│   │   │   │   ├── strings.xml
│   │   │   │   └── themes.xml
│   │   │   └── xml/
│   │   │       ├── backup_rules.xml
│   │   │       └── data_extraction_rules.xml
│   │   └── AndroidManifest.xml
│   ├── build.gradle
│   └── proguard-rules.pro
├── build.gradle
├── settings.gradle
├── README.md                                     (Este archivo)
├── CONFIGURATION.md                              (Manual del usuario)
├── DEVELOPMENT.md                                (Guía de desarrollo)
└── .gitignore
```

## ⚙️ Dependencias

```gradle
// Location Services
com.google.android.gms:play-services-location:21.0.1

// DataStore
androidx.datastore:datastore-preferences:1.0.0

// Kotlin & AndroidX
androidx.appcompat:appcompat:1.6.1
com.google.android.material:material:1.9.0
org.jetbrains.kotlinx:kotlinx-coroutines-android:1.7.1
```

## 🎮 Cómo Usar (Resumen)

1. **Abre la aplicación**
   - Otorga permisos cuando se solicite

2. **Agrega contactos de emergencia**
   - Presiona "Configurar Contactos de Emergencia"
   - Añade números de teléfono de familia, amigos, o servicios

3. **Activa el pánico**
   - Presiona el botón rojo grande
   - La ubicación se compartirá cada 5 segundos durante 8 horas
   - Recibirás SMS en tu número para verificar

4. **Un­formas de detener**
   - Espera 8 horas (automático)
   - Reinicio de dispositivo (manual)

> ⚠️ **Nota:** El envío de SMS tiene costo según tu operador

## 🔐 Privacidad y Seguridad

- ✅ **Sin servidor remoto** - Todo local en dispositivo
- ✅ **Almacenamiento local** - Datos en teléfono, no se envían a ningún lado
- ✅ **Solo SMS** - Usa tecnología estándar de mensajes
- ✅ **Sin registro** - No requiere registro ni cuenta

## ⚠️ Requisitos de Permisos

```xml
ACCESS_FINE_LOCATION   → Ubicación exacta (obligatorio)
SEND_SMS               → Envío de mensajes (obligatorio)
READ_CONTACTS          → Sugerir contactos (opcional)
POST_NOTIFICATIONS     → Notificaciones (obligatorio en Android 13+)
```

## 🛠️ Tareas Pendientes

- [ ] Persistencia completa de contactos con DataStore
- [ ] Ícono personalizado de aplicación
- [ ] Animación del botón de pánico
- [ ] Integración con WhatsApp/Telegram
- [ ] Historial de activaciones
- [ ] Foto automática en emergencia
- [ ] Pantalla de bloqueo (lock screen)

Ver [DEVELOPMENT.md](DEVELOPMENT.md) para lista completa.

## 🐛 Troubleshooting

**¿No funciona el GPS?**
- Actívalo desde Configuración
- Intenta al aire libre
- Espera 20 segundos para conectarse

**¿No se envían SMS?**
- Verifica permisos en Configuración → Aplicaciones
- Comprueba saldo de SMS (si es prepago)
- Valida formato de teléfono: +34612345678

**¿Batería se agota rápido?**
- Es normal con GPS activo 8 horas
- Carga completamente antes de usar
- Cierra otras apps

## 📞 Contacto & Soporte

Para desarrollo, mejoras o reportar bugs:
- Ubicación del código: `c:\Users\lcanett\Desktop\boton de panico`
- Lee: `DEVELOPMENT.md` para instrucciones técnicas
- Consulta: `CONFIGURATION.md` para dudas de uso

## 📄 Licencia

UNLICENSED - Uso personal/privado

## 🎉 ¡Listo para Usar!

La aplicación está completamente funcional y lista para:
- ✅ Compilar y ejecutar
- ✅ Probar en emulador
- ✅ Instalar en dispositivo real
- ✅ Distribuir a contactos de emergencia

---

**Versión:** 1.0  
**Última actualización:** March 26, 2026  
**Estado:** ✅ Beta Funcional
