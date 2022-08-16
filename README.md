# Deploy to FTP(S) server from Drone CI

[![Docker Stars](https://badgen.net/docker/stars/cschlosser/drone-ftps)](https://hub.docker.com/r/cschlosser/drone-ftps/)
[![Docker Pulls](https://badgen.net/docker/pulls/cschlosser/drone-ftps)](https://hub.docker.com/r/cschlosser/drone-ftps/)
[![Docker Build](https://img.shields.io/docker/cloud/build/cschlosser/drone-ftps)](https://hub.docker.com/r/cschlosser/drone-ftps/)
[![Docker Size](https://badgen.net/docker/size/cschlosser/drone-ftps)](https://hub.docker.com/r/cschlosser/drone-ftps/)

## Usage

You have to set the username and password for your FTP server in the `FTP_USERNAME` and `FTP_PASSWORD` secret.

## Required settings

```yaml
environment:
    FTP_USERNAME:
      from_secret: username
    FTP_PASSWORD:
      from_secret: password
    PLUGIN_HOSTNAME: example.com:21
```

## Optional settings

```yaml
environment:
    PLUGIN_DEST_DIR: /path/to/dest (default /)
    PLUGIN_SRC_DIR: /path/to/dest (default ./)
    PLUGIN_SECURE: true | false (default true)
    PLUGIN_VERIFY: false
    PLUGIN_EXCLUDE: (egrep like pattern matching)
    PLUGIN_INCLUDE: (egrep like pattern matching)
    PLUGIN_CHMOD: true | false (default true)
    PLUGIN_CLEAN_DIR: true | false (default false)
    PLUGIN_AUTO_CONFIRM: true | false (default false)
    PLUGIN_SSH_ACCEPT_RSA: true | false (default false)
    PLUGIN_DEBUG: true | false (default false)
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
