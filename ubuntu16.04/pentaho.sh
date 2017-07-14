#!/bin/bash

vi ~/pentaho-server/tomcat/conf/server.xml
change to
    <Connector URIEncoding="UTF-8" port="8081" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" 
		proxyName="tahu.tukang.review"
		proxyPort="443"
		scheme="https"
		/>

vi ~/pentaho-server/pentaho-solutions/system/server.properties 

fully-qualified-server-url=http://localhost:8080/pentaho/


