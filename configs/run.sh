#!/bin/bash
set -e

echo "··························································································"
echo "MARTIN VILCHE"
echo "··························································································"

if [ -z "$USERID" ]; then
export USERID=1001
echo "···································································································"
echo "VARIABLE USERID NO ENCONTRADO USANDO POR DEFECTO " $USERID
echo "···································································································"
else
echo "···································································································"
echo "VARIABLE USERID ENCONTRADO: " $USERID
echo "···································································································"
fi

if [ -z "$TIMEZONE" ]; then
echo "···································································································"
echo "VARIABLE TIMEZONE NO SETEADA - INICIANDO CON VALORES POR DEFECTO"
echo "POSIBLES VALORES: America/Montevideo | America/El_Salvador"
echo "···································································································"
else
echo "···································································································"
echo "TIMEZONE SETEADO ENCONTRADO: " $TIMEZONE
echo "···································································································"
echo "SETEANDO TIMEZONE...."
cat /usr/share/zoneinfo/$TIMEZONE > /etc/localtime

if [ $? -eq 0 ]; then
echo "···································································································"
echo "TIMEZONE SETEADO CORRECTAMENTE"
echo "···································································································"
else

echo "···································································································"
echo "ERROR AL SETEAR EL TIMEZONE - SALIENDO"
echo "···································································································"
exit 1
fi
fi

if [ -z "$CUSTOM_JAVA_OPTS" ]; then
echo "···································································································"
echo "VARIABLE CUSTOM_JAVA_OPTS NO SETEADA - INICIANDO CON VALORES POR DEFECTO"
echo "PUEDE DEFINIR LA VARIABLE CUSTOM_JAVA_OPTS PARA SETEAR PARAMETROS DE JAVA"

echo "···································································································"
else
echo "........................."
echo "VARIABLE CUSTOM_JAVA_OPTS SETEADA"
echo "SETEANDO LOS PARAMETROS: " $CUSTOM_JAVA_OPTS
echo "........................."
fi


if [ ! -d /opt/wildfly15/.init ]; then
echo "........................."
echo "JBOSS NO INICIALIZADO - DESCARGANDO.."
echo "ESPERE POR FAVOR...."
wget https://download.jboss.org/wildfly/15.0.0.Final/wildfly-15.0.0.Final.tar.gz -O wildfly.tar.gz && \
tar zxvf wildfly.tar.gz -C /opt/wildfly15 --strip-components 1  && chmod +x /opt/wildfly15/bin/* && \
rm -rf wildfly.tar.gz /opt/wildfly15/docs /opt/wildfly15/welcome-content && \
mkdir /opt/wildfly15/.init && \
cp -rf /opt/configs/mysql /opt/wildfly15/modules/system/layers/base/com/ && \
cp -rf /opt/configs/standalone.xml /opt/wildfly15/standalone/configuration/ && \
echo "........................." && \
echo "WILDFLY DESCARGADO CORRECTAMENTE EN /opt/wildfly15"
echo "........................." 
else
echo "WILDFLY YA FUE INICIALIZADO - NO ES NECESARIO VOLVER A DESCARGAR"
echo "........................." 
fi

echo "LIMPIANDO DIRECTORIOS"

cd /opt/wildfly15/standalone/; rm -rf log/ tmp/ data/ configuration/standalone_xml_history deployments/*.deployed deployments/*.failed

echo "........................."
echo "FIX PERMISOS"
chown $USERID:$USERID -R /opt/

export JAVA_OPTS="$CUSTOM_JAVA_OPTS -DLOGLEVEL -DDATABASE-NAME -DDATABASE-HOST -DDATABASE-PORT -DDATABASE-USER -DDATABASE-PASSWORD -DJNDI-NAME -DPOOL-NAME -XX:+UseParallelGC -Dfile.encoding=UTF8 -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -XX:MinHeapFreeRatio=20 -XX:MaxHeapFreeRatio=40 -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses=true"
echo "INICIANDO WILDFLY......"
exec su-exec $USERID "$@"
