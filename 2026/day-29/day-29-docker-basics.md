# Day 29 – Docker Basics 🚀

---

# 📘 Task 1: What is Docker?

## 🔹 What is a Container?

A **container** is a lightweight, standalone, executable package that includes everything needed to run an application:

* Code
* Runtime
* Libraries
* Dependencies
* System tools

### Why Do We Need Containers?

* "Works on my machine" problem gets eliminated
* Consistent environments across dev, test, prod
* Lightweight and fast startup
* Efficient resource usage
* Easy scalability

---

## 🔹 Containers vs Virtual Machines

| Feature      | Containers           | Virtual Machines    |
| ------------ | -------------------- | ------------------- |
| OS           | Share host OS kernel | Each VM has full OS |
| Startup Time | Seconds              | Minutes             |
| Size         | MBs                  | GBs                 |
| Performance  | Near native          | Slight overhead     |
| Isolation    | Process-level        | Hardware-level      |

### 🔎 Real Difference

* VMs virtualize hardware.
* Containers virtualize the OS.
* Containers are lightweight and fast.
* VMs provide stronger isolation but consume more resources.

---

## 🔹 Docker Architecture

Docker follows a **client-server architecture**.

### Main Components:

1. **Docker Client**

   * The `docker` CLI
   * Sends commands to Docker daemon

2. **Docker Daemon (dockerd)**

   * Runs in background
   * Manages images, containers, networks, volumes

3. **Docker Images**

   * Read-only templates
   * Used to create containers

4. **Docker Containers**

   * Running instance of an image

5. **Docker Registry**

   * Stores Docker images
   * Example: Docker Hub

---

## 🧠 Docker Architecture (In My Words)

When I run a command like:

```
docker run nginx
```

1. Docker client sends request to Docker daemon
2. Daemon checks if image exists locally
3. If not found → pulls image from Docker Hub
4. Creates container from image
5. Starts the container

So the flow is:

**Client → Daemon → Registry (if needed) → Image → Container**

---

# ⚙️ Task 2: Install Docker

## 🔹 Installation

Installed Docker on my machine.

Verified installation using:

```
docker --version
```

Checked Docker service:

```
sudo systemctl status docker
```

---

## 🔹 Run hello-world

```
docker run hello-world
```

### What Happened?

* Docker checked local image
* Pulled from Docker Hub
* Created container
* Ran it
* Printed confirmation message
* Container exited

---

# 🌐 Task 3: Run Real Containers

## 🔹 Run Nginx Container

```
docker run -d -p 8080:80 --name my-nginx nginx
```

* `-d` → Detached mode
* `-p 8080:80` → Map port 8080 (host) to 80 (container)
* `--name` → Custom container name

Accessed in browser:

```
http://localhost:8080
```

---

## 🔹 Run Ubuntu in Interactive Mode

```
docker run -it ubuntu bash
```

* `-it` → Interactive terminal
* Explored commands like:

  * `ls`
  * `pwd`
  * `apt update`

Exited using:

```
exit
```

📸 **Screenshot:** Ubuntu interactive shell

---

## 🔹 List Running Containers

```
docker ps
```

## 🔹 List All Containers

```
docker ps -a
```

## 🔹 Stop a Container

```
docker stop <container_id>
```

## 🔹 Remove a Container

```
docker rm <container_id>
```

---

# 🔍 Task 4: Explore Advanced Options

## 🔹 Detached Mode

```
docker run -d nginx
```

* Runs container in background
* Returns container ID immediately

---

## 🔹 Custom Container Name

```
docker run --name custom-container nginx
```

---

## 🔹 Port Mapping

```
docker run -p 3000:80 nginx
```

Host port 3000 → Container port 80

---

## 🔹 Check Logs

```
docker logs my-nginx
```

---

## 🔹 Execute Command Inside Running Container

```
docker exec -it my-nginx bash
```

---

# 🏁 Conclusion

Today I learned:

* What containers are and why they matter
* Difference between Containers and VMs
* Docker architecture and workflow
* How to install Docker
* How to run, stop, remove, and inspect containers
* How to use interactive and detached modes

Docker makes application deployment faster, consistent, and portable across environments.

---

# 🚀 Next Step

Start learning:

* Docker Images deeply
* Dockerfile
* Docker Networking
* Docker Volumes

Day 29 Complete ✅

