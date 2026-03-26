# Botón de Pánico - Aplicación Android

Aplicación Android que permite activar un botón de pánico que comparte la ubicación con contactos de emergencia durante 8 horas.

## Características

- **Botón de Pánico**: Activa el compartir ubicación con un toque
- **Ubicación en Tiempo Real**: Captura la ubicación cada 5 segundos mientras está activo
- **Contactos de Emergencia**: Gestión de contactos para recibir alertas
- **Duración de 8 Horas**: Comparte ubicación automáticamente durante 8 horas
- **Notificación Persistente**: Muestra notificación mientras comparte ubicación

## Requisitos

- Android 7.0 (API 24) o superior
- Permisos requeridos:
  - Ubicación precisa
  - Enviar SMS
  - Leer contactos
  - Notificaciones

## Estructura del Proyecto

```
app/
├── src/
│   └── main/
│       ├── kotlin/com/example/panicobutton/
│       │   ├── MainActivity.kt              # Pantalla principal
│       │   ├── EmergencyContactsActivity.kt # Gestión de contactos
│       │   ├── LocationSharingService.kt    # Servicio de ubicación
│       │   └── PreferenceManager.kt         # Gestión de preferencias
│       ├── res/
│       │   ├── layout/
│       │   │   ├── activity_main.xml
│       │   │   └── activity_emergency_contacts.xml
│       │   └── values/
│       │       ├── strings.xml
│       │       └── themes.xml
│       └── AndroidManifest.xml
├── build.gradle
└── settings.gradle
```

## Preparación Inicial

1. **Instala Android SDK** (si no lo tienes)
   - Descarga Android Studio desde https://developer.android.com/studio
   - Durante la instalación, asegúrate de instalar SDK para Android 13 (API 34) o superior

2. **Configura local.properties**
   ```bash
   # Copia el archivo example
   copy local.properties.example local.properties
   
   # Edita local.properties con la ruta a tu SDK
   # Ejemplo para Windows:
   sdk.dir=C:\\Users\\TuUsuario\\AppData\\Local\\Android\\sdk
   ```

## Compilación y Ejecución (Windows)

### Línea de comando (Gradle)
```bash
# En el directorio del proyecto
gradlew assembleDebug
```

### Android Studio
1. Abre Android Studio
2. Selecciona "File" → "Open"
3. Navega a la carpeta del proyecto
4. Espera a que se sincronice Gradle
5. Conecta un dispositivo Android o inicia un emulador
6. Presiona "Run" (Mayús + F10) o el botón ▶

### Emulador

Para usar un emulador:
1. En Android Studio: Tools → Device Manager
2. Crea un nuevo dispositivo virtual (e.g., Pixel 6 con API 34)
3. Inicia el emulador
4. Ejecuta la app

## Instalación en Dispositivo Real

### Requisitos
- Dispositivo Android conectado por USB
- USB Debugging habilitado en el dispositivo
  - Abre Configuración → Acerca del teléfono
  - Toca "Número de compilación" 7 veces para habilitar Opciones de desarrollador
  - Ve a Opciones de desarrollador y habilita "Depuración USB"

### Instalación
```bash
# Instala la app
gradlew installDebug

# O manualmente con ADB
adb install -r app/build/outputs/apk/debug/app-debug.apk
```

## Permisos Requeridos

La aplicación solicita los siguientes permisos:
- `ACCESS_FINE_LOCATION` - Para obtener ubicación precisa
- `SEND_SMS` - Para enviar ubicación por SMS
- `READ_CONTACTS` - Para leer contactos de emergencia
- `POST_NOTIFICATIONS` - Para mostrar notificaciones (Android 13+)

## Cómo Usar

1. **Configurar Contactos**: Abre "Configurar Contactos de Emergencia" e ingresa los números de teléfono
2. **Activar Pánico**: Presiona el botón rojo de pánico
3. **Compartir Ubicación**: La aplicación compartirá tu ubicación cada 5 segundos durante 8 horas
4. **Ver Estado**: Presiona "Ver Estado de Compartir" para verificar el tiempo restante

## Funcionalidad Detallada

### Botón de Pánico
- Se deshabilita una vez activado
- Se re-habilita automáticamente después de 8 horas
- Muestra una notificación persistente

### LocationSharingService
- Servicio en primer plano que actualiza la ubicación cada 5 segundos
- Envía ubicación a contactos de emergencia
- Se detiene automáticamente después de 8 horas

### Gestión de Contactos
- Permite agregar contactos de emergencia
- Almacena los contactos localmente
- Permite eliminar contactos

## Dependencias

- AndroidX AppCompat
- Material Design Components
- Google Play Services Location
- Kotlin Coroutines
- DataStore Preferences

## Notas de Desarrollo

- La aplicación usa DataStore para persistencia de datos
- Los servicios de ubicación usan Fused Location Provider
- El envío de ubicación se puede integrar con SMS, WhatsApp o Telegram
- Se requiere testing en dispositivo físico debido a cambios en políticas de ubicación de Android

## Versión

v1.0 - Versión inicial

## Licencia

UNLICENSED
