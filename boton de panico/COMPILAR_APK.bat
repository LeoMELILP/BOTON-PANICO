@echo off
chcp 65001 >nul
echo.
echo ================================================
echo   COMPILANDO APP - Boton de Panico
echo   Version Debug para Appetize.io
echo ================================================
echo.

cd /d "%~dp0"

setlocal enabledelayedexpansion

REM Verificar que tenemos Java
java -version >nul 2>&1
if errorlevel 1 (
    echo.
    echo [ERROR] Java no esta instalado o no esta en el PATH
    echo.
    echo Solucion:
    echo  1. Descarga Java JDK 11+: https://www.oracle.com/java/technologies/downloads/
    echo  2. Instalalo
    echo  3. Reinicia PowerShell o CMD
    echo  4. Intenta de nuevo
    echo.
    pause
    exit /b 1
)

echo [OK] Java encontrado
echo.

REM Verificar que estamos en la carpeta correcta
if not exist "build.gradle" (
    echo.
    echo [ERROR] No estamos en la carpeta del proyecto
    echo.
    echo Esta carpeta debe contener: build.gradle
    echo.
    pause
    exit /b 1
)

echo [OK] Proyecto encontrado
echo.

echo [1/4] Limpiando compilaciones anteriores...
call gradlew.bat clean

if errorlevel 1 (
    echo [ERROR] Problema al limpiar
    echo Intenta ejecutar: gradlew clean
    pause
    exit /b 1
)

echo [OK] Limpieza completada
echo.

echo [2/4] Descargando dependencias...
call gradlew.bat --refresh-dependencies

echo.
echo [3/4] Compilando version Debug (esto puede tardar un momento)...
call gradlew.bat assembleDebug

if errorlevel 1 (
    echo.
    echo [ERROR] Problema en la compilacion
    echo.
    echo Posibles soluciones:
    echo  1. Asegurate de tener Android SDK instalado
    echo  2. Actualiza Gradle y dependencias
    echo  3. Limpia cache: gradlew clean
    echo.
    pause
    exit /b 1
)

echo.
echo [OK] Compilacion exitosa
echo.

echo [4/4] Verificando APK generado...

if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo.
    echo ================================================
    echo   [EXITO] APK LISTO PARA APPETIZE.IO
    echo.
    echo  Ubicacion:
    echo  app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo  IMPORTANTE: Para Appetize.io
    echo  - Sube UNICAMENTE el archivo .apk
    echo  - NO subficas ZIP ni carpetas
    echo  - Solo: app-debug.apk
    echo.
    echo  Pasos:
    echo  1. Ve a https://appetize.io
    echo  2. Presiona "Choose file"
    echo  3. Selecciona SOLO app-debug.apk
    echo  4. Espera a que suba
    echo.
    echo ================================================
    echo.
    
    echo Detalles del APK: 
    dir app\build\outputs\apk\debug\app-debug.apk
    
) else (
    echo.
    echo [ERROR] No se encontro el APK generado
    echo.
    echo Intenta:
    echo  1. Ejecuta: gradlew clean
    echo  2. Ejecuta: gradlew assembleDebug
    echo  3. Revisa si hay errores arriba
    echo.
)

pause
