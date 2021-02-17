# dss-pnrp-redmine-plugin

## Requerimientos.

[Docker](https://docs.docker.com/engine/install/ubuntu/)

[Docker-Compose](https://docs.docker.com/compose/install/)

## Guia como correr el contenedor de Redmine para realizar las pruebas.

```
cd docker
docker-compose up -d 
```

Una vez que esto esta iniciado accedemos a la aplicacion de Redmine en la [url](http://localhost:8080) .

## Guia como abrir el repositorio.

Con su IDE favorito abrimos la carpeta ./docker/redmine_data/redmine/plugins/dss_nprp. 

Para realizar modificaciones hay que cambiar los permisos de dicha carpeta. Cada vez que se generen nuevos archivos dentro del contenedor (al ejecutar un comando) se deberan ejecutar la siguiente sentencia.

```
sudo chown $(USER) -R ./redmine_data/
```

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

## Resumen guia de trabajo.

1. git pull de los cambios.

1. Crear controladores y modelos dentro del contenedor.

1. Trabajarlos/Modificarlos segun corresponda.

1. git push de los cambios.

1. Buildear nueva imagen en Docker.

1. Eliminar el contenedor viejo. Crear uno nuevo en base a la nueva imagen.






