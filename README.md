# dss-pnrp-redmine-plugin

## Requerimientos

[Docker](https://docs.docker.com/engine/install/ubuntu/)
[Docker-Compose](https://docs.docker.com/compose/install/)
[Direnv](https://direnv.net/)

## Ejecutar proyecto en modo desarrollo.
```
docker-dev up -d 
```

Una vez que esto esta iniciado accedemos a la aplicacion de Redmine en la [url](http://localhost:8080) .

## Ingreso al sistema
Default user/password.
* user: user
* password: bitnami1

## Lista comandos utiles
Estos deben ejecutarse una vez que se ingresa a la carpeta del proyecto y se suben las variables de ambiente de direnv.

### Para realizar las migraciones de los plugins.
```
bundle exec rake redmine:plugins:migrate
```

### Para recrear las bases de datos.
```
export DISABLE_DATABASE_ENVIRONMENT_CHECK=1
export REDMINE_LANG=en
bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake redmine:load_default_data
```

### Para utilizar la consola. 
```
bundle exec rails console
```

### Para generar controladores.
```
bundle exec rails generate redmine_plugin_controller <plugin_name> <controller_name> [<actions>]
```

### Para generar modelos.
```
bundle exec rails generate redmine_plugin_model <plugin_name> <model_name> [field[:type][:index] field[:type][:index] ...]
```

## Arreglar problemas de permisos
Cada vez que se generen nuevos archivos dentro del contenedor (al ejecutar un comando) se deberan ejecutar la siguiente sentencia.
```
sudo chown $USER -R ./
```




