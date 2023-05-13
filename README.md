# Final Project DO 2023 - GeeksHubs
##### Este es el proyecto final del Bootcamp de DevOps de Héctor Rodríguez Fusté impartido por GeeksHbubs 
----
![GitHub release (latest by date)](https://img.shields.io/github/v/release/hectorrf16/FinalProjectDO?style=plastic)
![GitHub Lincense](https://img.shields.io/github/license/hectorrf16/FinalProjectDO?style=plastic)
![GitHub Languages Count](https://img.shields.io/github/languages/count/hectorrf16/FinalProjectDO?style=plastic)
![GitHub Issues Count](https://img.shields.io/github/issues-raw/hectorrf16/finalprojectdo?style=plastic)

# Por Hacer
- [ ] Aplicación desarrollada en Python
- [X] Sistema de Integración Continua - https://github.com/hectorrf16/FinalProjectDO
- [ ] Aplicación totalmente Contenerizada - Imagen en https://hub.docker.com/r/hectorrf16/finalprojectdo
- [ ] Orquestador de Contenedores
- [ ] Sistema Automatizado de Despliegue
- [ ] Sistema de Monitorización
- [ ] Sistema de Recogida de información de Contenedores en Grafana
- [ ] Sistema de Exposición de información de Contenedores en Grafana

# Posibles Mejoras
- [ ] Despliegue de Infra en Cloud
- [ ] Diseñar Infra y aplicar en Diagrama
- [ ] Creación y Aprovisionamiento de la Infra
- [ ] Creación de Tests de estrés
- [ ] Analisis perfomance de la Infra

# Diseño infraestructura
![Diagrama Infra](screenshots\diagrama.png)

# Memoria
## **APLICACIÓN** 

Este proyecto final va a ser el principio de una idea que tengo en mente.

La idea es tener una herramienta para mi mujer, pero que no influya de donde acceda, por lo que no quiero tener una app compilada directamente en una tecnologia (Android / iOS), que sea multiplataforma, que no tenga que pasar por ninguna store con sus procesos de aprobacion.

El problema que ha surgido, para presentar el proyecto, es la falta de tiempo... por lo que he tenido que hacer un MockUp en Python para tener "algo" que mostrar visualmente y asi desarrollar la infraestructura necesaria para el projecto, pero la idea final para mi propio proyecto, seria modificar dicho Python y portarlo a Vue.js como backend e [Ionic](https://ionicframework.com) como frontend.

La aplicacion va a ser desarrollada en docker para poder aplicarla en local, por la facilidad de creacion de contenedores, o por que ya tengo un background con docker y me es super facil de aplicar la idea sin "perder" tiempo en aprender, ya que ese tiempo me gustaria implementarlo, en por ejemplo, aprender K8s, AWS etc... que es lo nuevo que he aprendido aqui.

Tambien habra un apartado para poder implementar toda la infraestructura en cloud, por lo que al inicio podras especificar que quieres, si instalacion en local o instalacion en cloud. Tambien voy a implementar un metodo de "recuperacion" del sistema por si en un futuro hacemos una modificacion de algo y queremos hacer rollback a un estado que funcione, sin tener que voler a hacer pull del repo.

Para la instalacion en cloud, se va a implementar en Kubernete y en AWS, porque es la forma mas facil de "traducir" la infraestructura de docker y porque tenemos acceso "ilimitado" a AWS para poder levantar y tirar todas las maquinas que queramos.

Aqui teneis la estructura (arbol de carpeta) del proyecto al final de todo el proceso.

```
"FinalProjectDOQ"
├── "docker"
│   ├── "grafana"
│   │   └── "provisioning"
│   │       └── "datasources"
│   │           └── "datasource.yml"
│   ├── "docker-compose.yml"
│   ├── "app"
│   │   ├── "app.py"
│   │   ├── "views"
│   │   │   └── "home.tpl"
│   │   ├── "static"
│   │   │   ├── "css"
│   │   │   │   ├── "materialize.css"
│   │   │   │   └── "materialize.min.css"
│   │   │   └── "js"
│   │   │       ├── "materialize.min.js"
│   │   │       └── "materialize.js"
│   │   └── "requirements.txt"
│   └── "app-dockerfile"
├── "Proyecto Final Bootcamp DevOps.pdf"
├── "LICENSE"
├── "README.md"
├── "run.sh"
└── "screenshots"

10 directories, 14 files
```

## **CONTAINER**
Como no se como va a acabar el proyecto, la primera idea es de tener 4 contenedores, y si por alguna razón he de añadir mas, ya seria como complemento de alguna utilidad
- Contenedor con Python para tener una web y poder mostrar la información / datos
- Contenedor con una base de datos Postgresql para almacenar los datos a mostrar en la web
- Contenedor con PgAdmin4 para poder modificar la base de datos de forma visual a traves de una web para no tener que estar haciendo siempre queries sql (para testing o rapidos workarounds)
- Contenedor para el sistema de Monitorización en Grafana
- 
Aqui teneis imagen para mostrar un poco de informacion de como estan trabajando los contenedores
![Docker List](https://github.com/hectorrf16/FinalProjectDO/screenshots/dockerlist.png)

Para empezar la creacion de los contenedores, solo tenemos que ejecutar el `run.sh` de la raiz del repositorio, el mismo empezara a crear todo lo necesario para

## **ORQUESTADOR CONTAINERS**
## **SISTEMA DE DESPLIEGUE**
## **SISTEMA DE MONITORIZACIÓN**
## **SISTEMA DE RECOGIDA Y EXPOSICIÓN DE DATOS**

# Webgrafia
- Ayuda para elegir buena base de datos y buen frontend/backend para trabajar con Vue: https://www.reddit.com/r/vuejs/comments/j7hw6d/best_practices_for_using_databases_with_vuejs/
- 