# Instalación manual

Esta es una app que necesita tener instalado java 17 y maven 3.9.1 para poder funcionar.

## Como Instalar JDK-17

Ejecutar los siguientes comandos

```
wget https://download.oracle.com/java/17/archive/jdk-17_linux-x64_bin.tar.gz
tar -xvf jdk-17_linux-x64_bin.tar.gz
sudo mv jdk-17 /opt/

JAVA_HOME='/opt/jdk-17'
PATH="$JAVA_HOME/bin:$PATH"
export PATH
```

## Como Instalar Maven 3.9.1

Ejecutar los siguientes comandos

```
wget https://dlcdn.apache.org/maven/maven-3/3.9.1/binaries/apache-maven-3.9.1-bin.tar.gz
tar -xvf apache-maven-3.9.1-bin.tar.gz
sudo mv apache-maven-3.9.1 /opt/

M2_HOME='/opt/apache-maven-3.9.1'
PATH="$M2_HOME/bin:$PATH"
export PATH
```

## Crear un usuario que tenga permisos de correr la app

Es deseable crear un usuario y un grupo nuevo con menos privilegios para correr la app.


## Como buildear la aplicación

Primero clonarla

```
git clone https://github.com/XimenaLargo96/ClinicaDentalApp.git' /srv/clinica-app
cd /srv/clinica-app
mvn package
```

## Como ejecutar la aplicación

```
cd /srv/clinica-app
java -jar target/final-project-0.0.1-SNAPSHOT.jar
```