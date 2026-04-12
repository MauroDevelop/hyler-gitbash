# Git Bash Ricing for Windows (Mauro Develop)

¡Bienvenido a mis dotfiles! Si sos desarrollador, usás Windows y los recursos de tu PC no te dan para correr WSL sin que la máquina explote, podés utilizar Git Bash.

Este repositorio contiene mi configuración personal (.bashrc) diseñada para transformar la simple terminal por defecto de Windows en un entorno de desarrollo más bonito, ligero y con comandos nativos de Linux.

## Vista previa

![Terminal personalizada](https://i.ibb.co/KzGpH4Z9/bash-racing.png)

## Características

- **Dashboard Inicial**: Te recibe con un logo ASCII personalizado (en mi caso está mi nombre, pero puedes pedirle a tu IA que diseñe el tuyo compartiéndole la fuente), fecha, clima local, tu última nota (si has creado una) y el estado de tu instalación de Node.js.
- **Sistema de Notas (Backlog)**: Lee tu última nota pendiente apenas abrís la terminal para no perder el foco.
- **Git Branch Dinámico**: El prompt te muestra siempre en qué rama de Git estás parado (a prueba de errores).
- **Atajos Backend**: Comandos cortos para matar puertos trabados (`killport`), levantar el server (`dev`), y navegar por tus proyectos.

## Instalación (Paso a Paso)

Sigue estos pasos para aplicar esta configuración en tu propia máquina:

1. Cloná este repositorio (o descargá el ZIP) en tu computadora.

```bash
git clone https://github.com/TuUsuario/gitbash-dotfiles.git
```

2. Copiá los archivos a tu directorio raíz.  
Abre Git Bash y usa los siguientes comandos para mover los archivos ocultos a tu carpeta de usuario:

```bash
cp .bashrc ~/.bashrc
cp .bash_profile ~/.bash_profile
```

3. Recargá la terminal.  
Cerrá Git Bash y volvé a abrirlo, o ejecutá este comando para aplicar los cambios instantáneamente:

```bash
source ~/.bashrc
```

## Requisitos

Para que el Dashboard funcione correctamente, es recomendable tener instalado:

- **Node.js**: Para que la terminal pueda detectar la versión y ejecutar los alias de desarrollo.
- **Curl**: Viene por defecto en Git Bash, necesario para el widget del clima.

## Atajos Incluidos

Una vez instalado, podés escribir comandos en la terminal para ver la lista completa.

| Comando | Descripción |
|---------|-------------|
| `c` | Limpia la pantalla y recarga el dashboard visual |
| `dev` | Ejecuta `npm run dev` |
| `killport 3000` | Libera el puerto 3000 si quedó bloqueado por un proceso de Node/Express |
| `nota [texto]` | Guarda una nota rápida en tu backlog de desarrollador |
| `misnotas` | Imprime todas tus notas pendientes en pantalla |
| `api` | Te lleva directo a tu carpeta de proyectos |

## 🤝 Contribuciones

Si tenés ideas para agregar más alias útiles o mejorar el script de inicio, ¡los pull requests son bienvenidos!

---

**Codeado con ☕ por [Mauro Algañaraz](https://github.com/MauroDevelop) - Estudiante de Desarrollo de Software.**
