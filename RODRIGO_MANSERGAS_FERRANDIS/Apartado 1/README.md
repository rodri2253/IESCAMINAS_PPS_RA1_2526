# Generador de hashes con menú

Aplicación en Python para generar hashes de cadenas de texto mediante un menú interactivo. Soporta los algoritmos `md5`, `sha1` y `sha256` y cuenta con pruebas unitarias para facilitar la verificación del funcionamiento.

## Características

- Generación de hashes para mensajes de texto.
- Selección interactiva del algoritmo (`md5`, `sha1`, `sha256`).
- Pruebas unitarias con `pytest`.

## Requisitos

- Python 3.8 o superior
- `pip` (opcional, para instalar dependencias de desarrollo como `pytest`)

## Estructura del proyecto

Apartado 1/
- `Hasheador.py` — Programa principal (interactivo).
- `tests/` — Pruebas unitarias.
  - `test_hasheador.py` — Casos de prueba para la aplicación.
- `README.md` — Este documento.

## Instalación

1. Sitúate en la carpeta del proyecto:

```bash
cd "Apartado 1"
```

2. (Opcional) Instala `pytest` para ejecutar los tests:

```bash
pip install pytest
```

Si no puedes usar `pip` en tu entorno, en sistemas Debian/Ubuntu puedes instalar el paquete del sistema:

```bash
sudo apt install python3-pytest
```

## Uso

Ejecuta el programa desde la carpeta `Apartado 1`:

```bash
python Hasheador.py
# o, si corresponde en tu sistema:
python3 Hasheador.py
```

El programa solicita un mensaje y luego permite elegir el algoritmo de hash:

- 0 — `md5`
- 1 — `sha1`
- 2 — `sha256`

Ejemplo de interacción:

```
=== Generador de Hash ===
Introduce el mensaje a hashear:
hola mundo

Selecciona el algoritmo de hash:
0 - md5
1 - sha1
2 - sha256
Opción (0-2): 2

Hash (sha256): 0b894166d3336435c800bea36ff21b29eaa801a52f584c006c49289a0dcf6e2f

¿Qué quieres hacer ahora?
0 - Hashear otro mensaje
1 - Salir
```

Al salir, el programa muestra un mensaje de despedida.

## Pruebas

Para ejecutar las pruebas unitarias desde la carpeta `Apartado 1`:

```bash
pytest
# para salida más detallada:
pytest -v
```

## Buenas prácticas

- Asegúrate de ejecutar el script con la versión de Python adecuada (`python` o `python3`).

---

Autor: Rodrigo Mansergas Ferrandis
Asignatura: Puesta en Producción Segura