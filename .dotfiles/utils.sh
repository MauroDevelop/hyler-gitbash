# ==========================================
# Muestra la configuración
# ==========================================
mi-config() {
    clear
    echo -e "\e[33m========== TU CONFIGURACIÓN ACTUAL ==========\e[0m"
    echo -e "\e[36m👤 Nombre en terminal:\e[0m ${USER_NAME:-No definido}"
    
    # Lógica inteligente para mostrar el estado real del logo
    if [ -s "$HOME/.dotfiles/custom_logo.txt" ]; then
        echo -e "\e[36m🏷️  Título del Dashboard:\e[0m [Arte ASCII Personalizado]"
    elif [ -n "$DASHBOARD_TITLE" ]; then
        echo -e "\e[36m🏷️  Título del Dashboard:\e[0m $DASHBOARD_TITLE"
    else
        echo -e "\e[36m🏷️  Título del Dashboard:\e[0m Predeterminado (Hyler)"
    fi
    
    echo -e "\e[36m🏙️  Ciudad (Clima):\e[0m ${WEATHER_CITY:-Mendoza}"
    echo -e "\e[36m📁 Directorio Proyectos:\e[0m ${LEARNING_PATH:-No definido}"
    echo -e "\e[36m📝 Archivo de Notas:\e[0m ${NOTES_FILE:-No definido}"
    echo -e "\e[33m=============================================\e[0m"
    echo -e "\e[90m(Usa 'configurar-entorno' para cambiar estos valores)\e[0m"
    echo ""
    
    # Pausa interactiva
    echo -e "\e[5mPresiona cualquier tecla para volver...\e[0m"
    read -n 1 -s -r
    
    # Redibuja el dashboard
    dashboard
}

# ==========================================
# ASISTENTE
# ==========================================
configurar-entorno() {
    clear
    echo -e "\e[36m==================================================\e[0m"
    echo -e "\e[36m   ASISTENTE DE CONFIGURACIÓN HYLER  \e[0m"
    echo -e "\e[36m==================================================\e[0m"
    echo "¡Bienvenido! Vamos a dejar tu terminal lista para programar."
    echo "Si no querés cambiar un valor, simplemente presiona ENTER."
    echo ""

    # 1. Nombre
    echo -e "\e[33m1. Nombre de Usuario\e[0m"
    echo -e "\e[90mEste nombre aparecerá en la línea donde escribes.\e[0m"
    read -p "❯ Nombre (Actual: $USER_NAME): " input_name
    input_name="${input_name:-$USER_NAME}"
    echo ""

    # 2. Título del Dashboard
    echo -e "\e[33m2. Título del Dashboard (Texto corto)\e[0m"
    echo -e "\e[90mEscribe UNA SOLA LÍNEA (Ej: Mauro Workspace).\e[0m"
    echo -e "\e[90mNota: Para logos ASCII gigantes, usa el comando 'mi-logo' más tarde.\e[0m"
    read -p "❯ Título (Actual: $DASHBOARD_TITLE): " input_title
    input_title="${input_title:-$DASHBOARD_TITLE}"
    echo ""

    # 3. Ciudad
    echo -e "\e[33m3. Ciudad para el Clima\e[0m"
    echo -e "\e[90mUsa '+' para los espacios (Ej: Buenos+Aires).\e[0m"
    read -p "❯ Ciudad (Actual: $WEATHER_CITY): " input_city
    input_city="${input_city:-$WEATHER_CITY}"
    echo ""

    # 4. Directorio de Proyectos
    echo -e "\e[33m4. Directorio de Proyectos (Atajo 'api')\e[0m"
    echo -e "\e[90mUsa el punto '.' para elegir tu carpeta actual ($PWD).\e[0m"
    read -p "❯ Ruta (Actual: $LEARNING_PATH): " input_path
    if [ "$input_path" == "." ]; then
        input_path="$PWD"
    else
        input_path="${input_path:-$LEARNING_PATH}"
    fi
    echo ""

    # 5. Archivo de Notas
    echo -e "\e[33m5. Archivo de Notas (Backlog)\e[0m"
    echo -e "\e[90m¿Dónde querés guardar tu archivo de tareas? (Se llamará 'notas_dev.txt')\e[0m"
    echo -e "\e[90m- Presiona ENTER para mantener la ruta actual.\e[0m"
    echo -e "\e[90m- Escribe un punto '.' para guardarlo en la carpeta donde estás ahora.\e[0m"
    read -p "❯ Ruta (Actual: $NOTES_FILE): " input_notas
    
    # Lógica inteligente para la ruta de notas
    if [ -z "$input_notas" ]; then
        # Si presiona Enter, mantiene lo que ya tenía
        input_notas="$NOTES_FILE"
    elif [ "$input_notas" == "." ]; then
        # Si pone un punto, usa la carpeta actual y le agrega el nombre del archivo
        input_notas="$PWD/notas_dev.txt"
    else
        # Si escribe una ruta pero se olvida de ponerle el .txt al final, se lo agregamos
        if [[ "$input_notas" != *".txt" ]]; then
            input_notas="${input_notas}/notas_dev.txt"
        fi
    fi

    # Crea el archivo si no existe
    if [ ! -f "$input_notas" ]; then
        touch "$input_notas"
        echo -e "\e[32m✔️  Archivo creado en: $input_notas\e[0m"
        sleep 1
    fi
    echo ""

    # 6. Guardar todo
    CONFIG_FILE="$HOME/.dotfiles/user_config.sh"
    echo "# ==============================================================================" > "$CONFIG_FILE"
    echo "# user_config.sh - Panel de Control (Generado por el Asistente)" >> "$CONFIG_FILE"
    echo "# ==============================================================================" >> "$CONFIG_FILE"
    echo "export USER_NAME=\"$input_name\"" >> "$CONFIG_FILE"
    echo "export DASHBOARD_TITLE=\"$input_title\"" >> "$CONFIG_FILE"
    echo "export WEATHER_CITY=\"$input_city\"" >> "$CONFIG_FILE"
    echo "export LEARNING_PATH=\"$input_path\"" >> "$CONFIG_FILE"
    echo "export NOTES_FILE=\"$input_notas\"" >> "$CONFIG_FILE"

    echo -e "\e[32m✔️ ¡Configuración guardada con éxito!\e[0m"
    sleep 1
    source ~/.bashrc
}
# ==========================================
# Editor de Logo ASCII
# ==========================================
mi-logo() { 
    clear
    echo -e "\e[33m=== EDITOR DE LOGO ASCII ===\e[0m"
    echo "Pegá tu arte ASCII en la siguiente pantalla."
    echo ""
    echo "Cuando termines, presiona:"
    echo "1. Ctrl + O (luego Enter para guardar)"
    echo "2. Ctrl + X (para salir)"
    echo ""
    
    # Pausa interactiva inteligente
    echo -e "\e[5mPresiona cualquier tecla para abrir el editor...\e[0m"
    read -n 1 -s -r
    
    nano ~/.dotfiles/custom_logo.txt
    source ~/.bashrc
}

