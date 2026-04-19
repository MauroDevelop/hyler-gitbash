# ==========================================
# MÓDULO DE DESARROLLO HYLER (DEV ONLY)
# ==========================================

# 1. Herramienta de Sincronización Automática
hyler-sync() {
    clear
    echo -e "\e[33m🔄 INICIANDO SINCRONIZACIÓN AL REPOSITORIO...\e[0m"
    
    # Usamos $HOME para que no importe en qué PC estés, siempre encuentre la ruta
    REPO_DIR="$HOME/Documents/VS code/hyler-gitbash"
    LIVE_DIR="$HOME/.dotfiles"

    # Verificamos que la carpeta del repo exista
    if [ ! -d "$REPO_DIR" ]; then
        echo -e "\e[31m❌ Error: No se encontró el repositorio en:\e[0m"
        echo -e "\e[90m$REPO_DIR\e[0m"
        return 1
    fi

    echo -e "\e[90mCopiando archivos núcleo (Ignorando configuraciones personales)...\e[0m"

    # 1. Copiar Loaders (los puente)
    cp "$HOME/.bashrc" "$REPO_DIR/.bashrc"
    cp "$HOME/.bash_profile" "$REPO_DIR/.bash_profile"

    # 2. Array con los archivos exactos del motor (AQUÍ NUNCA PONGAS user_config.sh NI notas_dev.txt)
    archivos_motor=(
        "aliases.sh" 
        "dashboard.sh" 
        "help.sh" 
        "prompt.sh" 
        "utils.sh" 
        "dev.sh"
    )
    
    # 3. Bucle de copia segura
    for archivo in "${archivos_motor[@]}"; do
        if [ -f "$LIVE_DIR/$archivo" ]; then
            # Las comillas protegen las rutas con espacios como 'VS code'
            cp "$LIVE_DIR/$archivo" "$REPO_DIR/.dotfiles/$archivo"
            echo -e "\e[32m✔️  Actualizado:\e[0m $archivo"
        fi
    done

    echo -e "\n\e[32m✨ ¡Sincronización completada!\e[0m"
    echo -e "\e[90mAhora podés ir a tu repo, hacer 'git add .' y pushear la nueva versión.\e[0m"
}

# 2. Herramienta de Auditoría
auditar-entorno() {
    clear
    echo -e "\e[33mINICIANDO AUDITORÍA DE HYLER GITBASH...\e[0m"
    
    TEST_DIR="$HOME/hyler_tests_$(date +%s)"
    mkdir -p "$TEST_DIR" && cd "$TEST_DIR" || exit

    comandos_core=(
        "c" "ll" "mi-ip" ".." 
        "dev" "gs" "ga" "gc" "gl" 
        "workspace" "mkcd" "killport" 
        "nota" "misnotas" 
        "bashconfig" "br" "mi-config" "configurar-entorno" "mi-logo" "hyler-sync" "auditar-entorno"
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