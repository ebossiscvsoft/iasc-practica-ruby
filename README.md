# iasc-practica-ruby

## Objetivos

* Comparar comportamiento de Puma en sus múltiples modos
* Comparar modelo de procesos y threads

Durante esta práctica estaremos utilizando Ruby > 2.3 y JRuby 9.1.

## Instalacion de entornos

A Continuacion de detallan los pasos para instalar Ruby y JRuby.

### Instalacion Ruby

Instalar [rbenv](https://github.com/rbenv/rbenv).

```bash
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc # ó .bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bashrc # ó .bash_profile
```

Y luego, instalar Ruby y [bundler](http://bundler.io/):

```bash
rbenv install 2.3.1
rbenv global 2.3.1
rbenv rehash
gem install bundler
```

Instalar tambien jruby 9.1:

```bash
rbenv install jruby-9.1.16.0
```

### Instalacion de proyecto

Una vez que instalamos RBENV, ejecutar las siguientes instrucciones:

```bash
bundle install
```

Esto instalará las dependencias y de aqui en más se puede proceder con la primera parte de la práctica.

## Consigna

### Generalidades

Esta práctica se realizará en varios escenarios. Para cada uno:

  * analizar el comportamiento de ambas rutas, anotarlo y comparar con las configuraciones anteriores.
  * analizar qué cantidad de threads del sistema operativo se crean (con `htop`)
  * probar tanto con un cliente como con varios clientes concurrentes

El objetivo no es obtener tiempos exactos (ya tendremos una práctica sobre ello) sino entender cualiativamente los modelos de SO Threads, Green Threads y Procesos.

#### Escenarios

1. Ejecutar utilizando Ruby con Puma, un proceso y un hilo
2. Ejecutar utilizando Ruby con Puma, N procesos (_clustered_) y un hilo
3. Ejecutar utilizando Ruby con Puma, 1 Proceso y N hilos
4. Ejecutar utilizando Ruby con Puma, N procesos (_clustered_) y N hilos
5. Ejecutar utilizando Jruby con Puma, 1 proceso y N hilos

#### Uso de tester concurrente (Requiere python 3)

Ejecutar el script como:

```
$ ./time-tester.py <url> <cantidad de hilos>
```

Por ejemplo:

```
$ ./time-tester.py "http://localhost:9292/cpu_bound" 100
```



#### Preguntas de auto-evaluación

A partir de las mediciones y comparaciones en cada escenario, deberías poder responder:

* Bajo green threads, si la cantidad de threads aumenta ¿mejora la performance de una tarea cpu bound?
* Bajo green threads, si la cantidad de threads aumenta ¿mejora la performance de una tarea IO bound?
* Bajo SO threads, si la cantidad de threads aumenta ¿mejora la performance de una tarea cpu bound?
* Bajo N procesos (modo clustered), si la cantidad de procesos aumenta por encima de la cantidad de cores de la máquina, ¿mejora la performance de una tarea cpu bound?
* Los Green threads de Ruby, ¿son realmente green threads? (Tip: analizar mediante `htop` si el sistema operativo los ve)
* Bonus: ¿Qué sucede si se mata (mediante `kill`) a alguno de los procesos de puma bajo el modelo _clustered_?

### FAQ

#### ¿Cómo lanzar el servidor?

Simplemente hay que ejecutar el comando `puma` mediante `bundle exec`:

```
bundle exec puma
```

#### ¿Cómo probar el servidor?

El servidor soporta dos rutas:  `/io_bound` y `/cpu_bound`. Como sus nombres lo indican, la primera realiza una tarea con mínimo procesamiento pero gran cantidad de E/S (lee un archivo), y la segunda es código puro (ejecuta una función factorial).

Para probarlas, se puede utilizar por ejemplo:

* `curl` (desde la terminal)
* [`Postman`](https://www.getpostman.com/) (desde el browser).

#### ¿Cómo controlar la cantidad de hilos y procesos

El comando `puma` acepta dos parámetros para controlarlos `-t` y `-W`:

* `-t` define la cantidad mínima y máxima de threads
* `-W` define la cantidad de procesos (llamados _workers_)

Por ejemplo:

```
# Lanzar puma con 4 hilos
bundle exec puma -t 4:4

# Lanzar puma con 1 proceso
bundle exec puma -W 1

# Lanzar puma con 2 procesos
# (lo que se conoce como modo clustered, es decir, que  la cantidad de workers > 1)
bundle exec puma -W 2
```

Estas opciones son combinables.

#### ¿Qué hago si la tarea cpu bound termina demasiado rápido/demasiado lento en mi máquina?

Ajustá el valor del factorial en `config.ru`

```
get '/cpu_bound' do
  # Ajustá el valor del 34 para lograr un calculo que se tome su tiempo pero termine
  {result: fact(34)}.to_json
end
```

#### ¿Cómo hago para correr este servidor con Ruby? ¿Y con JRuby?

Las instrucciones anteriores corren este servidor con Ruby estándar (MRI, también llamado YARV). Para ejecutarlo con JRuby, es necesario cambiar el intérprete a mano e instalar bundler :

```
rbenv use jruby-9.1.16.0
rbenv rehash
gem install bundler
```

y luego ejecutar `puma` normalmente.


#### ¿Qué puedo hacer si quiero correr (por algún motivo) el servidor con otra versión de ruby?

Tenés que

* modificar el archivo `.ruby-version` y el `Gemfile`,
* luego `gem install bundler`
* luego `bundle install`

Y eso es todo.
