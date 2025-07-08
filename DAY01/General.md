```
curl -i
```
It shows **response header and body**.
`-i` means: Include the HTTP **response headers** in the output.

![alt text](image.png)

---

```
curl -I
```
It shows only **response header**.
It uses **HTTP HEAD** request instead of **GET**.
`-I` means: Fetch the **headers** only.

![alt text](image-1.png)

---

### **How DNS works??**

```
First, we purchase a domain from Hostinger. After completing the payment, we want to host the domain on AWS.
To host it on AWS, we use Route 53. We create a Public Hosted Zone in Route 53 with the same domain name.
This automatically creates NS and SOA records.
We copy the Name Servers (NS) and update them in Hostinger's domain settings to point to AWS.
Then we create an A record in Route 53 to map the domain to the IP address of our server (EC2, ELB, etc).
```

- **Purchase Domain:**
  You purchase a domain (e.g., example.com) from a domain registrar like Hostinger.

- **Create Public Hosted Zone in Route 53:**
  In AWS Route 53, create a Public Hosted Zone using the exact same domain name (e.g., example.com).

- **Update Name Servers in Hostinger:**
  When you create the hosted zone, AWS Route 53 automatically creates NS (Name Server) and SOA records.
  Copy the NS record values (the AWS nameservers like ns-123.awsdns-45.com) and go to Hostinger → domain management → replace Hostinger nameservers with AWS Route 53 nameservers.

- **Create A Record in Route 53:**
  In the hosted zone, create an A record (e.g., for example.com or www.example.com) pointing to your server's public IP or Load Balancer DNS, depending on what you're hosting.

```
https://joindevops.medium.com/how-dns-work-30ef4ba6762c
```