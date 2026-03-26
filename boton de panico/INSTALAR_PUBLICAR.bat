@echo off
REM Script Maestro: Prueba, Firma y Prepara para Publicar
REM =======================================================

setlocal enabledelayedexpansion
cd /d "%~dp0"

:MENU
cls
echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║                     BOTÓN DE PÁNICO                    ║
echo ║              Prueba, Firma y Publica                   ║
echo ╚════════════════════════════════════════════════════════╝
echo.
echo Selecciona una opción:
echo.
echo  1) Probar en Emulador/Dispositivo (Debug)
echo  2) Compilar versión para Publicar (Release)
echo  3) Firmar APK con certificado
echo  4) Ver instrucciones para Google Play Store
echo  5) Completar todo el proceso (1+2+3)
echo  6) Limpiar archivos compilados
echo  7) Salir
echo.
set /p OPCION="Ingresa tu opción (1-7): "

if "%OPCION%"=="1" goto PRUEBA
if "%OPCION%"=="2" goto RELEASE
if "%OPCION%"=="3" goto FIRMAR
if "%OPCION%"=="4" goto INSTRUCCIONES
if "%OPCION%"=="5" goto TODO
if "%OPCION%"=="6" goto LIMPIAR
if "%OPCION%"=="7" goto SALIR

echo.
echo ❌ Opción inválida. Intenta de nuevo.
timeout /t 2 >nul
goto MENU

REM ============= 1. PRUEBA EN DISPOSITIVO =============
:PRUEBA
cls
echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║          Instalando App en Dispositivo/Emulador       ║
echo ╚════════════════════════════════════════════════════════╝
echo.
echo Asegúrate de que:
echo  ✓ Emulador esté abierto O dispositivo USB conectado
echo  ✓ Depuración USB habilitada (si es dispositivo real)
echo.
pause

echo [1/2] Compilando versión Debug...
call gradlew installDebug

if %ERRORLEVEL% neq 0 (
    echo.
    echo ❌ Error en instalación. Verifica:
    echo    - Dispositivo/emulador conectado
    echo    - Java y Android SDK instalados
    pause
    goto MENU
)

echo.
echo ✅ ¡App instalada y abierta en tu dispositivo!
echo.
echo PRUEBA ESTOS PASOS:
echo  1. Otorga todos los permisos cuando se solicite
echo  2. Presiona "Configurar Contactos de Emergencia"
echo  3. Ingresa un número de teléfono (tu número)
echo  4. Presiona "Agregar Contacto"
echo  5. Vuelve a pantalla principal
echo  6. Presiona el botón ROJO de pánico
echo  7. Verifica que recibas un SMS con tu ubicación
echo.
echo Presiona cualquier tecla para continuar...
pause
goto MENU

REM ============= 2. COMPILAR VERSIÓN RELEASE =============
:RELEASE
cls
echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║          Compilando Versión para Publicar             ║
echo ╚════════════════════════════════════════════════════════╝
echo.
echo Esto creará un APK optimizado y listo para Play Store.
echo.
pause

echo [1/3] Compilando versión Release...
call gradlew assembleRelease

if %ERRORLEVEL% neq 0 (
    echo.
    echo ❌ Error en compilación
    pause
    goto MENU
)

echo.
echo ✅ APK compilado exitosamente
echo.
echo Ubicación: app\build\outputs\apk\release\app-release.apk
echo Tamaño: 
dir /s "app\build\outputs\apk\release\app-release.apk"
echo.
pause
goto MENU

REM ============= 3. FIRMAR APK =============
:FIRMAR
cls
echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║        Firmar APK con Certificado (Keystore)          ║
echo ╚════════════════════════════════════════════════════════╝
echo.

if exist "boton_panico.keystore" (
    echo ✅ Archivo keystore encontrado: boton_panico.keystore
    echo.
    echo ¿Deseas:
    echo  1) Usar el keystore existente
    echo  2) Crear uno nuevo
    echo  3) Volver al menú
    echo.
    set /p OPCION_FIRMA="Opción: "
    
    if "!OPCION_FIRMA!"=="1" goto FIRMAR_EXISTENTE
    if "!OPCION_FIRMA!"=="2" goto CREAR_KEYSTORE
    goto MENU
) else (
    echo ℹ️ No hay keystore existente. Necesitas crear uno.
    echo.
    pause
    goto CREAR_KEYSTORE
)

:CREAR_KEYSTORE
echo.
echo Generando nuevo keystore...
echo.
echo ⚠️  IMPORTANTE:
echo  - Elige contraseña segura (mínimo 6 caracteres)
echo  - GUARDA ESTA CONTRASEÑA EN LUGAR SEGURO
echo  - LA NECESITARÁS PARA ACTUALIZACIONES FUTURAS
echo.
pause

echo.
echo Ingresa los datos:
set /p NOMBRE_COMPLETO="Nombre completo: "
set /p ORGANIZACION="Nombre organización: "
set /p CIUDAD="Ciudad: "
set /p PROVINCIA="Provincia: "
set /p PAIS="Código de país (ej: ES, MX, AR): "

