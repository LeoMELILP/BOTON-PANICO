@echo off
REM Script para generar clave de firma para Google Play Store
REM Este script crea un archivo keystore.jks necesario para firmar la app

echo.
echo ================================================
echo   GENERAR CLAVE DE FIRMA PARA GOOGLE PLAY
echo ================================================
echo.

setlocal enabledelayedexpansion

REM Verificar que tenemos Java
java -version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Java no esta instalado
    pause
    exit /b 1
)

cd /d "%~dp0"

REM Crear carpeta app si no existe
if not exist "app" (
    echo [ERROR] No estamos en la carpeta del proyecto
    pause
    exit /b 1
)

echo [1/3] Generando clave de firma...
echo.

REM Generar el keystore
keytool -genkey -v -keystore app\keystore.jks ^
    -keyalg RSA ^
    -keysize 2048 ^
    -validity 10000 ^
    -alias panico_key ^
    -storepass panico123 ^
    -keypass panico123 ^
    -dname "CN=Boton Panico, O=Emergency App, L=Worldwide, ST=World, C=UN"

if errorlevel 1 (
    echo [ERROR] Problema al generar la clave
    pause
    exit /b 1
)

echo.
echo [2/3] Verificando clave generada...

if exist "app\keystore.jks" (
    echo [OK] Clave de firma generada exitosamente
    echo.
    echo Ubicacion: app\keystore.jks
    echo Alias: panico_key
    echo Contrasena: panico123
    echo Validez: 10000 dias (aproximadamente 27 anos)
    echo.
    echo [3/3] Proximo paso:
    echo  1. Sube los cambios a GitHub: git add . && git commit -m "Agregar configuracion de firma" && git push
    echo  2. En App Center, compila la app nuevamente
    echo  3. Se generara un APK firmado listo para Google Play Store
    echo.
) else (
    echo [ERROR] No se genero la clave
    pause
    exit /b 1
)

pause