# ==========================================
# SISTEMA DE NOTAS (BACKLOG)
# ==========================================
nota() {
    if [ -z "$1" ]; then
        echo -e "\e[31m❌ Error: Debes escribir el texto de la nota.\e[0m"
    else
        # 1. Creamos la carpeta padre por si no existe
        mkdir -p "$(dirname "$NOTES_FILE")"
        
        # 2. USAMOS COMILLAS en "$NOTES_FILE" para soportar espacios como 'VS code'
        echo "- $(date '+%Y-%m-%d %H:%M'): $@" >> "$NOTES_FILE"
        echo -e "\e[32m✔️  Nota guardada exitosamente en su archivo.\e[0m"
    fi
}

misnotas() {
    if [ -f "$NOTES_FILE" ]; then
        echo -e "\e[33m========== BACKLOG DE TAREAS ==========\e[0m"
        cat "$NOTES_FILE"
        echo -e "\e[33m=======================================\e[0m"
    else
        echo -e "\e[33mNo hay notas pendientes.\e[0m"
    fi
}

# ==========================================
# UTILIDADES DEL SISTEMA Y NAVEGACIÓN
# ==========================================

# Navegar al espacio de trabajo (Workspace)
workspace() {
    if [ -d "$LEARNING_PATH" ]; then
        cd "$LEARNING_PATH" || return
    else
        echo -e "\e[31m❌ Error: La ruta de proyectos no existe o no está configurada.\e[0m"
        echo -e "\e[90mUsa 'configurar-entorno' para arreglarlo.\e[0m"
    fi
}

# Editar o recargar la configuración de Bash
bashconfig() {
    if [ "$1" == "-r" ]; then
        source ~/.bashrc
        echo -e "\e[32m✔️  Configuración recargada exitosamente.\e[0m"
    else
        nano ~/.bashrc
    fi
}

# Crear carpeta y entrar en ella
mkcd() {
    mkdir -p "$1" && cd "$1" || return
}

# Matar procesos en puertos específicos (Versión Git Bash / Windows)
killport() {
    if [ -z "$1" ]; then
        echo "Uso: killport [puerto]"
    else
        echo "Buscando procesos en el puerto $1..."
        # Busca el PID del proceso en ese puerto y lo mata
        pid=$(netstat -ano | grep ":$1" | grep "LISTENING" | awk '{print $5}' | head -n 1)
        if [ -n "$pid" ]; then
            taskkill //F //PID "$pid"
            echo -e "\e[32m✔️  Puerto $1 liberado (PID $pid).\e[0m"
        else
            echo -e "\e[31m❌ No se encontró ningún proceso en el puerto $1.\e[0m"
        fi
    fi
}