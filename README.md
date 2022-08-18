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
    PLUGIN_PRE_ACTION: string (default empty)
    PLUGIN_POST_ACTION: string (default empty)
    PLUGIN_DEBUG: true | false (default false)
```
### Pre/Post Action
Pre/Post Action can be used to move files/folders out of the way or execute additional commands on the server before and after the deployment process.  
The `PLUGIN_PRE_ACTION` is executed *before* the `PLUGIN_CLEAN_DIR` (if set).  
The `PLUGIN_POST_ACTION` is executed *after* the ftp "mirror" operation.  

Multiple Actions can be set, they need to be divided by a semicolon `;` .  
**Example:**  
There is another project's folder ("project2") in a subfolder in the destination directory. We need to move this folder to a temporary location and restore it after the upload completed.
```yaml
PLUGIN_CLEAN_DIR: true
PLUGIN_PRE_ACTION: mv /dest/project2 /temp/project2;
PLUGIN_POST_ACTION: mv /temp/project2 /dest/project2;
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
