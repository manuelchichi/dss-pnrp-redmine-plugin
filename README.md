# dss-pnrp-redmine-plugin

## Requerimientos.

[Docker](https://docs.docker.com/engine/install/ubuntu/)

[Docker-Compose](https://docs.docker.com/compose/install/)

## Guia como crear la imagen docker en local.

```
cd docker
docker build --build-arg DUMMY=`date +%s` . -t redmine-dss-pnrp:0.0.1 
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

En el siguiente link vemos el [tutorial](https://www.redmine.org/projects/redmine/wiki/Plugin_Tutorial) para crear plugins en Redmine.

Para ingresar al contenedor.
```
docker exec -it <Nombre-Contenedor> /bin/bash

docker exec -it docker_redmine_1 /bin/bash
```

Una vez dentro debemos ejecutar el siguiente comando.
```
export RAILS_ENV="production" 
```

Para generar modelos.
```
bundle exec rails generate redmine_plugin_model <plugin_name> <model_name> [field[:type][:index] field[:type][:index] ...]
```

Para instalar cambios en el plugin.
```
bundle exec rake redmine:plugins:migrate
```

Para utilizar la consola. 

```
bundle exec rails console
```

Para generar controladores.
```
bundle exec rails generate redmine_plugin_controller <plugin_name> <controller_name> [<actions>]
```

Para extraer los archivos generados.
```
./copy-linux.sh
```

### Guia como extraer archivos desde el contenedor hacia repositorio (linux).

```
./copy-linux.sh
git add .
git commit -m '<Mensaje commit>'
git push
```

## Resumen guia de trabajo.

1. Crear controladores y modelos dentro del contenedor.

1. Sacarlos fuera del contenedor (./copy-linux.sh).

1. Trabajarlos/Modificarlos segun corresponda.

1. git push de los cambios.

1. Buildear nueva imagen en Docker.






