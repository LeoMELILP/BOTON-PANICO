# 📱 INSTALACIÓN Y PUBLICACIÓN - Guía Paso a Paso

## 🚀 START HERE - COMIENZA AQUÍ

### Opción 1: Menú Interactivo (Más Fácil) ✅ RECOMENDADO

Ejecuta este archivo en tu carpeta del proyecto:

**Windows:**
```bash
INSTALAR_PUBLICAR.bat
```

Selecciona qué deseas hacer:
- 1️⃣ Probar en tu dispositivo
- 2️⃣ Compilar para publicar
- 3️⃣ Firmar con certificado
- 5️⃣ Hacer todo automáticamente

---

## 📋 PROCESO MANUAL (Si prefieres paso a paso)

### PASO 1: INSTALAR EN UN DISPOSITIVO (PRUEBA)

**Requisitos:**
- Dispositivo Android o emulador abierto
- USB Debugging habilitado (si es dispositivo físico)

**En Windows PowerShell o CMD:**
```bash
cd c:\Users\lcanett\Desktop\boton de panico
gradlew installDebug
```

**En Android Studio:**
1. Click derecho en "app" → Run
2. O presiona: Mayús + F10
3. Selecciona tu dispositivo

**Qué pasará:**
- ✅ Se compilará la app
- ✅ Se instalará automáticamente
- ✅ Se abrirá en tu dispositivo

**Ahora Prueba Estos Pasos:**
```
1. Abre la app "Botón de Pánico"
2. TAP "Permitir" para TODOS los permisos
3. TAP "Configurar Contactos de Emergencia"
4. Ingresa:
   - Nombre: "Mi Teléfono"
   - Número: Tu número de teléfono (ej: +34 612345678)
5. TAP "Agregar Contacto"
6. Vuelve atrás
7. TAP el botón ROJO grande:  Botón de Pánico
8. Espera... deberías recibir SMS con tu ubicación
```

**Si ves SMS con ubicación: ✅ ¡App funciona correctamente!**

---

### PASO 2: COMPILAR VERSIÓN PARA PUBLICAR

Esta versión estará optimizada y lista para Google Play Store.

```bash
cd c:\Users\lcanett\Desktop\boton de panico
gradlew assembleRelease
```

**Espera 2-5 minutos...**

**Resultado:**
- Ubicación: `app/build/outputs/apk/release/app-release.apk`
- Este es tu APK para publicar

**Para verlo en el explorador:**
```
Abre: c:\Users\lcanett\Desktop\boton de panico\app\build\outputs\apk\release
```

---

### PASO 3: CREAR CERTIFICADO DE FIRMA (Keystore)

¡IMPORTANTE! Esto lo haces UNA SOLA VEZ. Guarda bien la contraseña.

**En Windows PowerShell (como administrador):**

```bash
cd c:\Users\lcanett\Desktop\boton de panico

keytool -genkey -v -keystore boton_panico.keystore `
  -keyalg RSA -keysize 2048 -validity 10000 -alias panico_key
```

**Te pedirá:**
```
Ingresa contraseña del almacén de claves: [ESCRIBE UNA CONTRASEÑA]
Vuelva a escribir la contraseña nueva: [REPITE LA CONTRASEÑA]

¿Cuál es su nombre y apellido? [tu nombre]
¿Cuál es el nombre de su unidad de la organización? [tu empresa]
¿Cuál es el nombre de su organización? [tu empresa]
¿Cuál es el nombre de su ciudad o localidad? [tu ciudad]
¿Cuál es el nombre de su estado o provincia? [tu provincia]
¿Cuál es el código de país de dos letras para esta unidad? [ES, MX, AR, etc]
¿Es correcto CN=nombre, OU=empresa, O=empresa, L=ciudad, ST=provincia, C=ES? [yes]

Ingresa contraseña para <panico_key>: [MISMA CONTRASEÑA]
Vuelva a escribir la contraseña nueva: [REPITE]
```

**Resultado:**
- ✅ Archivo creado: `boton_panico.keystore`
- ⚠️ NUNCA lo compartas ni lo subas a GitHub
- 📝 GUARDA LA CONTRASEÑA EN UN LUGAR SEGURO

---

### PASO 4: CONFIGURAR build.gradle PARA FIRMAR

Abre: `app/build.gradle`

Busca la sección `buildTypes` y reemplázala con esto:

```gradle
signingConfigs {
    release {
        storeFile file('boton_panico.keystore')
        storePassword 'TU_CONTRASEÑA_AQUI'  // ← Cambia esto
        keyAlias 'panico_key'
        keyPassword 'TU_CONTRASEÑA_AQUI'     // ← Y esto
    }
}

