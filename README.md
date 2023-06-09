# Final Project Bootcamp DevOps 2023 - GeeksHubs
##### Este es el proyecto final del Bootcamp de DevOps de Héctor Rodríguez Fusté impartido por GeeksHbubs
###### <u>**Nota:** Todas las contraseñas de este repositorio han sido creadas específicamente para este proyecto, cualquier coincidencia con otros sistemas es mera casualidad.</u>
----
![GitHub release (latest by date)](https://img.shields.io/github/v/release/hectorrf16/FinalProjectDO?style=plastic)
![GitHub Lincense](https://img.shields.io/github/license/hectorrf16/FinalProjectDO?style=plastic)
![GitHub Languages Count](https://img.shields.io/github/languages/count/hectorrf16/FinalProjectDO?style=plastic)
![GitHub Opened Issues Count](https://img.shields.io/github/issues/hectorrf16/finalprojectdo?style=plastic)
![GitHub Closed Issues Count](https://img.shields.io/github/issues-closed/hectorrf16/finalprojectdo?color=g&style=plastic)

# Por Hacer
- [X] Aplicación desarrollada en Python
- [X] Sistema de Integración Continua - https://github.com/hectorrf16/FinalProjectDO
- [X] Aplicación totalmente Contenerizada - Imagen en https://hub.docker.com/r/hectorrf16/finalprojectdo
- [X] Orquestador de Contenedores
- [X] Sistema Automatizado de Despliegue con Github Actions
- [X] Sistema de Monitorización con Elastic / Kibana / FileBeat
- [X] Sistema de Recogida de información de Contenedores con Prometheus
- [X] Sistema de Exposición de información de Contenedores en Grafana

# Posibles Mejoras
- [ ] Despliegue de Infra en Cloud
- [ ] Diseñar Infra y aplicar en Diagrama
- [ ] Creación y Aprovisionamiento de la Infra
- [ ] Creación de Tests de estrés
- [ ] Analisis perfomance de la Infra

# Memoria
## **APLICACIÓN** 

Este proyecto final va a ser el principio de una idea que tengo en mente.

La idea es tener una herramienta para mi mujer, pero que no influya de donde acceda, por lo que no quiero tener una app compilada directamente en una tecnología (Android / iOS), que sea multiplataforma, que no tenga que pasar por ninguna store con sus procesos de aprobación.

El problema que ha surgido, para presentar el proyecto, es la falta de tiempo... por lo que he tenido que hacer un MockUp en Python para tener "algo" que mostrar visualmente y así desarrollar la infraestructura necesaria para el proyecto, pero la idea final para mi propio proyecto, seria modificar dicho Python y portarlo a javascript utilizando cualquier libreria tipo _vue.js_ o _react_.

El proyecto va a utilizar docker / docker compose como base para los contenedores, lo hago así porque me gustaría meterle horas a aprender con calma Kubernetes, Jenkins, Github Actions, Prometheus, Elastic, Filebeat etc, ya que docker me es familiar y no necesito tanto tiempo de investigación y desarrollo

Aquí tenéis la estructura (árbol de carpeta) del proyecto al final de todo el proceso.

```
"FinalProjectDO"
├── "docker"
│   ├── "grafana"
│   │   ├── "grafana.ini"
│   │   └── "provisioning"
│   │       ├── "datasources"
│   │       │   ├── "datasource.yml"
│   │       │   └── "dashboards"
│   │       │       ├── "prometheus_stats.json"
│   │       │       └── "home.json"
│   │       └── "dashboards.yml"
│   ├── "runs"
│   │   ├── "psrun.sh"
│   │   ├── "pgrun.sh"
│   │   └── "grafanarun.sh"
│   ├── "database"
│   │   ├── "query.sql"
│   │   ├── "pgadmin"
│   │   │   ├── "pgpass"
│   │   │   └── "servers.json"
│   │   ├── "postgresql.conf"
│   │   └── "logs"
│   ├── "docker-compose.yml"
│   ├── "kibana"
│   │   └── "kibana.yml"
│   ├── "app"
│   │   ├── "app.py"
│   │   ├── "views"
│   │   │   └── "home.tpl"
│   │   ├── "static"
│   │   │   ├── "css"
│   │   │   │   ├── "materialize.css"
│   │   │   │   └── "materialize.min.css"
│   │   │   └── "js"
│   │   │       ├── "materialize.min.js"
│   │   │       └── "materialize.js"
│   │   ├── "requirements.txt"
│   │   └── "logs"
│   ├── "filebeat"
│   │   └── "filebeat.yml"
│   ├── "prometheus"
│   │   └── "prometheus.yml"
│   └── "app-dockerfile"
├── "Proyecto Final Bootcamp DevOps.pdf"
├── "LICENSE"
├── "README.md"
├── "run.sh"
└── "screenshots"
    ├── "docker-elastic.png"
    ├── "grafanaissue1.png"
    ├── "docker-volumes.png"
    ├── "docker-filebeat.png"
    ├── "docker-grafana.png"
    ├── "runhelp.png"
    ├── "docker-app.png"
    ├── "docker-db.png"
    ├── "docker-prometheus.png"
    ├── "docker-pgadmin.png"
    ├── "docker-kibana.png"
    ├── "grafanaissue1-fix.png"
    ├── "dockerlist.png"
    └── "correctrun.png"

19 directories, 42 files
```

## **CONTAINER**
Estos son los siguientes contenedores que vamos a utilizar para poder desarrollar el proyecto, en teoría todo lo que se haga aquí lo continuare para un proyecto personal, por lo que ahora voy a tener la _estructura_ del proyecto sin contenido, para no perder tiempo y poder hace lo máximo posible. En total tenemos 8 contenedores:
- Contenedor con Python para tener una web y poder mostrar la información / datos
- Contenedor con una base de datos Postgresql para almacenar los datos a mostrar en la web
- Contenedor con PgAdmin4 para poder modificar la base de datos de forma visual a través de una web para no tener que estar haciendo siempre queries sql (para testing o rápidos workarounds)
- Contenedor para hospedar el servicio de monitorización con Prometheus
- Contenedor para mostrar la información del contenedor de monitorización en Grafana
- Contenedores para recolecta de logs con:
    -  Elastic
    -  Kibana
    -  Filebeat
----
Aquí tenéis imagen para mostrar un poco de información de como están trabajando los contenedores
![Docker List](screenshots/dockerlist.png)

Si ejecutamos el fichero `run.sh` con el comando `bash` nos mostrara la información para poder iniciar el script correctamente
![Correct Run](screenshots/correctrun.png)

Y si queremos saber como ejecutarlo de forma correcta, tan solo deberiamos de ejecutar el comando con `--help` como parametro
![Run Help](screenshots/runhelp.png)


Si por alguna razón la app no se puede ejecutar, tan solo deberiamos de darle permisos de ejecución a tu usuario sobre el script con el siguiente comando
> sudo chmod u+x ./run.sh

## **¿QUÉ HACE ESTE SCRIPT?**
Primero, decidí hacer un script de ejecución porque es bastante mas fácil implementar los testeos en un pipeline de forma automática, solo pasándole la ejecución del script + parametro en vez de ir metiendo los comandos de docker en cada ejecución, pero también para mi, por mi forma de testear, me es mas rápido escribir menos que tener que escribir todos los comandos de docker por cada intento.

Entonces, como se puede ver en el apartado `--help`, podemos pasarle dos parametros al script y de ahí se ejecutaran unas acciones.

Las opciones son las siguientes:

* 0 - Instalara todos los contenedores y añadirá / ejecutara toda la configuración de cada uno, para tenerlo en funcionamiento tal y como se quiere que estén. Esto va bien por si tenemos que recuperar contenedores, los datos base como conexiones a base de datos y o dashboards de información serán persistentes, así la recuperación sera casi instantánea
* 1 - Opción puramente de ejecución de los contenedores, solo ejecutara un `'docker compose up -d'` y levantara todas las maquinas que no estén ejecutadas en ese momento. Fácil por si se ha caído algún contenedor y no queremos "borrar" la configuración actual, por si queremos leer logs u otras comprobaciones.
* 2 - Podremos reparar un contenedor o todos especificandolo con el segundo parametro del script. La reparación consiste en borrar todo rastro del contenedor y volviéndolo a cargar, por lo que si hemos modificado algo por encima de la configuración básica, esta se borrara y el/los contenedor/es volverán a su estado base
* 3 - Desinstalación de todos los contenedores + volúmenes, por lo que esto sirve para tener una instalación limpia en tu equipo, por si los ficheros se han vuelto corruptos a causa de modificaciones por nuestra parte o porque la configuración ha fallado y no se puede levantar el contenedor
* 4 - Subida de todas las imágenes de los contenedores dentro del fichero _`docker-compose.yml`_ hacia _Docker HUB_ para su guardado por si queremos utilizar dichos contenedores en otros proyectos u otras copias. En este paso se puede utilizar otro repositorio de docker hub diferente al del CI/CD, por lo que se podría pensar que este paso es una acción de "backup"
----


## **ORQUESTADOR DE CONTAINERS**
Para este apartado vamos a utilizar _`'docker compose'`_, porque como bien he dicho antes, estoy bastante familiarizado con docker y esto no me supondrá gran problema para avanzar.

Para este proyecto, solo he creado un contenedor manual, es decir, que he hecho un solo build para un contenedor. El resto de contenedores he utilizado las propias imágenes que podemos encontrar en [_Docker Hub_](https://hub.docker.com). Esto lo he hecho así, porque realmente vamos a tener todos los componentes de los servicios cargados en los contenedores para que se inicien con su propia configuración ya hecha automáticamente y si también tenerlos siempre actualizados cada vez que los _levantamos_

La configuración del fichero es el siguiente

#### **APP**
![Docker - app](screenshots/docker-app.png)
#### **DB**
![Docker - db](screenshots/docker-db.png)
#### **PGADMIN**
![Docker - pgadmin](screenshots/docker-pgadmin.png)
#### **GRAFANA**
![Docker - grafana](screenshots/docker-grafana.png)
#### **PROMETHEUS**
![Docker - prometheus](screenshots/docker-prometheus.png)
#### **ELASTIC**
![Docker - elastic](screenshots/docker-elastic.png)
#### **KIBANA**
![Docker - kibana](screenshots/docker-kibana.png)
#### **FILEBEAT**
![Docker - filebeat](screenshots/docker-filebeat.png)
#### **DOCKER VOLUMES FOR DATA**
![Docker - volumes](screenshots/docker-volumes.png)

----
## **SISTEMA DE DESPLIEGUE**
Antes de empezar a intentar implementar esta sección, tenia pensado utilizar jenkins, ya que me era conocido, pero no lo había utilizado tanto hasta ahora.. que al ver como costaba implementarlo y lo difícil que era de replicar la misma configuración de forma automática sin "hardcodear" todo... decidí retirarlo e utilizar Github Actions, que era mas fácil y no dependía de tener que configurar/montar/lanzar algo.

En este apartado no hay mucho que explicar, solo se aplican varios comandos de testing para que cada vez que se aplique algo en main sea verificado utilizando los pull requests. También, como paso final habrá una subida al repositorio de _Docker Hub_.

El workflow se va a separar en dos, serán los mismo pero con la diferencia que en _main_ se hará la subida a _Docker Hub_ y en _stg_ no, porque se entiende que no ha pasado aun la comprobación para producción.

----
## **SISTEMA DE MONITORIZACIÓN**
En este caso, hemos instalado la suite de Elastic / Kibana / Filebeat para la recolección de logs. Es simplemente un lugar para centralizar todos los logs que nos interesen y no tener que estar entrando en cada contenedor para ver que ocurre.

Su configuración es bastante simple, solo hemos añadido los logs de la base de datos y de la app dentro de nuestro sistema de recolección, pero como esta todo el sistema preparado para poder obtener lo que sea, solo se tendría que especificar en cada contenedor que queremos obtener sus logs con la linea `co.elastic.logs/enabled` poniendo un true donde ahora hay un false.

----
## **SISTEMA DE RECOGIDA Y EXPOSICIÓN DE DATOS**
El sistema de recogida y exposición de datos sera Grafana y Prometheus, Grafana para exponer los datos en varios dashboards y Prometheus para obtener los datos de docker y exponerlos en grafana. Como grafana y prometheus trabajan tan bien juntos, la configuración de estos es tan simple como crear un container para cada uno, ponerle como conexión (_datasource.yml_) en grafana la dirección de prometheus con su puerto abierto y ya estará, solo nos quedara montar nuestro dashboard con la info recolectada.

En este caso, solo hemos puesto un dashboard principal con toda la información que queriamos, como el contenido de una tabla (en nuestro caso la única) de la base de datos, una recolección de información sobre los items que tenemos, como si fuera nuestro inventario de productos, y luego un trackeo de nuestra infraestructura, para saber si se nos han caído o no los sistemas levantados y la cantidad de recursos consumidos.

----
# **ISSUES**
En este apartado vamos a colocar todos los issues que he tenido y que no he podido arreglar y que se quedan para su investigación. Todo estará documentado en la pagina de issue en [Github](https://github.com/hectorrf16/FinalProjectDO/issues). También al principio de la memoria se puede ver la etiqueta de la cantidad de Issues que hay, por lo que a medida que el proyecto avanza, se irán actualizando.

## **SISTEMA DE EXPOSICIÓN DE DATOS**
> [**16.05.2023 - Ver Problema**](https://github.com/hectorrf16/FinalProjectDO/issues/1) - Grafana no es capaz de conectar con la base de datos, teniendo un datasource configurado, todo porque coge los datos que le da la gana. La base de datos esta configurada para no utilizar SSL/TLS, pero grafana no es capaz de detectarlo y cuando conecta no es capaz de correr ninguna query por el error de conexión
> 
> ![grafana-issue1](screenshots/grafanaissue1.png)
> 
> **17.05.2023** - Respuesta / Solución
> ![grafana-issue1-fix](screenshots/grafanaissue1-fix.png)

## **SISTEMA DE MONITORIZACIÓN CON PROMETHEUS**
> [**02.06.2023 - Ver Problema**](https://github.com/hectorrf16/FinalProjectDO/issues/2) - Prometheus no era capaz de contactar con el HOST para obtener los datos de métricas de docker, ya que docker estaba en HOST y el propio container no accedía por `_localhost:9393_`
>
> ![docker-issue1](screenshots/dockerissue1.png)
> 
> **02.06.2023** - Se activo el servicio de métricas utilizando la dirección ip localhost de docker (`172.22.0.1:9393`) y se añadió la dirección como target en prometheus.
> ![docker-issue1-fix](screenshots/dockerissue1-fix.png)

## **SISTEMA DE REGISTRO DE LOGS EN POSTGRESQL**
> [**06.06.2023 - Ver Problema**](https://github.com/hectorrf16/FinalProjectDO/issues/3) - Por alguna razón, toda la información que había en internet no decía como hacer correctamente la activación de dos variables de postgres para activar los logs. Una de las variables necesitaba reiniciar el servidor de BBDD, pero los comandos que en internet salia no funcionaban... aunque dijera que el servicio estaba reiniciado, no registraba logs. 
>
> ![postgres-issue1](screenshots/postgresissue1.png)
> 
> **09.06.2023** - Al final, conseguí que registrara todo, añadiendo la información requerida sobre el fichero de configuración y reiniciando el servicio con el comando especifico en el primer setup en un container (`su postgres -c "pg_ctl -U ${POSTGRES_USER} -D /var/lib/postgresql/data -l logfile restart"`)
> ![postgres-issue1-fix](screenshots/postgresissue1-fix.png)