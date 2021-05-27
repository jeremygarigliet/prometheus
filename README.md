# Prometheus

As I use prometheus to monitor docker swarm nodes, stacks and services, I happen to need to expose the docker socket for automated discovery, [as described here](https://prometheus.io/docs/guides/dockerswarm/).

However the official prometheus image runs using the `nobody` user and group.

While I undestand the historical reasons behind it, I cannot reasonably give `nobody` access to the docker socket, because other services/daemons running on my hosts might share the same user account, giving them rights to consult and/or manipulate docker on the machine.

So I'm building a new image that runs prometheus using a dedicated user, based on the official one.

## Build image

The default user in this image is as follows :

| user | group | UID | GID |
| :--- | :--- | :--- | :--- |
| monitor | monitor | 10667 | 10667 |

---

To build the default image :

```bash
docker build -t jeremygarigliet/prometheus .
```

If you want to use different values, you can specify those as build argument :

```bash
USER=monitor
GROUP=monitor
UID=10667
GID=10667

docker build \
 --build-arg USER=${USER} \
 --build-arg GROUP=${GROUP} \
 --build-arg UID=${UID} \
 --build-arg GID=${GID} \
 -t jeremygarigliet/prometheus \
 .
```