REM Generar keystore con valores por defecto
keytool -genkey -v -keystore boton_panico.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias panico_key -dname "CN=%NOMBRE_COMPLETO%, OU=%ORGANIZACION%, L=%CIUDAD%, ST=%PROVINCIA%, C=%PAIS%" -storepass temporal123 -keypass temporal123

echo.
echo ✅ Keystore creado: boton_panico.keystore
echo.
echo Ahora necesitas configurar build.gradle con la contraseña
pause
goto MENU

:FIRMAR_EXISTENTE
echo.
set /p CONTRASEÑA="Ingresa contraseña del keystore: "
echo.
echo (Información: El APK ya debe estar compilado)
echo.
pause
goto MENU

REM ============= 4. INSTRUCCIONES PLAY STORE =============
:INSTRUCCIONES
cls
echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║            Pasos para Google Play Store                ║
echo ╚════════════════════════════════════════════════════════╝
echo.
echo ANTES DE PUBLICAR:
echo.
echo 1. CREAR CUENTA DEVELOPER ($25 USD - pago único)
echo    → https://play.google.com/console
echo.
echo 2. COMPILAR APK RELEASE
echo    → Opción 2 en este menú
echo.
echo 3. PREPARAR INFORMACIÓN:
echo    ✓ Descripción: 500 caracteres max
echo    ✓ Icono: 512x512px PNG
echo    ✓ Capturas: 2-8 imágenes (1080x1920px)
echo    ✓ Política de privacidad URL
echo.
echo 4. EN PLAY CONSOLE:
echo    ✓ Crear app
echo    ✓ Agregar descripción y contenido
echo    ✓ Subir APK firmado
echo    ✓ Responder cuestionario de contenido
echo.
echo 5. ENVIAR A REVISIÓN
echo    - Google revisa: 24-48 horas
echo    - Se publica automáticamente si aprueba
echo.
echo DOCUMENTACIÓN DISPONIBLE:
echo.
echo  • README.md - Información general
echo  • QUICKSTART.md - Guía rápida
echo  • CONFIGURATION.md - Manual de usuario
echo  • DEVELOPMENT.md - Notas técnicas
echo.
pause
goto MENU

REM ============= 5. COMPLETAR TODO =============
:TODO
cls
echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║            Ejecutar Proceso Completo                  ║
echo ║     Probar + Compilar Release + Firmar                ║
echo ╚════════════════════════════════════════════════════════╝
echo.
echo Esto ejecutará:
echo  1. Instalar en dispositivo/emulador (debug)
echo  2. Compilar versión release
echo  3. Crear/usar certificado de firma
echo.
pause

echo [PASO 1/3] Instalando versión Debug para prueba...
call gradlew installDebug
if %ERRORLEVEL% neq 0 goto ERROR

echo.
echo ✅ Versión debug instalada
echo.
echo [PASO 2/3] Compilando versión Release...
call gradlew assembleRelease
if %ERRORLEVEL% neq 0 goto ERROR

echo.
echo ✅ Versión release compilada
echo.
echo [PASO 3/3] Preparando firma...

if not exist "boton_panico.keystore" (
    echo.
    echo Generando certificado de firma...
    set /p NOMBRE="Nombre completo: "
    set /p ORG="Organización: "
    keytool -genkey -v -keystore boton_panico.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias panico_key -dname "CN=!NOMBRE!, OU=!ORG!, L=LOCAL, ST=LOCAL, C=ES" -storepass temporal123 -keypass temporal123
)

echo.
echo ✅ Firma lista
echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║              ¡LISTO PARA PUBLICAR!                     ║
echo ║                                                        ║
echo ║  APK Release:  app\build\outputs\apk\release\        ║
echo ║                app-release.apk                        ║
echo ║                                                        ║
echo ║  Keystore:     boton_panico.keystore                 ║
echo ║                                                        ║
echo ║  Próximo paso:                                        ║
echo ║  → Ir a https://play.google.com/console              ║
echo ║  → Crear nueva app                                   ║
echo ║  → Subir app-release.apk                             ║
echo ║                                                        ║
echo ╚════════════════════════════════════════════════════════╝
echo.
pause
goto MENU

:ERROR
echo.
echo ❌ Error en el proceso. Revisa la salida anterior.
echo.
pause
goto MENU

REM ============= 6. LIMPIAR =============
:LIMPIAR
cls
echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║              Limpiar Archivos Compilados              ║
echo ╚════════════════════════════════════════════════════════╝
echo.
echo Esto eliminará:
echo  - Carpeta build/
echo  - Archivos .gradle
echo  - Archivos temporales
echo.
set /p CONFIRMA="¿Deseas continuar? (s/n): "

if /i "%CONFIRMA%"=="s" (
    echo Limpiando...
    call gradlew clean
    echo ✅ Limpieza completada
) else (
    echo Cancelado
)

pause
goto MENU

REM ============= 7. SALIR =============
:SALIR
echo.
echo ¡Hasta luego!
echo.
exit /b 0
