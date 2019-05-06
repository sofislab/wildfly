FROM alpine:3.9
LABEL AUTOR="MARTIN VILCHE" PROYECTO="Proyecto WILDFLY 10 OPENJDK 8"
ENV JBOSS_HOME=/opt/wildfly10
RUN apk --no-cache add --update nss wget openjdk8-jre-base su-exec tzdata msttcorefonts-installer fontconfig && \
    update-ms-fonts && \
    fc-cache -f && \
touch /etc/localtime && chown 1001:1001 -R /etc/localtime
COPY standalone.xml run.sh drivers/ /opt/configs/
ENTRYPOINT ["/opt/configs/run.sh"]
VOLUME ["/opt/wildfly10"]
CMD ["/opt/wildfly10/bin/standalone.sh",  "-b", "0.0.0.0"]
