# MerkleChain – Smart Contract con Árboles de Merkle

## Descripción General

Proyecto en Solidity que implementa un Smart Contract privado que actúa como el inicio de una cadena de bloques basada en árboles de Merkle (Merkle Trees). El contrato permite almacenar raíces de Merkle, añadir nuevos eslabones mediante nuevas raíces, y verificar pruebas de inclusión criptográfica. Las operaciones de modificación se encuentran restringidas únicamente al propietario del contrato mediante control de acceso granular.

El proyecto se desarrolla, compila y prueba utilizando Hardhat, proporcionando un entorno completo para desarrollo y validación en Solidity.

## Características Principales

- ✓ Smart Contract privado con control de acceso basado en propietario (owner)
- ✓ Inicialización de cadena con raíz de Merkle inicial configurable
- ✓ Adición de nuevos bloques mediante raíces de Merkle progresivas
- ✓ Almacenamiento encadenado de raíces (estructura prevRoot)
- ✓ Verificación determinista de pruebas Merkle de inclusión
- ✓ Suite de pruebas automatizadas (Hardhat + Chai)
- ✓ Compatible con Solidity ≥ 0.8.19

## Requisitos Previos

| Componente | Versión Mínima | Descripción |
|------------|----------------|-------------|
| **Node.js** | 18.x | Entorno de ejecución JavaScript (recomendado) |
| **npm** | 8.x+ | Gestor de paquetes de Node.js |
| **Solidity** | 0.8.19+ | Lenguaje de Smart Contracts |
| **Hardhat** | - | Framework para desarrollo de contratos |
| **Git** | - | Sistema de control de versiones (opcional) |

## Estructura del Proyecto

```
Apartado 4/
├── MerkleChain.sol              # Smart Contract principal (lógica core)
├── scripts/
│   └── deploy.js                # Script de despliegue automatizado
├── tests/
│   └── MerkleChain.tests.js      # Suite de pruebas unitarias
├── hardhat.config.js            # Configuración del entorno Hardhat
├── package.json                 # Dependencias y metadatos del proyecto
└── README.md                    # Documentación completa (este archivo)
```

Instalación

Sitúate en la carpeta del proyecto:

cd "Apartado 4"

Instala Hardhat y las dependencias necesarias:

npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox

Inicializa Hardhat (si procede):

npx hardhat


Selecciona la opción “Create a basic sample project”.

Compilación

Compila el Smart Contract con:

npx hardhat compile


Si la compilación es correcta, Hardhat generará los artefactos del contrato en la carpeta artifacts/.

## Funcionalidades del Smart Contract

### 1. Inicialización de la Cadena

#### Función: `initialize(bytes32 root)`

**Descripción**: Inicializa la cadena de Merkle con una raíz inicial única.

**Comportamiento**:
- Establece la raíz de Merkle inicial como primer bloque
- Genera el registro temporal del primer eslabón
- Restringe la ejecución exclusivamente al propietario del contrato

**Restricciones**: Solo puede ser ejecutada una única vez.

### 2. Añadir Nuevos Bloques

#### Función: `append(bytes32 newRoot)`

**Descripción**: Añade una nueva raíz de Merkle a la cadena existente.

**Comportamiento**:
- Encadena la nueva raíz con la raíz anterior (prevRoot)
- Incrementa el índice de la cadena progresivamente
- Registra la marca de tiempo del nuevo bloque
- Restringe la ejecución al propietario del contrato

### 3. Consultar Bloques de la Cadena

#### Función: `getEntry(uint256 index)` (Lectura)

**Descripción**: Recupera el registro de un bloque específico en la cadena.

**Retorna**:
- `root`: Raíz de Merkle del bloque solicitado
- `prevRoot`: Raíz de Merkle del bloque anterior
- `timestamp`: Marca temporal de creación del bloque
- `index`: Índice secuencial del bloque

#### Función: `getLastRoot()` (Lectura)

**Descripción**: Obtiene la raíz de Merkle del último bloque añadido a la cadena.

### 4. Verificación de Pruebas Merkle