buildTypes {
    release {
        signingConfig signingConfigs.release
        minifyEnabled true
        proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
    }
}
```

**EJEMPLO COMPLETO (el que ya deberías tener):**
```gradle
android {
    namespace 'com.example.panicobutton'
    compileSdk 34
    
    // ... resto de configuración ...
    
    signingConfigs {
        release {
            storeFile file('boton_panico.keystore')
            storePassword 'micontraseña123'
            keyAlias 'panico_key'
            keyPassword 'micontraseña123'
        }
    }

    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
```

---

### PASO 5: PUBLICAR EN GOOGLE PLAY STORE

#### 5.1 - Crear Cuenta Developer

1. Ve a: https://play.google.com/console
2. Click derecho en tu perfil → "Crear cuenta"
3. Paga $25 USD (pago único)
4. Completa tu perfil de desarrollador

#### 5.2 - Crear Aplicación en Play Console

1. Play Console → **Crear aplicación**
2. Nombre: **"Botón de Pánico"**
3. Categoría: **Herramientas** o **Seguridad**
4. Click: **Crear aplicación**

#### 5.3 - Completar Información de la App

**Sección: "Información de la aplicación"**

```
Título:     Botón de Pánico
Descripción corta (80 caracteres):
            Comparte ubicación en emergencia

Descripción completa (máximo 4000):
            🚨 BOTÓN DE PÁNICO - Emergencias

            Activa un botón de pánico y comparte tu 
            ubicación en tiempo real con contactos 
            de emergencia durante 8 horas.

            ✅ CARACTERÍSTICAS:
            • Botón de pánico grande y fácil
            • Ubicación cada 5 segundos
            • Envía SMS con Google Maps
            • Almacenamiento local seguro
            • Sin servidor remoto

            ✓ Ideal para:
            - Viajes nocturnos
            - Entregas a domicilio
            - Trabajo de seguridad
            - Personas viviendo solas

            ⚠️ Requiere permisos de:
            - Ubicación GPS
            - Envío de SMS
            - Acceso a contactos
            - Notificaciones
```

**Icono de la App:**
- Tamaño: 512 x 512px
- Formato: PNG o JPEG
- Descripción: Usar algo como 🚨 rojo alertante

**Capturas de pantalla:**
- Tamaño: 1080 x 1920px
- Cantidad: 2-8 imágenes
- Mostrar: Pantalla principal, botón de pánico, contactos

#### 5.4 - Subir APK

1. En Play Console → **Publicación** → **Tu aplicación en Google Play**
2. Click: **Crear nuevo lanzamiento** → **Producción**
3. Click: **Subir APK**
4. Selecciona: `app-release.apk`
5. Espera a que suba (1-2 minutos)

#### 5.5 - Política de Privacidad

En "Política de privacidad" agrega:

```
POLÍTICA DE PRIVACIDAD - Botón de Pánico

DATOS RECOPILADOS:
• Tu ubicación GPS
• Números de contactos de emergencia

ALMACENAMIENTO:
• Todo en tu dispositivo (local)
• NO se envía a servidores externos
• Se borra al desinstalar

PERMISOS:
• Ubicación: Capturar tu posición
• SMS: Enviar ubicación a contactos
• Contactos: Sugerir contactos

COMPARTICIÓN:
• Solo con contactos que agregues
• Via SMS estándar
• No se vende ningún dato
```

#### 5.6 - Cuestionario de Contenido

```
¿Es una app infantil?              NO
¿Contiene publicidad?              NO
¿Contiene compras dentro?          NO
¿Requiere suscripción?             NO
¿Tiene contenido sensible?         NO
¿Contacta con dispositivos externos? SÍ (solo GPS/SMS)
```

#### 5.7 - Enviar a Revisión

1. Presiona: **Revisar lanzamiento**
2. Acepta términos
3. Presiona: **Enviar a producción**
4. **Google revisa: 24-48 horas**
5. Se publica automáticamente si aprueba ✅

---

## ✅ CHECKLIST FINAL

Antes de publicar, verifica:

- [ ] App probada en dispositivo
- [ ] Botón de pánico funciona
- [ ] SMS se reciben correctamente
- [ ] Ubicación es precisa
- [ ] Todos los permisos solicitados
- [ ] Descripción clara en español
- [ ] Política de privacidad
- [ ] Icono 512x512 listo
- [ ] Capturas de pantalla (mín 2)
- [ ] Cuenta Developer creada ($25 pagado)
- [ ] APK release compilado
- [ ] Keystore guardado en lugar seguro
- [ ] build.gradle con firma configurada

---

## 📞 SOPORTE

Si tienes problemas en algún paso:

**Error de compilación:**
```bash
gradlew clean
gradlew assembleRelease
```

**Dispositivo no detecta:**
```bash
adb devices
adb kill-server
adb start-server
```

**Revisar logs:**
```bash
adb logcat
```

---

## 🎯 RESUMEN RÁPIDO

```
1. PROBAR:      gradlew installDebug
2. COMPILAR:    gradlew assembleRelease
3. FIRMAR:      keytool -genkey ...
4. PUBLICAR:    Google Play Console
```

¡Listo! Tu app estará disponible para que cualquiera la descargue. 🚀

---

**Última actualización:** March 26, 2026
**Documento:** PASO_A_PASO.md
