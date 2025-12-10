# Script de Obtención de Información del Sistema

## Descripción

Script en Bash que recopila y presenta información esencial del sistema operativo en un formato consolidado. Integra la dirección MAC, sistema operativo, nombre del equipo e identificación del usuario actual en un único mensaje de salida.

## Características

- ✓ Obtención de la dirección MAC del equipo
- ✓ Detección automática del sistema operativo
- ✓ Identificación del nombre del equipo (hostname)
- ✓ Determinación del usuario ejecutante
- ✓ Salida unificada en formato de línea única
- ✓ Compatibilidad con sistemas Linux y Windows (MSYS / Git Bash)

## Requisitos Previos

### Entorno de ejecución
- **Bash** (Linux nativo o Git Bash / MSYS en Windows)

### Dependencias por plataforma
- **Linux**: Comando `ip` (incluido en la mayoría de distribuciones)
- **Windows**: Comando `getmac.exe` (incluido por defecto en el sistema)

## Estructura del Proyecto

```
Apartado 2/
├── script.sh          # Script Bash ejecutable
└── README.md          # Documentación del proyecto
```

## Instalación y Configuración

### 1. Posicionarse en el directorio del proyecto
```bash
cd "Apartado 2"
```

### 2. Conceder permisos de ejecución (solo en sistemas Linux)
```bash
chmod +x script.sh
```
> **Nota**: En Git Bash bajo Windows, este paso generalmente no es necesario.

## Uso

### Ejecución básica
Desde el directorio del proyecto, ejecutar:

```bash
./script.sh
```

### Salida esperada
El script mostrará un único mensaje consolidado con toda la información del sistema:

```
MAC: XX-XX-XX-XX-XX-XX | Sistema Operativo: MINGW64_NT | Equipo: LAPTOP-BH0U09H3 | Usuario: Rodri
```

## Funcionamiento Técnico

El script implementa la siguiente lógica de recopilación:

1. **Dirección MAC**: 
   - Detecta automáticamente la disponibilidad del comando `ip`
   - Ejecuta `ip link` en sistemas Linux
   - Ejecuta `getmac.exe` en entornos Windows (MSYS / Git Bash)

2. **Sistema Operativo**: Utiliza `uname` para determinar la plataforma

3. **Nombre del Equipo**: Obtiene mediante el comando `hostname`

4. **Usuario Actual**: Identifica mediante `whoami`

5. **Consolidación**: Presenta toda la información en una única línea de salida

## Consideraciones de Uso

- Ejecutar el script desde un entorno Bash compatible (Linux nativo o Git Bash)
- En sistemas Linux, verificar que el script posee permisos de ejecución
- Asegurar disponibilidad de los comandos especificados según la plataforma

## Información del Proyecto

| Propiedad | Valor |
|-----------|-------|
| **Autor** | Rodrigo Mansergas Ferrandis |
| **Asignatura** | Puesta en Producción Segura |
| **Centro** | IES CAMINAS |