#### Función: `verifyProof(bytes32 leaf, bytes32[] proof, bytes32 root)` (Lectura)

**Descripción**: Verifica si una hoja pertenece a un árbol de Merkle dado.

#### Función: `verifyInBlock(bytes32 leaf, bytes32[] proof, uint256 blockIndex)` (Lectura)

**Descripción**: Verifica la inclusión de una hoja en un bloque específico de la cadena.

#### Convención de Orden Determinista

El contrato implementa un protocolo de concatenación determinista:
- Los nodos se concatenan como `menor || mayor` antes de aplicar hash
- Se utiliza `keccak256` como función de hash criptográfica
- **Importante**: Las pruebas generadas deben seguir esta misma convención

## Pruebas Unitarias

### Cobertura de Pruebas

La suite de pruebas incluye validación de:
- Construcción correcta de árboles de Merkle simples
- Inicialización de la cadena con raíces válidas
- Verificación acertada de inclusión de hojas mediante pruebas Merkle
- Manejo de errores y casos edge

### Ejecutar las Pruebas

```bash
npx hardhat test
```

**Resultado esperado**: Hardhat mostrará el estado de ejecución de todos los tests. Una ejecución exitosa indica que todos los tests se han superado sin errores.

## Despliegue del Contrato

### Despliegue en Red Local

#### Paso 1: Iniciar Nodo Local (Opcional)
```bash
npx hardhat node
```

#### Paso 2: Desplegar el Contrato
```bash
npx hardhat run scripts/deploy.js --network localhost
```

**Resultado esperado**: El script mostrará por consola la dirección del contrato desplegado y su status de transacción.

### Despliegue en Redes Públicas

Para desplegar en redes públicas (mainnet, testnet), configure las claves privadas en `hardhat.config.js` siguiendo las buenas prácticas de seguridad.

## Consideraciones de Seguridad y Buenas Prácticas

### Recomendaciones Operacionales

1. **Generación de Pruebas Merkle**: Asegurar que las pruebas se generen siguiendo la misma convención de orden determinista del contrato
2. **Inicialización Única**: La función `initialize()` solo puede ejecutarse una única vez; diseñar cuidadosamente la raíz inicial
3. **Protección de Claves**: Las claves privadas del propietario deben protegerse adecuadamente, especialmente en despliegues de redes públicas
4. **Validación Previa**: Ejecutar la suite de pruebas completa antes de cualquier despliegue
5. **Auditoría de Contrato**: En producción, considerar auditoría externa de seguridad

## Evidencia de Aprendizaje Solidity

### Tutorial Completado: Solidity - Beginner to Intermediate Smart Contracts

Se adjunta evidencia de la realización completa del tutorial **Solidity: Beginner to Intermediate Smart Contracts** de la práctica de Aules **ACT_RA1_4: Solidity + GIT**.

#### Captura de Pantalla de Resultados

![Solidity Tutorial - Resultados](Imagenes/zombie.png)

**Validación de Autenticidad**:
- ✓ La captura de pantalla ha sido obtenida personalmente tras completar el tutorial
- ✓ No se ha utilizado material externo ni imágenes de terceros
- ✓ La imagen documenta los resultados y logros alcanzados en el tutorial interactivo
- ✓ Se evidencia el progreso en conceptos de Solidity y desarrollo de Smart Contracts

### Competencias Demostradas

A través de la realización del tutorial y este Smart Contract se han consolidado:

- ✓ Comprensión de Solidity y sintaxis de Smart Contracts
- ✓ Implementación de lógica criptográfica (árboles de Merkle)
- ✓ Control de acceso y gestión de permisos en contratos
- ✓ Testing y validación de Smart Contracts
- ✓ Despliegue y gestión de contratos en redes blockchain

## Licencia

Este proyecto se distribuye bajo la **Licencia MIT**.

## Información del Proyecto

| Propiedad | Valor |
|-----------|-------|
| **Autor** | Rodrigo Mansergas Ferrandis |
| **Asignatura** | Puesta en Producción Segura |
| **Centro** | IES CAMINAS |
| **Versión Solidity** | ≥ 0.8.19 |