# dss-pnrp-redmine-plugin

## Requerimientos.

[Docker](https://docs.docker.com/engine/install/ubuntu/)

[Docker-Compose](https://docs.docker.com/compose/install/)

## Guia como correr el contenedor de Redmine para realizar las pruebas.

```
docker-compose up -d 
```
En el caso de que haya errores en algun lado de la aplicacion se deberan chequear si se corrieron las migraciones del plugin (en una seccion mas adelante se explica como realizarlo). (Refactorizar para que lo haga cuando arranca)

Una vez que esto esta iniciado accedemos a la aplicacion de Redmine en la [url](http://localhost:8080) .

## Guia como abrir el repositorio.

Con su IDE favorito abrimos la carpeta del proyecto actual. 

Para realizar modificaciones hay que cambiar los permisos de dicha carpeta. Cada vez que se generen nuevos archivos dentro del contenedor (al ejecutar un comando) se deberan ejecutar la siguiente sentencia.

```
sudo chown $USER -R redmine_data/
```

### Ingreso al sistema.

Default user/password.
* user: user
* password: bitnami1

### Guia como ingresar al contenedor para ejecutar comandos.

En el siguiente link vemos el [tutorial](https://www.redmine.org/projects/redmine/wiki/Plugin_Tutorial) para crear plugins en Redmine.

Para ingresar al contenedor.
```
docker exec -it dss-pnrp-redmine-plugin_redmine_1 /bin/bash
```

Una vez dentro debemos ejecutar los siguientes comandos para poder utilizar bundle.
```
cd /opt/bitnami/redmine
```

#### Lista comandos utiles
Para generar modelos.
```
bundle exec rails generate redmine_plugin_model <plugin_name> <model_name> [field[:type][:index] field[:type][:index] ...]
```

Para recrear las bases de datos.
```
export DISABLE_DATABASE_ENVIRONMENT_CHECK=1
export REDMINE_LANG=en
bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake redmine:load_default_data
```

Para realizar las migraciones del plugin.
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






