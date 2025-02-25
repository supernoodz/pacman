ARG MY_BASE_IMAGE=registry.access.redhat.com/ubi8/ubi-minimal
FROM $MY_BASE_IMAGE

MAINTAINER Nik
USER root
RUN microdnf update -y && microdnf upgrade -y && \
    microdnf module enable nodejs:16 && microdnf install nodejs && \
    mkdir -p /opt/app-root/src/pacman && \
    rpm -e --nodeps $(rpm -qa '*rpm*' '*dnf*' '*libsolv*' '*hawkey*' 'yum*' 'curl' )

COPY . /opt/app-root/src/pacman
WORKDIR /opt/app-root/src/pacman
RUN npm install
EXPOSE 8080
RUN mkdir /.npm
RUN chown -R 1001080000:0 '/.npm'

USER 1001

CMD ["npm", "start"]
