FROM ubuntu:18.04

# Install RVM
RUN apt-get update \
  && apt-get install -yq git curl gnupg2 htop apache2-utils\
  && rm -rf /var/lib/apt/lists/*

# Install + verify RVM with gpg (https://rvm.io/rvm/security)
RUN gpg2 --quiet --no-tty --logger-fd 1 --keyserver hkp://keys.gnupg.net \
  --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
  7D2BAF1CF37B13E2069D6956105BD0E739499BDB \
  && echo 409B6B1796C275462A1703113804BB82D39DC0E3:6: | \
  gpg2 --quiet --no-tty --logger-fd 1 --import-ownertrust \
  && curl -sSO https://raw.githubusercontent.com/rvm/rvm/stable/binscripts/rvm-installer \
  && curl -sSO https://raw.githubusercontent.com/rvm/rvm/stable/binscripts/rvm-installer.asc \
  && gpg2 --quiet --no-tty --logger-fd 1 --verify rvm-installer.asc \
  && bash rvm-installer stable \
  && rm rvm-installer rvm-installer.asc \
  && echo "bundler" >> /usr/local/rvm/gemsets/global.gems \
  && echo "rvm_silence_path_mismatch_check_flag=1" >> /etc/rvmrc \
  && echo "install: --no-document" > /etc/gemrc

# Workaround tty check, see https://github.com/hashicorp/vagrant/issues/1673#issuecomment-26650102
RUN sed -i 's/^mesg n/tty -s \&\& mesg n/g' /root/.profile

# Switch to a bash login shell to allow simple 'rvm' in RUN commands
SHELL ["/bin/bash", "-l", "-c"]
RUN useradd -m --no-log-init -r -g rvm user
RUN rvm install 2.7.1 \
  && rvm use 2.7.1 \
  && gem install bundler \
  && rvm get head \
  && rvm install jruby-9.2.8.0 \
  && gem install bundler \
  && rvm alias create rb ruby-2.7.1 \
  && rvm alias create jrb jruby-9.2.8.0

RUN mkdir /app
WORKDIR /app
COPY Gemfile .
COPY Gemfile.lock .
RUN rvm use jrb && bundle install
RUN rvm use rb && bundle install
COPY . .
RUN ./generate_file.bash
CMD /bin/bash -c htop
