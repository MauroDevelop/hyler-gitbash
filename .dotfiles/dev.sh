# ==========================================
# MÓDULO DE DESARROLLO HYLER (DEV ONLY)
# ==========================================

# 1. Menú de Ayuda para Desarrolladores
dev-help() {
    echo -e "\e[35m==========  COMANDOS DE DESARROLLO ==========\e[0m"
    echo -e " \e[36mdev-sync\e[0m   : Sincroniza tu entorno activo a la carpeta del repositorio."
    echo -e " \e[36mdev-audit\e[0m  : Ejecuta tests para verificar que ningún comando esté roto."
    echo -e " \e[36mdev-repo\e[0m   : Vincula esta instalación con el repositorio oficial para crear PRs."
    echo -e " \e[36mdev-help\e[0m   : Muestra este menú."
    echo -e "\e[35m================================================\e[0m"
}

# 2. Herramienta de Sincronización Automática (Dinámica)
dev-sync() {
    clear
    echo -e "\e[33m🔄 INICIANDO SINCRONIZACIÓN AL REPOSITORIO...\e[0m"
    
    # Verificamos si la ruta está configurada
    if [ -z "$HYLER_REPO_PATH" ] || [ ! -d "$HYLER_REPO_PATH" ]; then
        echo -e "\e[31m❌ Error: No has configurado la ruta del repositorio.\e[0m"
        echo -e "\e[90mEjecuta 'dev-repo' primero para vincular tu carpeta.\e[0m"
        return 1
    fi

    REPO_DIR="$HYLER_REPO_PATH"
    LIVE_DIR="$HOME/.dotfiles"

    echo -e "\e[90mCopiando archivos núcleo a: $REPO_DIR\e[0m"

    # Copiar Loaders (¡Ahora sí atrapamos el bashrc!)
    cp "$HOME/.bashrc" "$REPO_DIR/.bashrc"
    cp "$HOME/.bash_profile" "$REPO_DIR/.bash_profile"
    echo -e "\e[32m✔️  Actualizado:\e[0m .bashrc y .bash_profile"


    # LÓGICA DE COPIA DINÁMICA
    echo -e "\n\e[90mEscaneando y copiando módulos del motor...\e[0m"
    
    # Busca todos los archivos .sh en la carpeta
    for archivo in "$LIVE_DIR"/*.sh; do
        # Extrae solo el nombre del archivo (ej: dev.sh)
        nombre_base=$(basename "$archivo")
        
        # Filtro de seguridad: EXCLUIR configuraciones personales
        if [[ "$nombre_base" != "user_config.sh" && "$nombre_base" != "notas_dev.txt" ]]; then
            cp "$archivo" "$REPO_DIR/.dotfiles/$nombre_base"
            echo -e "\e[32m✔️  Actualizado:\e[0m $nombre_base"
        fi
    done

    # Lógica de copia recursiva para directorios
    echo -e "\n\e[90mCopiando directorios de recursos...\e[0m"
    if [ -d "$LIVE_DIR/logos" ]; then
        cp -R "$LIVE_DIR/logos" "$REPO_DIR/.dotfiles/"
        echo -e "\e[32m✔️  Directorio sincronizado:\e[0m logos/"
    fi

    echo -e "\n\e[32m✨ ¡Sincronización completada!\e[0m"
    echo -e "\e[90mVe a tu carpeta del repo y ejecuta git status.\e[0m"
}

# 3. Herramienta para Colaboradores (El Vinculador)
dev-repo() {
    clear
    echo -e "\e[35m========== 🔧 CONFIGURACIÓN DEL REPOSITORIO ==========\e[0m"
    echo "Para poder sincronizar tus cambios, primero debes haber"
    echo "clonado el repositorio oficial en alguna carpeta de tu PC."
    echo ""
    
    # Pedimos la ruta
    read -p "👉 Arrastra aquí la carpeta del repo clonado (o escribe la ruta): " RUTA_INPUT
    
    # Limpiamos las comillas que Windows suele agregar al arrastrar carpetas
    RUTA_LIMPIA=$(echo "$RUTA_INPUT" | sed "s/'//g" | sed 's/"//g')

    if [ -d "$RUTA_LIMPIA/.git" ]; then
        # Si es un repo válido, lo guardamos en user_config.sh
        local CONFIG_FILE="$HOME/.dotfiles/user_config.sh"
        
        # Borramos la ruta vieja si existe
        sed -i '/HYLER_REPO_PATH=/d' "$CONFIG_FILE"
        # Guardamos la nueva
        echo "export HYLER_REPO_PATH=\"$RUTA_LIMPIA\"" >> "$CONFIG_FILE"
        # La cargamos en memoria
        export HYLER_REPO_PATH="$RUTA_LIMPIA"
        
        echo -e "\n\e[32m✨ ¡Repositorio vinculado exitosamente!\e[0m"
        echo -e "\e[90mRuta guardada: $HYLER_REPO_PATH\e[0m"
        echo -e "Ahora puedes usar \e[36mdev-sync\e[0m cuando quieras extraer tus cambios."
    else
        echo -e "\n\e[31m❌ Error: La ruta no parece ser un repositorio Git válido.\e[0m"
        echo -e "\e[90mAsegúrate de apuntar a la carpeta raíz de hyler-gitbash.\e[0m"
    fi
}

# 4. Herramienta de Auditoría
dev-audit() {
    clear
    echo -e "\e[33mINICIANDO AUDITORÍA DE HYLER GITBASH...\e[0m"
    
    TEST_DIR="$HOME/hyler_tests_$(date +%s)"
    mkdir -p "$TEST_DIR" && cd "$TEST_DIR" || exit

    comandos_core=(
        "c" "ll" "mi-ip" ".." 
        "dev" "gs" "ga" "gc" "gl" 
        "workspace" "mkcd" "killport" 
        "nota" "misnotas" 
        "bashconfig" "br" "mi-config" "configurar-entorno" "mi-logo" 
        "dev-sync" "dev-audit" "dev-repo" "dev-help"
    )
    
    fallos=0
    exitos=0

    echo -e "\n\e[36m========== REPORTE DE INTEGRIDAD ==========\e[0m"
    
    for cmd in "${comandos_core[@]}"; do
        if type "$cmd" >/dev/null 2>&1; then
            if [[ "$cmd" == "nota" && ! -f "$NOTES_FILE" ]]; then
                echo -e "\e[33m[WARN] ⚠️  $cmd (Existe, pero archivo inaccesible)\e[0m"
            else
                echo -e "\e[32m[OK] ✔️  $cmd\e[0m"
                ((exitos++))
            fi
        else
            echo -e "\e[31m[FAIL] ❌ $cmd (Roto)\e[0m"
            ((fallos++))
        fi
    done

    echo -e "\e[36m===========================================\e[0m"
    echo -e "Resultados: \e[32m$exitos funcionales\e[0m | \e[31m$fallos rotos\e[0m"
    
    cd - > /dev/null
    rm -rf "$TEST_DIR"
}