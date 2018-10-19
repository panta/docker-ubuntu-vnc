README
======

This creates a Docker container with Ubuntu 18.04 and [TightVNC Server](https://tightvnc.com).

To build:

```bash
$ make build
```

To run:

```bash
$ make run
```

which is a shorthand for:

```bash
$ docker run --rm -ti -p 5901:5901 --name docker-ubuntu panta/docker-ubuntu-vnc:latest
```

To get a shell on a running container:

```bash
$ make shell
```
