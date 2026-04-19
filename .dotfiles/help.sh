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
        echo "  workspace  -> Entorno de proyectos (Workspace)"
        echo "  mkcd [dir] -> Crear y entrar a directorio"
        echo "  killport   -> Liberar puerto (Ej: 3000)"
        echo -e "\e[32m[ UTILIDADES & CONFIGURACIÓN ]\e[0m"
        echo "  nota [txt] -> Guardar nota rápida"
        echo "  misnotas   -> Ver backlog de tareas"
        echo "  bashconfig [-r] -> Editar/recargar .bashrc"
        echo "  mi-config  -> Ver configuración actual"
        echo "  configurar-entorno -> Personalizar la terminal"
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
        echo -e "  \e[36mworkspace\e[0m        : Navega directamente a tu carpeta de proyectos."
        echo -e "  \e[36mmkcd [dir]\e[0m : Crea una carpeta y entra en ella al instante. Uso: \e[90mmkcd nueva_api\e[0m"
        echo -e "  \e[36mkillport\e[0m   : Libera un puerto trabado. Uso: \e[90mkillport 3000\e[0m"
        
        echo -e "\n\e[32m[ UTILIDADES & CONFIGURACIÓN ]\e[0m"
        echo -e "  \e[36mnota [txt]\e[0m : Guarda una nota con fecha en tu backlog. Uso: \e[90mnota \"Revisar router\"\e[0m"
        echo -e "  \e[36mmisnotas\e[0m   : Imprime todo el historial de notas pendientes."
        echo -e "  \e[36mbashconfig\e[0m : Abre el editor. Usa 'bashconfig -r' para recargar."
        echo -e "  \e[36mmi-config\e[0m  : Muestra tus variables actuales (nombre, título, ciudad, rutas)."
        echo -e "  \e[36mconfigurar-entorno\e[0m : Abre el asistente interactivo para personalizar tu terminal."
        
        echo -e "\e[33m====================================================\e[0m"
        
    # 3. Si se pasa un argumento inválido, lanza el error
    else
        echo -e "\e[31m❌ Error: Opción '$1' no reconocida.\e[0m"
        echo -e "Usa \e[36mcomandos\e[0m para la vista rápida o \e[36mcomandos -h\e[0m para ayuda detallada."
    fi
}