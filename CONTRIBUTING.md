# Contribuir en el proyecto

A continuacion se listaran las herramientas necesarias para contribuir con el
desarrollo del proyecto.

## Herramientas necesarias

* [Docker](https://docs.docker.com/engine/install/ubuntu/)
* [Docker-Compose](https://docs.docker.com/compose/install/)
* [Direnv](https://direnv.net/)

## Produccion

### Comandos
```
# Para iniciar las imagenes Docker
docker-prod up -d

# Una vez que finalizamos el trabajo
docker-prod down -v
```
## Desarrollo

### Comandos
```
# Para levantar las imagenes Docker
docker-dev up -d

# Ejecutamos los siguientes comandos para instalar los plugins
bundle config unset deployment
bundle install --no-deployment

# Una vez que finalizamos el trabajo

docker-dev down -v
```

Una vez que esto esta iniciado accedemos a la aplicacion de Redmine en la [url](http://localhost:8080) .

## Ingreso al sistema
Default user/password.
* user: admin
* password: admin

## Lista comandos utiles
Estos deben ejecutarse una vez que se ingresa a la carpeta del proyecto y se suben las variables de ambiente de direnv.

### Para realizar las migraciones de los plugins.
```
bundle exec rake redmine:plugins:migrate
```

### Para recrear las bases de datos.
```
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
