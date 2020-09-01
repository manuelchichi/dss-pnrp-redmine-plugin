# dss-pnrp-redmine-plugin

## Requerimientos.

[Docker](https://docs.docker.com/engine/install/ubuntu/)

[Docker-Compose](https://docs.docker.com/compose/install/)

## Guia como crear la imagen docker en local (plantear usar un registry).

```
cd docker
docker build . -t redmine-dss-pnrp:x.x.x 
```
Donde estan las x reemplazar por la version actual.

## Guia como correr el contenedor de Redmine para realizar las pruebas.

```
cd docker
docker-compose up -d 
```

Una vez que esto esta iniciado accedemos a la aplicacion de Redmine en la [url](http://localhost:8080) .

### Ingreso al sistema.

Default user/password.
* user: user
* password: bitnami1

### Guia como ingresar al contenedor para ejecutar comandos.

Para ingresar al contenedor.
```
docker exec -it <Nombre-Contenedor> /bin/bash
```

Para generar modelos.
```
bundle exec rails generate redmine_plugin_model <plugin_name> <model_name> [field[:type][:index] field[:type][:index] ...]
```

Para generar controladores.
```
bundle exec rails generate redmine_plugin_controller <plugin_name> <controller_name> [<actions>]
```





