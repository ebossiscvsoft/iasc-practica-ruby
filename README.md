# iasc-practica-ruby

## Objetivos

* Comparar comportamiento de Puma en sus múltiples modos
* Comparar modelo de procesos y threads

Durante esta práctica estaremos utilizando Ruby 2.3 y JRuby 9.1.

## Instalacion de entornos

A Continuacion de detallan los pasos para instalar Ruby y JRuby.

### Instalacion Ruby

Instalar [rbenv](https://github.com/rbenv/rbenv).

```bash
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc # ó .bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bashrc # ó .bash_profile
```

Y luego, instalar Ruby y [bundler](http://bundler.io/)

```bash
rbenv install 2.3.1
rbenv global 2.3.1
rbenv rehash
gem install bundler
```

### Instalacion de proyecto

Una vez que instalamos RBENV, ejecutar las siguientes instrucciones:

```bash
bundle install
```

Esto instalará las dependencias y de aqui en más se puede proceder con la primera parte de la práctica.

## Consigna

Para cada paso

  * analizar el comportamiento de ambas rutas, anotarlo y comparar con las configuraciones anteriores.
  * analizar qué cantidad de threads del sistema operativo se crean (con `htop`)

1. Ejecutar utilizando Ruby con Puma, un proceso y un hilo
2. Ejecutar utilizando Ruby con Puma, N procesos y un hilo
3. Ejecutar utilizando Ruby con Puma, 1 Proceso y N hilos
4. Ejecutar utilizando Ruby con Puma, N procesos y N hilos
5. Ejecutar utilizando Jruby con Puma, 1 proceso y N hilos
