# Day 14 – Networking Fundamentals & Hands-on Checks

## Task Overview

Today’s goal was simple: stop treating networking like theory and start treating it like something I can actually troubleshoot.

Instead of memorizing definitions, I mapped the OSI and TCP/IP models in my own words and ran real commands that I’d use during an incident.

Target used for checks: **google.com**

---

## Quick Concepts

### OSI vs TCP/IP (My Understanding)

- **OSI model (7 layers)** is more detailed and theoretical. It splits responsibilities clearly from physical cables (Layer 1) all the way to applications (Layer 7).
- **TCP/IP model (4 layers)** is practical and what the internet actually follows: Link → Internet → Transport → Application.

In short:  
OSI explains networking deeply. TCP/IP runs the real world.

---

### Where Things Sit in the Stack

- **IP** → Internet layer (handles addressing and routing)
- **TCP/UDP** → Transport layer (handles communication reliability and ports)
- **HTTP/HTTPS** → Application layer (actual web communication)
- **DNS** → Application layer (translates names to IP addresses)

Real example:

`curl https://example.com`  
= Application (HTTP) → over Transport (TCP) → over Internet (IP)

---

## Hands-on Checks

### 1️⃣ Identity Check

Command:
hostname -I

Observation:  
My machine has a private IP in the `192.168.x.x` range. This confirms I’m inside a local network behind a router.

---

### 2️⃣ Reachability

Command:
ping google.com

Observation:  
Latency was around 20–30 ms. No packet loss.  
This tells me basic connectivity and DNS resolution are working.

---

### 3️⃣ Path Check

Command:
traceroute google.com


Observation:  
First hop is my local router. Then ISP hops.  
One or two hops showed slightly higher latency, which is normal across regions.

This command helps identify where delays or drops happen.

---

### 4️⃣ Listening Ports

Command:
ss -tulpn


Observation:  
Found SSH listening on port 22.  
This confirms the SSH service is active and waiting for connections.

---

### 5️⃣ Name Resolution

Command:
dig google.com


Observation:  
Resolved to a public IP address.  
This confirms DNS is functioning correctly.

---

### 6️⃣ HTTP Check

Command:
curl -I https://google.com


Observation:  
Received `HTTP/2 200` status.  
That means the server is reachable and responding successfully.

---

### 7️⃣ Connection Snapshot

Command:
netstat -an | head


Observation:  
I could see LISTEN and ESTABLISHED states.  
LISTEN means the service is waiting.  
ESTABLISHED means an active connection exists.

---

## Mini Task – Port Probe & Interpretation

Identified listening port:
SSH on port 22

Tested with:
nc -zv localhost 22


Result:  
Connection succeeded.

If it had failed, next checks would be:
- `systemctl status ssh`
- Firewall rules (`ufw status` or security group settings if cloud)

---

## Reflection

### Which command gives the fastest signal when something is broken?

For me, it’s:
- `ping` → Quick connectivity check  
- `curl -I` → Fast way to verify if a web service is alive  

They immediately tell me whether the issue is network-level or application-level.

---

### If DNS fails, which layer to inspect?

Application layer first (DNS service), then check Internet layer if resolution works but routing fails.

---

### If HTTP 500 appears?

That’s Application layer.  
Networking is fine. The issue is server-side (application or backend service).

---

### Two Follow-up Checks in a Real Incident

1. Check logs (`/var/log/`, application logs)
2. Verify firewall rules and security groups

---

## Learn in Public

Today I practiced real troubleshooting commands like `ping`, `traceroute`, `ss`, `dig`, and `curl`.

Interesting finding:  
`curl -I` is the fastest way to confirm if a web service is alive without loading the full page.

Networking feels much less abstract now.


![alt text](<Screenshot 2026-02-11 165231.png>)
![alt text](<Screenshot 2026-02-11 165138.png>)
![alt text](<Screenshot 2026-02-11 165000.png>)