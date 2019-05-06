# WILDFLY Docker images

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)


# Funcionalidades:

  - Permite definir la zona horaria al iniciar el servicio
  - Permite definir el id del usuario que iniciará el contenedor
  - Non-root
  - Openshift compatible

### Iniciar


Ejecutar para iniciar el servicio

```sh
docker-compose up
```

### Persistencia de datos


| Directorio | Detalle |
| ------ | ------ |
| /opt/wildfly | Directorio raiz |


### Variables


| Variable | Detalle |
| ------ | ------ |
| TIMEZONE | Define la zona horaria a utilizar (America/Montevideo, America/El_salvador) |
| USER_ID | Define id del grupo que iniciará el servicio (Ej: 1002) |
| CUSTOM_JAVA_OPTS | custom java opts |


License
----

Martin vilche
