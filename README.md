# Deploy to FTP(S) server from Drone CI

[![Docker Stars](https://img.shields.io/docker/stars/cschlosser/drone-ftps.svg)](https://hub.docker.com/r/cschlosser/drone-ftps/)
[![Docker Pulls](https://img.shields.io/docker/pulls/cschlosser/drone-ftps.svg)](https://hub.docker.com/r/cschlosser/drone-ftps/)
[![Docker Build](https://img.shields.io/docker/build/cschlosser/drone-ftps.svg)](https://hub.docker.com/r/cschlosser/drone-ftps/)
[![Docker Layers](https://images.microbadger.com/badges/image/cschlosser/drone-ftps.svg)](https://hub.docker.com/r/cschlosser/drone-ftps/)

## Usage

You have to set the username and password for your FTP server in the `FTP_USERNAME` and `FTP_PASSWORD` secret.


## Optional settings

```yaml
environment:
    FTP_USERNAME:
      from_secret: username
    FTP_PASSWORD:
      from_secret: password
    PLUGIN_HOSTNAME: example.com:21
    PLUGIN_DEST_DIR: /path/to/dest (default /)
    PLUGIN_SRC_DIR: /path/to/dest (default ./)
    PLUGIN_SECURE: true | false (default true)
    PLUGIN_VERIFY: false
    PLUGIN_EXCLUDE: (egrep like pattern matching)
    PLUGIN_INCLUDE: (egrep like pattern matching)
```

## Full file example

```yaml
kind: pipeline
name: default

steps:
- name: master_build
  image: cschlosser/drone-ftps
  environment:
    FTP_USERNAME:
      from_secret: username
    FTP_PASSWORD:
      from_secret: password
    PLUGIN_HOSTNAME: example.com:21

    PLUGIN_SECURE: false
    PLUGIN_VERIFY: false
    PLUGIN_EXCLUDE: ^\.git/$
  when:
    branch:
    - master
    event:
    - push

- name: develop_build
  image: cschlosser/drone-ftps
  environment:
    FTP_USERNAME:
      from_secret: username
    FTP_PASSWORD:
      from_secret: password
    PLUGIN_HOSTNAME: example.com:21
    PLUGIN_DEST_DIR: /develop
    PLUGIN_SECURE: false
    PLUGIN_VERIFY: false
    PLUGIN_EXCLUDE: ^\.git/$
  when:
    branch:
    - develop
    event:
    - push
```
