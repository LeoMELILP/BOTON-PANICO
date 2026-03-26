@echo off
chcp 65001 >nul
echo.
echo ================================================
echo   DIAGNOSTICO DEL PROYECTO
echo ================================================
echo.

cd /d "%~dp0"

echo [1] Verificando estructura del proyecto...
echo.

if exist "build.gradle" (
    echo [OK] build.gradle encontrado
) else (
    echo [ERROR] build.gradle NO ENCONTRADO
)

if exist "app" (
    echo [OK] carpeta app/ encontrada
) else (
    echo [ERROR] carpeta app/ NO ENCONTRADA
)

if exist "app\build.gradle" (
    echo [OK] app/build.gradle encontrado
) else (
    echo [ERROR] app/build.gradle NO ENCONTRADO
)

if exist "app\src\main\AndroidManifest.xml" (
    echo [OK] AndroidManifest.xml encontrado
) else (
    echo [ERROR] AndroidManifest.xml NO ENCONTRADO
)

echo.
echo [2] Verificando Java...
java -version 2>&1

echo.
echo [3] Verificando Gradle y dependencias...
call gradlew.bat --version

echo.
echo [4] Limpiando compilaciones previas...
call gradlew.bat clean

echo.
echo [5] Compilando (esto puede tardar varios minutos)...
call gradlew.bat assembleDebug 2>&1

echo.
echo [6] Buscando APK generado...
echo.

if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo [OK] APK generado exitosamente
    echo.
    echo Detalles:
    dir app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo [LISTO] Puedes subir este archivo a Appetize.io
) else (
    echo [ERROR] APK no encontrado en app\build\outputs\apk\debug\
    echo.
    echo Buscando archivos en build...
    if exist "app\build" (
        echo Contenido de app\build:
        dir /s app\build\*.apk 2>nul
    ) else (
        echo [ERROR] Carpeta app\build no existe
    )
)

echo.
pause
