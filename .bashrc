# ==============================================================================
# .bashrc - Hyler GitBash (Loader Modular)
# ==============================================================================

# Definimos dónde están guardados los módulos
export DOTFILES_DIR="$HOME/.dotfiles"

# Cargamos los archivos en orden
source "$DOTFILES_DIR/user_config.sh"
source "$DOTFILES_DIR/prompt.sh"
source "$DOTFILES_DIR/aliases.sh"
source "$DOTFILES_DIR/utils.sh"
source "$DOTFILES_DIR/help.sh"
source "$DOTFILES_DIR/dashboard.sh"
source "$DOTFILES_DIR/dev.sh"
