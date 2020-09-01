# dss-pnrp-redmine-plugin

## Requerimientos.

[Docker](https://docs.docker.com/engine/install/ubuntu/)

[Docker-Compose](https://docs.docker.com/compose/install/)

## Guia como crear la imagen docker en local.

```
cd docker
docker build . -t redmine-dss-pnrp:0.0.1 
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

Para generar modelos.
```
bundle exec rails generate redmine_plugin_model <plugin_name> <model_name> [field[:type][:index] field[:type][:index] ...]
```

Para generar controladores.
```
bundle exec rails generate redmine_plugin_controller <plugin_name> <controller_name> [<actions>]
```

Para instalar cambios en el plugin.
```
bundle install --no-deployment
```

### Guia como extraer archivos desde el contenedor hacia repositorio (linux).

```
./copy-linux.sh
git add .
git commit -m 'Mensaje commit'
git push
```




