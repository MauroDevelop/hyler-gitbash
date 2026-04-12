# ==============================================================================
# .bashrc - Mauro Develop
# ==============================================================================

# --- 1. CUSTOM PROMPT (PS1) ---
# Prompt multilinea limpio y a prueba de fallos. 
export PS1="\[\e[35m\]\u \[\e[90m\]en \[\e[32m\]\w\n\[\e[36m\]>\[\e[0m\] "


# --- 2. DASHBOARD ---
# Pantalla de bienvenida con información relevante del entorno
dashboard() {
    clear
    echo -e "\e[36m"
    cat << "EOF"
███╗   ███╗ █████╗ ██╗   ██╗██████╗  ██████╗ 
████╗ ████║██╔══██╗██║   ██║██╔══██╗██╔═══██╗
██╔████╔██║███████║██║   ██║██████╔╝██║   ██║
██║╚██╔╝██║██╔══██║██║   ██║██╔══██╗██║   ██║
██║ ╚═╝ ██║██║  ██║╚██████╔╝██║  ██║╚██████╔╝
╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ 
                                             
██████╗ ███████╗██╗   ██╗███████╗██╗      ██████╗ ██████╗ 
██╔══██╗██╔════╝██║   ██║██╔════╝██║     ██╔═══██╗██╔══██╗
██║  ██║█████╗  ██║   ██║█████╗  ██║     ██║   ██║██████╔╝
██║  ██║██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║     ██║   ██║██╔═══╝ 
██████╔╝███████╗ ╚████╔╝ ███████╗███████╗╚██████╔╝██║     
╚═════╝ ╚══════╝  ╚═══╝  ╚══════╝╚══════╝ ╚═════╝ ╚═╝     
EOF
    echo -e "\e[0m"

    echo -e "\e[33m📅 Fecha:\e[0m $(date '+%A, %d de %B de %Y - %H:%M')"
    echo -e "\e[34m⛅ Clima:\e[0m $(curl -s "wttr.in/Mendoza?format=3" || echo "Servicio no disponible")"
    echo -e "\e[32m🟢 Node:\e[0m $(node -v 2>/dev/null || echo 'No instalado o no agregado al PATH')"
    echo -e "\e[90m📍 Ubicación actual:\e[0m $(pwd)"

    # Muestra la última tarea pendiente si el archivo existe
    if [ -f "$HOME/Documents/notas_dev.txt" ]; then
        echo -ne "\e[35m📝 Pendiente:\e[0m "
        tail -n 1 "$HOME/Documents/notas_dev.txt"
    fi

    echo "--------------------------------------------------------"
    echo "Escribe 'comandos' para ver la lista de atajos."
    echo "--------------------------------------------------------"
}

# Ejecutar el dashboard al iniciar la terminal
dashboard


# --- 3. ALIAS ---
# Navegación y sistema
alias ..='cd ..'
alias c='clear'
alias c='dashboard'
alias ll='ls -la'
alias mi-ip='ipconfig | grep -i "IPv4"'

# Git shortcuts
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gl='git log --graph --oneline --decorate --all --color'

# Desarrollo Backend
alias dev='npm run dev'


# --- 4. FUNCIONES Y UTILIDADES ---

# Crea un directorio y accede a él automáticamente
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Acceso rápido al entorno de aprendizaje (Backend Path)
api() {
    cd "$HOME/Documents/VS code/learning-path-2026"
}

# Libera un puerto específico (útil para Node/Express)
killport() {
    if [ -z "$1" ]; then
        echo -e "\e[31mError: Debes indicar el puerto. (Ej: killport 3000)\e[0m"
    else
        npx kill-port "$1"
    fi
}

# Guarda una nota rápida en el backlog
nota() {
    echo "- $(date '+%Y-%m-%d %H:%M'): $@" >> "$HOME/Documents/notas_dev.txt"
    echo -e "\e[36mNota guardada exitosamente.\e[0m"
}

# Imprime el historial completo de notas
misnotas() {
    if [ -f "$HOME/Documents/notas_dev.txt" ]; then
        echo -e "\e[33m--- BACKLOG DE TAREAS ---\e[0m"
        cat "$HOME/Documents/notas_dev.txt"
    else
        echo "No hay notas pendientes."
    fi
}

# Edita y recarga la configuración actual
bashconfig() {
    nano ~/.bashrc
    source ~/.bashrc
}


# --- 5. MENÚ DE AYUDA ---
comandos() {
    echo -e "\e[33m========== REFERENCIA DE ATAJOS ==========\e[0m"
    echo -e "\e[32m[ NAVEGACIÓN ]\e[0m"
    echo "  c / .. / ll / mi-ip"
    echo -e "\e[32m[ GIT & NODE ]\e[0m"
    echo "  dev / gs / ga / gc / gl"
    echo -e "\e[32m[ PROYECTOS ]\e[0m"
    echo "  api        -> Entorno Learning Path 2026"
    echo "  mkcd [dir] -> Crear y entrar a directorio"
    echo "  killport   -> Liberar puerto (Ej: 3000)"
    echo -e "\e[32m[ UTILIDADES ]\e[0m"
    echo "  nota [txt] -> Guardar nota rápida"
    echo "  misnotas   -> Ver backlog de tareas"
    echo "  bashconfig -> Editar .bashrc"
    echo "=========================================="
}