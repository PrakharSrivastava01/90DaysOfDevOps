Day-04 – Linux Fundamentals (Hands-On Practice)
🎯 Goal

To practice core Linux fundamentals by running real commands, observing system behavior, and understanding basic troubleshooting steps.


🔹 1. Check Running Processes:-
    
     Command used:-
        
   >> ps aux 

  Observation:

Displays all running processes on the system

Shows user, PID, CPU usage, memory usage, and command name

    Useful command:-
 
  >> top 
    
  Observation:

Shows live system performance

Helps identify high CPU or memory consuming processes.

Why this matters:
Used daily to monitor applications, detect stuck processes, and troubleshoot performance issues.


🔹 2. Inspect a systemd Service:-

    Command used:-

  >> systemctl status ssh ((or nginx, docker, jenkins depending on availability))

    Observation:

Observation:

Shows whether the service is active, inactive, or failed

Displays service start time and recent logs

    Additional commands:-

   >> systemctl list-units --type=service

Why this matters:
Helps verify if critical services are running properly on a Linux server.


🔹 3. Simple Troubleshooting Flow:-

   Scenario:

Checking why an application/service is not accessible.

 ** Step 1: Check if process is running **

  >> ps aux | grep nginx 

 ** Step 2: Check service status **

 >> systemctl status nginx

 ** Step 3: Check if port is listening **

 >> ss -tulnp | grep 80

 ** Step 4: Check logs **

 >> tail -f /var/log/nginx/error.log


 
 Observation:

Identified whether service is running

Verified port availability

Inspected logs for errors

📌 Why this matters:
This basic flow is used in real production troubleshooting.  









































