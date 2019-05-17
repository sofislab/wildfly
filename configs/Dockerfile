FROM mvilche/centos-sdk as compilador
RUN git clone https://github.com/sofislab/su-exec.git && \
cd su-exec && make && chmod +x su-exec


FROM centos:7
COPY --from=compilador /su-exec/su-exec /usr/bin/su-exec
LABEL AUTOR="MARTIN VILCHE" PROYECTO="Proyecto WILDFLY 15 OPENJDK 11"
ENV JBOSS_HOME=/opt/wildfly15
RUN yum install wget java-11-openjdk-headless -y && \
touch /etc/localtime && chown 1001:1001 -R /etc/localtime
COPY standalone.xml run.sh drivers/ /opt/configs/
ENTRYPOINT ["/opt/configs/run.sh"]
VOLUME ["/opt/wildfly15"]
CMD ["/opt/wildfly15/bin/standalone.sh",  "-b", "0.0.0.0"]
