## Today's Goal

Understand how Docker images and containers actually work, how layers function, and how the full container lifecycle behaves.

---

## Task 1: Docker Images

## 🔹 Pull Required Images

```bash
docker pull nginx
docker pull ubuntu
docker pull alpine
```

---

## 🔹 List All Images

```bash
docker images
```

Observe:

* Repository
* Tag
* Image ID
* Created time
* Size

---

## Ubuntu vs Alpine (Size Comparison)

* **Ubuntu** → Larger (hundreds of MBs)
* **Alpine** → Very small (~5–10MB)

### Why Alpine Is Smaller?

* Minimal Linux distribution
* BusyBox utilities instead of full GNU tools
* Designed specifically for containers

Ubuntu contains:

* Full package manager
* More libraries
* More system tools

Alpine contains:

* Only essentials
* Lightweight musl libc instead of glibc

---

## Inspect an Image

```bash
docker image inspect nginx
```

Information visible:

* Image ID
* Layers
* Environment variables
* Default command
* Architecture
* OS
* Creation timestamp

---

## 🗑 Remove an Image

```bash
docker rmi alpine
```

If image is in use, stop/remove containers first.

---

# Task 2: Image Layers

## 🔹 View Image History

```bash
docker image history nginx
```

Each row represents a **layer**.

You will notice:

* Some layers have sizes (MBs)
* Some show `0B`

### What Are Layers?

* Each Docker image is built in layers.
* Every instruction in a Dockerfile creates a new layer.
* Layers are read-only.
* Containers add a writable layer on top.

### Why Docker Uses Layers?

* Faster builds (layer caching)
* Shared layers between images
* Reduced storage usage
* Efficient image distribution

If two images share the same base layer, Docker downloads it only once.

---

# Task 3: Container Lifecycle

Using nginx as example.

---

## 🔹 Create Container (Without Starting)

```bash
docker create --name lifecycle-nginx nginx
```

Check state:

```bash
docker ps -a
```

State → Created

---

## 🔹 Start Container

```bash
docker start lifecycle-nginx
```

State → Running

---

## 🔹 Pause Container

```bash
docker pause lifecycle-nginx
```

State → Paused

---

## 🔹 Unpause

```bash
docker unpause lifecycle-nginx
```

State → Running

---

## 🔹 Stop

```bash
docker stop lifecycle-nginx
```

State → Exited

---

## 🔹 Restart

```bash
docker restart lifecycle-nginx
```

State → Running

---

## 🔹 Kill

```bash
docker kill lifecycle-nginx
```

Force stops container immediately.

---

## 🔹 Remove Container

```bash
docker rm lifecycle-nginx
```


# Task 4: Working with Running Containers

## 🔹 Run Nginx in Detached Mode

```bash
docker run -d -p 8080:80 --name my-nginx nginx
```

---

## 🔹 View Logs

```bash
docker logs my-nginx
```

---

## 🔹 View Real-Time Logs (Follow Mode)

```bash
docker logs -f my-nginx
```

---

## 🔹 Exec Into Container

```bash
docker exec -it my-nginx bash
```

Explore:

```bash
ls
cd /usr/share/nginx/html
```

---

## 🔹 Run Single Command Without Entering

```bash
docker exec my-nginx ls /
```

---

## 🔹 Inspect Container

```bash
docker inspect my-nginx
```

Find:

* IP Address
* Port mappings
* Mounts
* Network mode
* State


# Task 5: Cleanup

## 🔹 Stop All Running Containers

```bash
docker stop $(docker ps -q)
```

---

## 🔹 Remove All Stopped Containers

```bash
docker rm $(docker ps -aq)
```

---

## 🔹 Remove Unused Images

```bash
docker image prune -a
```

---

## 🔹 Check Docker Disk Usage

```bash
docker system df
```

---

# What I Learned Today

* Relationship between images and containers
* How image layers work
* Why caching makes builds efficient
* Full container lifecycle states
* How to inspect, manage, and debug containers
* How to clean up unused Docker resources

Docker images are blueprints.
Containers are running instances.
Layers make Docker efficient and powerful.