# Day 15 – Networking Concepts: DNS, IP, Subnets & Ports

Today was about understanding the building blocks of networking properly — not just running commands, but actually knowing what’s happening underneath.

---

# Task 1: DNS – How Names Become IPs

## 1️⃣ What happens when I type `google.com` in a browser?

When I type `google.com`, my system first checks its local DNS cache.  
If not found, it asks a DNS resolver (usually my ISP or configured DNS server).  
That resolver queries root → TLD (.com) → authoritative name server.  
Finally, it gets the IP address and my browser connects to that IP.

In short: DNS translates human-friendly names into machine-friendly IP addresses.

---

## 2️⃣ DNS Record Types

- **A** → Maps a domain to an IPv4 address  
- **AAAA** → Maps a domain to an IPv6 address  
- **CNAME** → Alias of one domain to another domain  
- **MX** → Mail server record for email handling  
- **NS** → Specifies the authoritative name servers for a domain  

---

## 3️⃣ `dig google.com`

Command:
dig google.com


Observation:
- **A record:** (example) `142.250.x.x`
- **TTL:** Around 300 seconds (varies)

TTL tells how long the record can be cached before refreshing.

---

# Task 2: IP Addressing

## 1️⃣ What is an IPv4 address?

An IPv4 address is a 32-bit number written in dotted decimal format like:

`192.168.1.10`

It has four octets (0–255 each).  
Each device in a network needs a unique IP.

---

## 2️⃣ Public vs Private IP

- **Public IP** → Routable on the internet (e.g., `8.8.8.8`)
- **Private IP** → Used inside local networks (e.g., `192.168.1.5`)

Private IPs are not directly accessible from the internet.

---

## 3️⃣ Private IP Ranges

- `10.0.0.0 – 10.255.255.255`
- `172.16.0.0 – 172.31.255.255`
- `192.168.0.0 – 192.168.255.255`

These are reserved for internal networks.

---

## 4️⃣ `ip addr show`

Command:
ip addr show


Observation:
My system has a `192.168.x.x` address — which means it's a private IP inside a LAN.

---

# Task 3: CIDR & Subnetting

## 1️⃣ What does `/24` mean?

In `192.168.1.0/24`, the `/24` means:

24 bits are reserved for the network portion.  
Remaining 8 bits are for hosts.

Subnet mask for /24 = `255.255.255.0`

---

## 2️⃣ Usable Hosts

- `/24` → 256 total IPs → 254 usable hosts  
- `/16` → 65,536 total IPs → 65,534 usable hosts  
- `/28` → 16 total IPs → 14 usable hosts  

(We subtract 2 for network ID and broadcast address.)

---

## 3️⃣ Why Do We Subnet?

Subnetting helps:
- Organize networks efficiently  
- Improve security by isolating segments  
- Reduce broadcast traffic  
- Better IP address management  

In cloud environments (like AWS), subnetting is critical for structuring VPCs properly.

---

## 4️⃣ CIDR Table

| CIDR | Subnet Mask     | Total IPs | Usable Hosts |
|------|-----------------|-----------|--------------|
| /24  | 255.255.255.0   | 256       | 254          |
| /16  | 255.255.0.0     | 65536     | 65534        |
| /28  | 255.255.255.240 | 16        | 14           |

---

# Task 4: Ports – The Doors to Services

## 1️⃣ What is a port?

A port is a logical endpoint inside a machine.  
IP identifies the device.  
Port identifies the service on that device.

Without ports, one server couldn’t run multiple services.

---

## 2️⃣ Common Ports

| Port  | Service      |
|-------|-------------|
| 22    | SSH         |
| 80    | HTTP        |
| 443   | HTTPS       |
| 53    | DNS         |
| 3306  | MySQL       |
| 6379  | Redis       |
| 27017 | MongoDB     |

---

## 3️⃣ `ss -tulpn`

Command:
ss -tulpn


Observation:
- Port 22 → SSH service listening  
- Port 631 → CUPS printing service  

This shows which services are actively waiting for connections.

---

# Task 5: Putting It Together

## 1️⃣ `curl http://myapp.com:8080` — What concepts are involved?

- DNS resolves `myapp.com` to an IP  
- IP routing sends packets to the correct server  
- TCP establishes connection  
- Port 8080 identifies the specific service  
- HTTP handles the application request  

Multiple layers working together.

---

## 2️⃣ App can’t reach DB at `10.0.1.50:3306` — What to check?

First checks:
- Is the database service running?
- Is port 3306 open and listening?
- Security group / firewall rules allowing traffic?
- Correct subnet routing?
- Same VPC / network connectivity?

Since it's a private IP (10.x.x.x), network configuration matters.

---

# What I Learned (Key Points)

1. DNS is a structured hierarchy — not magic.  
2. CIDR directly controls how many hosts a network can support.  
3. IP identifies the machine; Port identifies the service.  

Networking feels much more structured now instead of random commands.

---

#90DaysOfDevOps