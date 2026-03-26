# Configuración y Uso de la Aplicación

## Primer Uso

### 1. Permisos Requeridos

Al abrir la aplicación por primera vez, te pedirá los siguientes permisos:

#### ✓ **Ubicación (ACCESS_FINE_LOCATION)**
- Necesario para obtener tu ubicación exacta
- Requerido para compartir ubicación con contactos
- ⚠️ En Android 6+: Se solicita en tiempo de ejecución

#### ✓ **Enviar SMS (SEND_SMS)**
- Permite enviar tu ubicación como mensaje de texto
- Necesario para contactar a emergencias

#### ✓ **Leer Contactos (READ_CONTACTS)**
- Permite sugerir contactos para agregar como emergencia
- Opcional pero recomendado

#### ✓ **Notificaciones (POST_NOTIFICATIONS)**
- Muestra notificación persistente mientras se comparte ubicación
- Requerido en Android 13+

**Pasos:**
1. Abre la aplicación
2. Verás un diálogo pidiendo permisos
3. Toca "Permitir" para otorgar cada permiso
4. Si rechazas, la app funcionará con funciones limitadas

### 2. Agregar Contactos de Emergencia

**Pantalla:** "Configurar Contactos de Emergencia"

1. Presiona botón **"Configurar Contactos de Emergencia"** en la pantalla principal
2. Ingresa un **Nombre** (ej: "Mamá", "Hospital", "Policía")
3. Ingresa un **Número de Teléfono** (ej: "+34 612345678")
4. Presiona **"Agregar Contacto"**
5. El contacto aparecerá en la lista de debajo

#### Sugerencias de Contactos:
```
Categoría          | Ejemplos
------------------|--------------------------------------------------
Familia            | Mamá, Papá, Hermana, Cónyuge
Amigos             | Mejor amigo, Compañero de cuarto
Autoridades        | Policía (091), Ambulancia (061), Bomberos (080)
Emergencias        | Hospital cercano, Centro de urgencias
Trabajo            | Jefe, Supervisor, HR
Otros              | Vecino, Compañero de trabajo
```

## Cómo Activar el Botón de Pánico

### Situaciones de Uso:
- 🚗 Accidente automovilístico
- 🏥 Emergencia médica
- 🚨 Situación de peligro
- 💊 Necesidad de ayuda inmediata
- 🩹 Incapacidad para llamar

### Activación:

1. **Pantalla Principal**
   - Verás un botón grande **rojo** con "Botón de Pánico"
   - Está ubicado en el centro de la pantalla

2. **Presiona el botón**
   - El botón se deshabilitará
   - Mostrará "Compartiendo ubicación (8 horas)"
   - Verás una notificación en la barra superior

3. **La aplicación:**
   - Capturará tu ubicación cada 5 segundos
   - Enviará SMS a todos tus contactos de emergencia
   - Mostrará notificación persistente
   - Se reiniciará después de 8 horas automáticamente

## Mensajes que Reciben los Contactos

### Formato del SMS:
```
🚨 ¡ALERTA DE PÁNICO! 🚨

Mi ubicación actual:
📍 Latitud: 40.4168° N
📍 Longitud: 3.7038° W
📍 Precisión: 15m

Ver en Google Maps:
https://maps.google.com/?q=40.4168,3.7038

Tiempo: 14:32:45
```

**Cada 5 segundos reciben una actualización** con la nueva ubicación

## Ver Estado de Compartir

Presiona el botón **"Ver Estado de Compartir"** en la pantalla principal para:
- ✓ Verificar si está compartiendo ubicación
- ✓ Ver cuántas horas faltan para terminar
- ✓ Confirmar que el servicio está activo

## Detener Compartir Ubicación Manualmente

**Opción 1: Automático**
- Se detiene automáticamente después de 8 horas

**Opción 2: Manual** (actualmente no implementado)
- Agregar un botón "Detener" en futuras versiones

## Información Técnica

### Frecuencia de Actualización
- **Cada 5 segundos** se captura la ubicación
- **Cada actualización** se envía SMS a contactos
- **Durante 8 horas** continúa actualizándose

⚠️ **Nota importante sobre SMS:**
- Cada SMS cuesta dinero (según tu operador)
- Con 1 contacto: ~72 SMS en 8 horas
- Con 5 contactos: ~360 SMS en 8 horas
- Considera esto al configurar contactos

### Batería
- El servicio usa mucha batería
- Requiere pantalla activa o CPU despierta
- Recarga el dispositivo antes de activar

### Datos Móviles
- Usa mínimos datos (solo envío de SMS)
- Si no es SMS, requiere conexión activa

### GPS
- Requiere GPS o triangulación de red
- En exterior: 5-10 metros de precisión
- En interior: 20-50 metros de precisión

## Privacidad y Seguridad

### ¿Dónde se guardan los datos?
- Números de teléfono: **Almacenamiento local del dispositivo**
- Instalación: **Memoria interna del teléfono**
- Historial de ubicación: **No se guarda**
- Logs: **Memoria caché local**

### ¿Quién puede ver mi ubicación?
- Solo los contactos de emergencia que agregaste
- Reciben actualizaciones por SMS
- No se sube a servidor externo (versión actual)

### Eliminación de Datos
- Desinstalar la app borra todos los datos
- Eliminar contactos es manual

## Troubleshooting

### Problema: El botón de pánico no funciona

**Solución:**
1. Verifica que hayas otorgado permisos
2. Verifica tener contactos de emergencia agregados
3. Reinicia la app
4. Reinicia el dispositivo

### Problema: No se envían SMS

**Causas posibles:**
- ❌ Permiso SEND_SMS no otorgado
- ❌ No tienes plan de SMS activo
- ❌ Números de teléfono inválidos
- ❌ Saldo insuficiente (prepago)

**Solución:**
1. Verifica permisos en Configuración → Aplicaciones
2. Prueba enviando SMS manual desde Mensajes
3. Verifica formato de número (+34 612345678)
4. Comprueba saldo en tu operador

### Problema: Ubicación inexacta

**Causas:**
- 🏠 Interior de edificio
- ☁️ Nublado/mal clima
- 📡 Falta cobertura GPS
- 🏙️ Cañones urbanos

**Solución:**
1. Intenta al aire libre
2. Espera 10-20 segundos para lock GPS
3. Activa "Ubicación precisa" en Configuración

### Problema: Batería se agota rápido

**Causa:** El servicio mantiene GPS activo

**Soluciones:**
1. Reduce frecuencia de actualización en código
2. Aumenta el intervalo de 5000ms a 10000ms
3. Cierra otras apps de fondo
4. Reduce brillo de pantalla

## Testing

### Cómo probar sin activar pánico real:

1. **Testing de SMS:**
   - Agrega un número de prueba tuyo
   - Activa pánico en modo test
   - Verifica que recibas SMS

2. **Testing de Ubicación:**
   - Usa emulador de ubicación (Google Maps)
   - O FakeGPS en Play Store
   - Verifica ubicación correcta en SMS

3. **Testing de Permisos:**
   - Revoca permisos en Configuración
   - Intenta activar pánico
   - Verifica diálogos de permisos

## Soporte y Feedback

Para reportar problemas o sugerencias:
- Ubicación: `c:\Users\lcanett\Desktop\boton de panico`
- Ver archivo: `DEVELOPMENT.md`
- Revisar: `README.md`

---

**Última actualización:** March 26, 2026
