#Instalacion de entornos

A Continuacion de detallan los pasos para instalar Ruby y JRuby.

## Instalacion Ruby

Se puede utilizar o bien RVM o RBENV

### Instalar utilizando rvm

Primero hay que instalar rvm (https://rvm.io/), para ello seguir la siguientes instrucciones de bash

```bash
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable
```

Despues copiar el template de rvmrc para que pueda instalar y utilizar la version requerida

```bash
cp .rvmrc_template .rvmrc
```

despues de eso, ejecutar el siguiente comando 

```bash
ruby -v
```

para verificar que la version de ruby sea la correcta

```bash
~/iasc/iasc-practica-ruby(master)$ ruby -v
ruby 2.5.0p0 (2017-12-25 revision 61468) [x86_64-linux]
```

### Instalar utilizando RBEnv


Para instalar RBEnv hay que instalar el entorno primero (El repo esta en https://github.com/rbenv/rbenv)

**1. Para instalar en Mac OSX seguir las instrucciones en el Readme**

#### Buildeando desde el source

Antes hay que instalar las dependencias para buildear RBEnv, ya que estaremos instalando a partir de lo que existe en el
repositorio de github

``` bash
sudo apt-get update
sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
```

Tambien instalar git, si es que no se tiene instalado 

```bash
sudo apt-get install git-core
```

Despues de eso seguir las siguientes instrucciones

1. Clonar rbenv en `~/.rbenv`.

    ~~~ sh
    $ git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    ~~~

    Despues de eso:

    ~~~
    $ cd ~/.rbenv && src/configure && make -C src
    ~~~

2. agregar `~/.rbenv/bin` a tu `$PATH` para acceder al comando de `rbenv` directamente.

    ~~~ sh
    $ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    ~~~

    **Ubuntu**: Modificar el `~/.bashrc` en vez de `~/.bash_profile`.
    **Para ZSh**: Modificar el `~/.zshrc` en vez de `~/.bash_profile`.

3. ejecutar `~/.rbenv/bin/rbenv init` y seguir las instrucciones para la instalacion de rbenv. Esto hace que ahora se tenga
una version funcional de ruby con este entorno.

4. Reiniciar el shell, esto se hace en gral abriendo una nueva consola.

5. verificar que con rbenv-doctor se ha instalado correctamente el entorno
   [rbenv-doctor](https://github.com/rbenv/rbenv-installer/blob/master/bin/rbenv-doctor) script:

    ~~~ sh
    $ curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
    Checking for `rbenv' in PATH: /usr/local/bin/rbenv
    Checking for rbenv shims in PATH: OK
    Checking `rbenv install' support: /usr/local/bin/rbenv-install (ruby-build 20170523)
    Counting installed Ruby versions: none
      There aren't any Ruby versions installed under `~/.rbenv/versions'.
      You can install Ruby versions like so: rbenv install 2.2.4
    Checking RubyGems settings: OK
    Auditing installed plugins: OK
    ~~~

6. _(Opcional)_ Instalar [ruby-build][], que provee el comando

   `rbenv install` y que ayuda a instalar más facilmente una nueva version de ruby
   

Luego de eso hay que solamente instalar la version de ruby que estaremos utilizando, en este casi Ruby 2.5

```bash

# list all available versions:
$ rbenv install -l

# install a Ruby version:
$ rbenv install 2.0.0-p247

```
  
### Instalacion de proyecto

Una vez que instalamos RBENV ó RVM, hay que setear el proyecto, ejecutar las siguientes instrucciones:

```bash

gem install bundler && bundle install

```

Esto instalará las dependencias y de aqui en más se puede proceder con la primera parte de la práctica.

## Instalacion de JRuby

Seguir las instrucciones descriptas en el siguiente readme [Instalación de JRuby][https://github.com/jruby/jruby/wiki/GettingStarted]