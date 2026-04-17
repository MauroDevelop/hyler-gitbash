# ==============================================================================
# .bashrc - Mauro Develop
# ==============================================================================

# --- 1. CUSTOM PROMPT (PS1) ---
# PROMPT_COMMAND para recalcular la ruta y la rama de forma segura
set_prompt() {
    local branch=$(git branch --show-current 2>/dev/null)
    local git_info=""
    if [ -n "$branch" ]; then
        git_info=" ($branch)"
    fi
    PS1="\[\e[35m\]\u \[\e[90m\]en \[\e[32m\]\w\[\e[33m\]${git_info}\n\[\e[36m\]>\[\e[0m\] "
}
PROMPT_COMMAND=set_prompt

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
    echo -e "\e[32m🟢 Node:\e[0m $(node.exe -v 2>/dev/null || echo 'No instalado o no agregado al PATH')"
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
alias mi-ip='ipconfig | grep -a -i "IPv4"'

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

# Edita y recarga la configuración actual, o solo recarga con -r
bashconfig() {
    if [ "$1" == "-r" ]; then
        source ~/.bashrc
        echo -e "\e[32m✔️  Configuración de Git Bash recargada.\e[0m"
    else
        nano ~/.bashrc
        source ~/.bashrc
    fi
}


# --- 5. MENÚ DE AYUDA ---
comandos() {
    # 1. Si NO se pasan argumentos, muestra la vista compacta
    if [ -z "$1" ]; then
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
        echo "  bashconfig [-r] -> Editar .bashrc (-r para recargar)"
        echo "=========================================="
        echo -e "\e[90mTip: Escribe 'comandos -a' para ver información detallada.\e[0m"
        
    # 2. Si el argumento es válido, muestra la vista detallada
    elif [[ "$1" == "-a" || "$1" == "--all" || "$1" == "-h" || "$1" == "--help" ]]; then
        echo -e "\e[33m========== REFERENCIA DETALLADA DE ATAJOS ==========\e[0m"
        
        echo -e "\e[32m[ NAVEGACIÓN Y SISTEMA ]\e[0m"
        echo -e "  \e[36mc\e[0m          : Limpia la terminal y vuelve a imprimir el dashboard."
        echo -e "  \e[36m..\e[0m         : Sube un nivel en el árbol de directorios (cd ..)."
        echo -e "  \e[36mll\e[0m         : Lista todos los archivos, incluyendo ocultos, con detalles."
        echo -e "  \e[36mmi-ip\e[0m      : Filtra ipconfig y muestra solo tu dirección IPv4 local."
        
        echo -e "\n\e[32m[ GIT & NODE ]\e[0m"
        echo -e "  \e[36mdev\e[0m        : Ejecuta 'npm run dev' rápidamente."
        echo -e "  \e[36mgs\e[0m         : Muestra el estado del repositorio (git status)."
        echo -e "  \e[36mga\e[0m         : Agrega todos los cambios al stage (git add .)."
        echo -e "  \e[36mgc [msg]\e[0m   : Crea un commit. Uso: \e[90mgc \"Mi mensaje\"\e[0m"
        echo -e "  \e[36mgl\e[0m         : Muestra el historial de commits en formato gráfico y a color."
        
        echo -e "\n\e[32m[ PROYECTOS ]\e[0m"
        echo -e "  \e[36mapi\e[0m        : Navega directamente a la carpeta del Learning Path 2026."
        echo -e "  \e[36mmkcd [dir]\e[0m : Crea una carpeta y entra en ella al instante. Uso: \e[90mmkcd nueva_api\e[0m"
        echo -e "  \e[36mkillport\e[0m   : Libera un puerto trabado. Uso: \e[90mkillport 3000\e[0m"
        
        echo -e "\n\e[32m[ UTILIDADES ]\e[0m"
        echo -e "  \e[36mnota [txt]\e[0m : Guarda una nota con fecha en tu backlog. Uso: \e[90mnota \"Revisar router\"\e[0m"
        echo -e "  \e[36mmisnotas\e[0m   : Imprime todo el historial de notas pendientes."
        echo -e "  \e[36mbashconfig\e[0m : Abre el editor. Usa 'bashconfig -r' para recargar."
        
        echo -e "\e[33m====================================================\e[0m"
        
    # 3. Si se pasa un argumento inválido, lanza el error
    else
        echo -e "\e[31m❌ Error: Opción '$1' no reconocida.\e[0m"
        echo -e "Usa \e[36mcomandos\e[0m para la vista rápida o \e[36mcomandos -h\e[0m para ayuda detallada."
    fi
}