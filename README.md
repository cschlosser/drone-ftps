# Deploy to FTP(S) server from Drone CI

[![Docker Stars](https://img.shields.io/docker/stars/cschlosser/drone-ftps.svg)](https://hub.docker.com/r/cschlosser/drone-ftps/)
[![Docker Pulls](https://img.shields.io/docker/pulls/cschlosser/drone-ftps.svg)](https://hub.docker.com/r/cschlosser/drone-ftps/)
[![Docker Build](https://img.shields.io/docker/build/cschlosser/drone-ftps.svg)](https://hub.docker.com/r/cschlosser/drone-ftps/)
[![Docker Layers](https://images.microbadger.com/badges/image/cschlosser/drone-ftps.svg)](https://hub.docker.com/r/cschlosser/drone-ftps/)

## Usage

You have to set the password for your FTP server in the `FTP_PASSWORD` secret.

### Basic

```yaml
pipeline:
  deploy:
    image: cschlosser/drone-ftps
    username: drone
    hostname: example.com:21
    secrets: [ ftp_password ]
```

### Optional settings

```yaml
secure: true | false (default true)

dest_dir: /path/to/dest (default /)

src_dir: /path/to/src (default ./)

exclude: (egrep like pattern matching)
  - ^\.git/$
  - ^\.gitignore$
  - ^\.drone.yml$

include: like exclude
```

Full file:

```yaml
pipeline:
  deploy:
    image: cschlosser/drone-ftps
    username: drone
    hostname: example.com:21
    secrets: [ ftp_password ]
    secure: true
    dest_dir: /var/www/mysite
    src_dir: /mysite/static
    exclude:
      - ^\.git/$
      - ^\.gitignore$
      - ^\.drone.yml$
    include:
      - ^*.css$
      - ^*.js$
      - ^*.html$
```