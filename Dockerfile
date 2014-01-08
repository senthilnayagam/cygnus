MAINTAINER Senthil Nayagam "senthil@railsfactory.com"
FROM base

RUN sudo apt-get -y update
RUN sudo apt-get install -y htop procps git curl wget python-software-properties redis-server sudo
#mongodb

RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
RUN sudo echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" | tee -a /etc/apt/sources.list.d/10gen.list
RUN sudo apt-get -y update
RUN sudo apt-get -y install mongodb-10gen

#mariadb
RUN sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
RUN sudo add-apt-repository 'deb http://mirror.jmu.edu/pub/mariadb/repo/10.0/ubuntu precise main'
RUN sudo apt-get update
#export DEBIAN_FRONTEND=noninteractive
RUN sudo apt-get install python-software-properties
RUN sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
RUN sudo add-apt-repository 'deb http://ftp.yz.yamagata-u.ac.jp/pub/dbms/mariadb/repo/10.0/ubuntu precise main'
RUN sudo debconf-set-selections <<< "mariadb-server-10 mysql-server/root_password password root"
RUN sudo debconf-set-selections <<< "mariadb-server-10 mysql-server/root_password_again password root"
RUN sudo DEBIAN_FRONTEND=noninteractive  apt-get install -y mariadb-server



#ruby via rvm

RUN \curl -L https://get.rvm.io | bash -s stable
RUN source ~/.rvm/scripts/rvm

RUN rvm requirements
RUN rvm install ruby-1.9.3-p429@tomn --create


RUN sudo apt-get install  -y libmariadbd-dev 


RUN gem install bundler

RUN bundle install




# jenkins install
RUN wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN echo deb http://pkg.jenkins-ci.org/debian binary/ > sudo /etc/apt/sources.list.d/jenkins.list

RUN sudo apt-get update

RUN sudo apt-get install -y jenkins

