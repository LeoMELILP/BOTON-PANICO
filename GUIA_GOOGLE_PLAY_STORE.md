# INSTRUCCIONES PARA SUBIR A GOOGLE PLAY STORE

## Cambios Realizados ✅

He arreglado tu código para cumplir con los requisitos de Google Play Store:

### 1. **Configuración de Firma Digital** 
- ✅ Agregué `signingConfigs` en build.gradle
- ✅ Configurado para usar keystore.jks

### 2. **Permisos Corregidos**
- ❌ Removí el permiso inválido: `android.permission.SET_ALARM`
- ✅ Agregué el permiso correcto: `android.permission.FOREGROUND_SERVICE`

### 3. **Dokumentos Legales**
- ✅ Creé PRIVACY_POLICY.md (Política de Privacidad)
- ✅ Creé TERMS_OF_SERVICE.md (Términos de Servicio)

---

## PASOS PARA GENERAR Y SUBIR EL APK

### PASO 1: Generar Clave de Firma (IMPORTANTE ⚠️)

```powershell
cd "C:\Users\lcanett\Desktop\boton de panico"
.\GENERAR_CLAVE_FIRMA.bat
```

Este script creará el archivo `keystore.jks` que Google Play necesita para verificar que eres el desarrollador.

**Nota:** Se usarán estas credenciales:
- Contraseña: `panico123`
- Alias: `panico_key`
- Validez: 10,000 días (suficiente para toda la vida de la app)

### PASO 2: Subir Cambios a GitHub

```powershell
git add .
git commit -m "Prepare for Google Play Store: Add signing config, fix permissions, add policies"
git push origin main
```

### PASO 3: Compilar en App Center

1. Ve a: https://appcenter.ms/
2. Selecciona tu app "Boton de Panico"
3. En **Build**, haz clic en "Build now"
4. Espera a que termine (la compilará ahora con firma)

### PASO 4: Descargar APK Firmado

1. Cuando la compilación termine, descarga el APK
2. Será un APK completamente firmado y listo para Play Store

### PASO 5: Crear Cuenta en Google Play Console

1. Ve a: https://play.google.com/console
2. Haz clic en "Crear cuenta de desarrollador"
3. Paga $25 USD (única vez)
4. Completa tu perfil

### PASO 6: Crear Aplicación en Play Store

1. En Google Play Console, haz clic en "Crear aplicación"
2. **Nombre**: Botón de Pánico
3. **Idioma**: Español
4. **Categoría**: Herramientas o Utilidades
5. **Clasificación**: Selecciona apropiadamente

### PASO 7: Cargar APK

1. En la aplicación, ve a: **Producción** → **Versiones**
2. Haz clic en "Crear nueva versión"
3. Sube el APK descargado de App Center
4. Completa the información:
   - Título: Botón de Pánico
   - Descripción: "App de emergencia que comparte ubicación por 8 horas"
   - Notas de versión: "Versión inicial"

### PASO 8: Información de la App

Completa toda la información en Play Store:

#### Pantalla Privada
- Sube una captura de pantalla del botón de pánico

#### Descripción Corta (80 caracteres)
```
Comparte tu ubicación en emergencias
```

#### Descripción Completa
```
Botón de Pánico es una aplicación que permite:

✅ Compartir tu ubicación por 8 horas
✅ Enviar SMS automáticos a contactos de emergencia
✅ Rastrear ubicación en tiempo real
✅ Interfaz simple e intuitiva

Ideal para:
- Emergencias personales
- Viajes de seguridad
- Trabajadores solitarios
- Padres con preocupaciones de seguridad

Tu privacidad es importante:
- No guardamos datos en servidores
- Ubicación solo con tu consentimiento
- SMS enviados solo a tus contactos
```

#### Correo de Desarrollador
```
contacto@panicobutton.com
```

#### Sitio Web (opcional)
```
https://github.com/LeoMELILP/BOTON-PANICO
```

#### Política de Privacidad
```
Copia el contenido de PRIVACY_POLICY.md
```

#### Términos de Servicio
```
Copia el contenido de TERMS_OF_SERVICE.md
```

### PASO 9: Información de Clasificación

Google Play te pedirá información de clasificación:
- Ubicación: ✅ Selecciona que accedes a ubicación
- SMS: ✅ Selecciona que envías SMS
- Lo demás: No selecciones

### PASO 10: Configuración de Precios

- Selecciona: **Gratis**
- Disponibilidad: Todos los países

### PASO 11: Enviar para Revisión

1. Completa todos los campos
2. Haz clic en "Enviar para revisión"
3. Google revisará tu app (generalmente 2-24 horas)
4. Si todo está OK, se publicará automáticamente

---

## ⚠️ IMPORTANTE - PRIMEROS PASOS

**Tienes que hacer esto en ESTE ORDEN:**

1. **HOY**: Ejecuta `GENERAR_CLAVE_FIRMA.bat`
2. **HOY**: Sube cambios a GitHub
3. **HOY**: Compila en App Center
4. **MAÑANA**: Crea cuenta en Google Play Console
5. **MAÑANA**: Sube APK y completa información

---

## PROBLEMAS POSIBLES

### "Error: keystore no encontrado"
**Solución**: Ejecuta`GENERAR_CLAVE_FIRMA.bat` primero

### "APK no firmado"
**Solución**: Asegúrate de que `app/keystore.jks` existe

### "Permiso denegado en Play Store"
**Solución**: Debes crear cuenta de desarrollador ($25 USD)

### "App rechazada por Policy"
**Solución**: Completa TODOS los campos requeridos

---

## Archivos Creados/Modificados ✅

- ✅ `app/build.gradle` - Actualizado con signingConfigs
- ✅ `app/src/main/AndroidManifest.xml` - Permisos corregidos
- ✅ `PRIVACY_POLICY.md` - Nueva política de privacidad
- ✅ `TERMS_OF_SERVICE.md` - Nuevos términos de servicio
- ✅ `GENERAR_CLAVE_FIRMA.bat` - Script para generar clave
- ✅ `app/keystore.jks` - Se generará cuando ejecutes el script

---

¿Necesitas ayuda en algún paso? ¡Dime en cuál te atascas!
