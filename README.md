# pack - Python pyckaging

El siguiente paquete ha sido construido - multi

## Estructura del directorio

La estructura del directorio debe de ser la siguiente

```bash
Directorio padre: incluye los ficheros para poder construir el paquete binario whl y los que se generaran despues automaticamente.
    pyproject.toml
    README.md
    - Directorio hijo: con el codigo que se ejecuta al lanzar el paquete en CLI
    main.py
    __init__.py
```
Los directorios padre e hijo por lo general tienen el mismo nombre
El fichero `__init__.py`puede estar vacio o importar el metodo main() del fichero main.py

## Construccion del paquete

Para tratar con los campos de metadata hay que emplear o pyproject.toml o setup.py. En nuestro caso pyproject.toml

Fichero `pyproject.toml` que puede tener las tablas [project], [build-system] and [tool]

```bash
[project]
name = "multi"
version = "0.1"
description = "A simple multiplication tool"
requires-python = ">= 3.10"

[project.scripts]
multi = "paquete_minimo.main:main"

[build-system]
requires = ["setuptools"]
build-backend = "setuptools.build_meta"

```

Despues de tener el fichero de configuracion, hay que crear el binario (en nuestro caso el .whl) que contiene los ficheros necesarios para ser copiados al instalar el package.
El whl. se obtiene de la siguiente manera.

```bash
python -m pip install build
python -m build --wheel
```
Esto creara automaticamente solo el archivo .whl (y no el source distribution tar.gz) en el archivo `dist` que se creara automaticamente.
Tambien se puede especificar otro lugar para el .whl con la option `build -o /destination`.
A continuacion lo ultimo que habria que realizar es instalar el paquete.
```bash
pip install /dist/* || pip install --force-reinstall dist/* (si ya hay una version del paquete disponible y hay una update)
```

Para testearlo se puede crear un virtualenv en python y ejecutarlo alli.

## IMPORTANTE
En el archivo de configuracion, debemos indicar bien la ruta del ejecutable hasta nuestro codigo.
```bash
multi = paquete_minimo.main:main
```


## TODO: Explain Dockerfile and solve pip sudo user.
