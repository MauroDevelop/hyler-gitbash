# ==============================================================================
# user_config.example.sh - Plantilla de Configuración de Hyler GitBash
# 
# INSTRUCCIONES: 
# Haz una copia de este archivo, renómbralo a 'user_config.sh' 
# y personaliza los valores con tu propia información.
# ==============================================================================

# --- PERFIL DEL USUARIO ---
# El nombre que se mostrará en el prompt y bienvenida
export USER_NAME="Developer"

# Ruta donde se guardan tus proyectos de estudio/trabajo
# Recomendación: Usa $HOME para apuntar a tu carpeta de usuario
export LEARNING_PATH="$HOME/Documents/Proyectos"

# --- APARIENCIA DEL DASHBOARD ---
# Prioridad 1: Arte ASCII (Opciones: default, alien-cat, miku, skull, hacker, etc.)
export HYLER_LOGO="default"

# Prioridad 2: Color del arte ASCII (cyan, green, red, yellow, blue, magenta, white)
export HYLER_COLOR="cyan"

# Prioridad 3: Título de texto (Se usa si HYLER_LOGO está vacío)
export DASHBOARD_TITLE="MI ENTORNO DEV"

# --- INTEGRACIONES Y UTILIDADES ---
# Ciudad para el reporte del clima (usa '+' para espacios, ej: Buenos+Aires)
export WEATHER_CITY="Buenos+Aires"

# Ubicación del archivo de notas (Se recomienda dejarlo dentro de .dotfiles)
export NOTES_FILE="$HOME/.dotfiles/notas_dev.txt"

# --- ENTORNO DE DESARROLLO (SOLO COLABORADORES) ---
# Esta ruta se configura automáticamente ejecutando el comando 'dev-repo'
export HYLER_REPO_PATH=""