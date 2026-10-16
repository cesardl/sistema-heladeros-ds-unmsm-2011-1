# Sistema de Gesti&oacute;n de Venta de Helados (SIGEVH)

[![Build Status](https://travis-ci.org/cesardl/sistema-heladeros-ds-unmsm-2011-1.svg?branch=master)](https://travis-ci.org/cesardl/sistema-heladeros-ds-unmsm-2011-1) [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=pe.edu.unmsm.fisi.sigevh-webapp&metric=alert_status)](https://sonarcloud.io/project/issues?id=pe.edu.unmsm.fisi.sigevh-webapp&resolved=false) [![Coverage Status](https://sonarcloud.io/api/project_badges/measure?project=pe.edu.unmsm.fisi.sigevh-webapp&metric=coverage)](https://sonarcloud.io/component_measures?id=pe.edu.unmsm.fisi.sigevh-webapp&metric=coverage)

Proyecto del curso Dise&ntilde;o de Sistemas, ciclo 2011-I.

En este proyecto se present&oacute; las funcionalidades de administraci&oacute;n de Sucursales y de vendedores de helados.

- JSF & RichFaces
- Hibernate
- C3P0
- MySQL
- PowerMock

## Resources

### Creating docker container for db
```
docker run --name mysql-ice-creams-providers -p 3306:3306 -e MYSQL_DATABASE=heladeros -e MYSQL_ROOT_PASSWORD=rootroot -e TZ='America/Lima' -d mysql:8.0
```

Then load the schema and seed data, and create the passwordless `travis` user that `hibernate.cfg.xml` connects as:
```
docker exec -i mysql-ice-creams-providers mysql -uroot -prootroot < database/heladeros.sql
docker exec mysql-ice-creams-providers mysql -uroot -prootroot -e "CREATE USER IF NOT EXISTS 'travis'@'%'; GRANT ALL PRIVILEGES ON *.* TO 'travis'@'%'; FLUSH PRIVILEGES;"
```

#### Updating timezone on db
Get into the container 
```
docker exec -it mysql-ice-creams-providers /bin/bash
```
Edit MySQL file config and set our time zone
```
echo default-time-zone='America/Lima' >> /etc/mysql/my.cnf
```
Restart container
```
docker restart mysql-ice-creams-providers
```

### Generating keystore for HTTPS connections
```
keytool -genkeypair -keystore ice-creams-providers.p12 -storetype PKCS12 -storepass 1234567890 -alias sigevh -keyalg RSA -keysize 2048 -validity 99999 -dname "CN=Cesardl, OU=UNMSM, O=Cesardl, L=Chorrillos, ST=Lima, C=PE"
```

### Running the app

```
docker build -t sigevh-webapp .
docker run -d --name sigevh-webapp --network cesardl-bridge-network -p 8443:8443 sigevh-webapp
```

Then browse to `https://localhost:8443/SIGEVH/` (self-signed certificate). The build bakes the WAR into a Tomcat 9 image — Tomcat 9 is the last line still speaking `javax.servlet`/`javax.faces`, which this JSF 1.2 app needs. The container expects the database reachable as `mysql-v8` over the `cesardl-bridge-network` Docker network; adjust `--network`/the `sed` in the `Dockerfile` if your database container has a different name or network.

## Documentation

[RichFaces Showcase](http://showcase.richfaces.org/richfaces/component-sample.jsf?demo=dataTable&sample=dataTableEdit&skin=blueSky)

[RichFaces Dev Guide](https://docs.jboss.org/richfaces/latest_3_3_X/en/devguide/html/RichFacesComponentsLibrary.html)

[Hibernate connection pool with Tomcat](https://developer.jboss.org/wiki/UsingHibernateWithTomcat)

## [10 Retos que Debes Realizar para ser Buen Programador](http://solutions-site40.blogspot.pe/2015/05/10-retos-que-debes-realizar-para-ser.html#/?)

### Tienda de golosinas 

Por l&oacute;gica general sabemos que las golosinas tienen fecha de caducidad as&iacute; que el reto es este:
hacer un programa que registre la fecha, el nombre, la cantidad y el tipo de producto que ingresa en existencia de 
una tienda, luego cuando se quiera vender un producto de la tienda el sistema se encarga de sacar primero 
al producto que tenga la fecha m&aacute;s antigua para no tener p&eacute;rdidas.

[![Scanned on](https://sonarcloud.io/images/project_badges/sonarcloud-black.svg)](https://sonarcloud.io/dashboard?id=pe.edu.unmsm.fisi.sigevh-webapp)
