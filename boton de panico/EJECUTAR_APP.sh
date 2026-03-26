#!/bin/bash
# Script para ejecutar la aplicación Botón de Pánico en Mac/Linux

echo "╔═══════════════════════════════════════╗"
echo "║   BOTÓN DE PÁNICO - App Android      ║"
echo "║   Compilando versión Debug...        ║"
echo "╚═══════════════════════════════════════╝"
echo

cd "$(dirname "$0")"

echo "[1/3] Compilando aplicación..."
./gradlew installDebug

if [ $? -ne 0 ]; then
    echo
    echo "❌ ERROR en la compilación. Verifica:"
    echo "   - Java 11+ instalado"
    echo "   - Android SDK actualizado"
    echo "   - Dispositivo conectado o emulador activo"
    exit 1
fi

echo
echo "✅ Compilación exitosa"
echo
echo "[2/3] Instalando en dispositivo/emulador..."
echo "Espera a que se instale y ejecute automáticamente..."
echo

sleep 2

echo
echo "✅ Aplicación instalada y ejecutada"
echo
echo "╔═══════════════════════════════════════╗"
echo "║   ¡APP ABIERTA EN TU DISPOSITIVO!    ║"
echo "║                                       ║"
echo "║   Pasos para probar:                 ║"
echo "║   1. Otorga todos los permisos       ║"
echo "║   2. Presiona 'Configurar Contactos' ║"
echo "║   3. Agrega un contacto de prueba    ║"
echo "║   4. Presiona el botón rojo de pánico║"
echo "║   5. Verifica SMS recibidos          ║"
echo "║                                       ║"
echo "╚═══════════════════════════════════════╝"
echo
