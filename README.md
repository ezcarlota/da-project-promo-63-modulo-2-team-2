
# 🎧 Proyecto MusicStream 

## Descripción General

Stream Music es un proyecto de análisis de datos musicales cuyo objetivo es extraer información proveniente de un archivo JSON de Spotify y una API de Last.fm para explorar el comportamiento de los oyentes, tendencias de géneros musicales, artistas y canciones. Se seleccionaron 5 géneros (flamenco, indie, reggaeton, pop y rock) y se estableció un rango de años del 2013-2015. 
Este proyecto se divide en cuatro fases principales: extracción de datos, modelado de base de datos, análisis mediante SQL y visualización de resultados.

---

## Fase 1: Extracción de Datos

En esta fase se lleva a cabo la recopilación de información desde fuentes externas:

- Archivo JSON de Spotify: Se extrae información relevante sobre artistas, canciones, géneros musicales, tipo (canción o álbum), nombre de la canción, año de lanzamiento, etc.

- API de Last.fm: Se obtiene información complementaria como biografías de artistas, popularidad y estadisticas de reproducción, artistas similares, etc.

- Almacenamiento: Los datos recopilados son procesados y almacenados en archivos CSV estructurados, que servirán como fuente para la posterior carga en la base de datos.

---

## Fase 2: Modelado de Base de Datos

Esta fase comprende la modelización y carga de los datos:

- Diseño del modelo relacional: Se definen las entidades principales (artistas, canciones, géneros, años, etc.) y sus relaciones.

- Creación de la base de datos: Implementación del modelo de manera automatico en lenguaje Python usando MySQL connector.

- Carga de datos: Inserción de los datos provenientes de los archivos CSV en las tablas correspondientes usando Python.

---

## Fase 3: Análisis de Datos (Consultas SQL)

El objetivo de esta fase fue extraer conocimiento útil a partir de los datos almacenados. Se desarrollaron diversas consultas para responder preguntas generales y específicas del comportamiento musical:

### Ejemplos de consultas:

¿Cuál es el artista más popular y a qué género pertenece?

![Texto alternativo](query2.PNG)

¿Cuántas canciones y artistas tenemos en nuestra BBDD? 

![Texto alternativo](query1.PNG)

---

## Fase 4: Presentación Visual (Demo)

La última fase consistió en una presentación visual de los resultados obtenidos, creada en unas diapositivas, donde se resumen los hallazgos más relevantes mediante un diagrama, tablas y visualizaciones de imagenes que facilitan la comprensión del análisis realizado.

---

## Tecnologías Utilizadas


![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)![Pandas](https://img.shields.io/badge/pandas-%23150458.svg?style=for-the-badge&logo=pandas&logoColor=white) ![MySQL](https://img.shields.io/badge/mysql-4479A1.svg?style=for-the-badge&logo=mysql&logoColor=white) ![Jupyter Notebook](https://img.shields.io/badge/jupyter-%23FA0F00.svg?style=for-the-badge&logo=jupyter&logoColor=white) 

![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white) ![Last.fm](https://img.shields.io/badge/last.fm-D51007?style=for-the-badge&logo=last.fm&logoColor=white)  ![Canva](https://img.shields.io/badge/Canva-%2300C4CC.svg?style=for-the-badge&logo=Canva&logoColor=white)

---

## Instrucciones de uso

1. Clona el repositorio
2. Ejecuta el archivo principal: `bbdd_musicstream.ipynb`
3. Sigue las instrucciones en el archivo para la extracción de datos, creación de los archivos CSV, para la creacióon de la BBDD y realizar las consultas a MySQL archivo CONSULTAS_MUSICSTREAM.sql.


---

## Estructura del repositorio
```
da-project-promo-54-modulo-2-team-2/

├── README.md
│ 
├── archivos_csv/
│   ├── archivos_flamenco_lastfm.csv
│   ├── artistas_indie_lastfm.csv
│   ├── artistas_pop_lastfm.csv
│   ├── archivos_reggaeton_lastfm.csv
│   ├── artistas_rock_lastfm.csv
│   ├── artistas_similares_pop.csv
│   ├── artistas_similares_rock.csv
│   ├── artistas_similares_unidos.csv
│   ├── canciones_flamenco_spotify.csv
│   ├── canciones_indie_spotify.csv
│   ├── canciones_pop_spotify.csv
│   ├── canciones_reggaeton_spotify.csv
│   └── canciones_rock_spotify.csv
│   
│ 
├── bbdd_musicstream.ipynb
│  
│ 
├── consultas_musicstream.sql


```

---

## Autoras

[Estefanía Moreno Delmo](https://github.com/fany-data)

[Rosa Carolina Sanchez](https://github.com/carolsan-5)

[Adnana](https://github.com/ADNANAIFRIM)

[Marta ](https://github.com/martalm67)

[Carlota](https://github.com/ezcarlota)


---

## Estado del proyecto

    Version beta finalizada
---

## Capturas de pantalla

![alt text](image.png)
