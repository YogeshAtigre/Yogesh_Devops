##############################################################################################################################
1)
Absolutely! Here's an **interview-ready**, **scenario-based answer** for performance troubleshooting on a Linux server, along with commands and why they're used. 🔍💻

---

## 🧠 Scenario: Server is Running Slowly

You’ve noticed performance degradation. Here’s a **step-by-step** approach to **identify and resolve** the bottleneck.

---

## 🔍 Step-by-Step Troubleshooting

### 🔸 1. **Check CPU Usage**
- **Command**: `top` or `htop`
  
```bash
top
```
> Shows real-time CPU usage by processes. Identify high CPU-consuming tasks.

🔸 **Look for**:
- High `%us` (user processes)
- High `%sy` (system/kernel processes)
- High `%wa` (I/O wait → potential disk bottleneck)

---

### 🔸 2. **Check Memory Usage**
- **Command**: `free -h`, `vmstat`, or `top`

```bash
free -h
vmstat 1 5
```
> Shows total, used, and available memory. Look for swap usage, which indicates memory pressure.

---

### 🔸 3. **Check Disk I/O**
- **Command**: `iostat`, `iotop`, or `dstat`

```bash
iostat -xz 1
```
> See how busy disks are. Look for high `await` or `%util` values → potential disk bottleneck.

---

### 🔸 4. **Check Disk Space**
- **Command**: `df -h`, `du -sh *`

```bash
df -h
du -sh /var/*
```
> Full disks can slow performance. Clean up large logs or temporary files.

---

### 🔸 5. **Check Network Load**
- **Command**: `iftop`, `nload`, or `ss`

```bash
ss -tuln
iftop
```
> Identify high incoming/outgoing traffic or open network connections.

---

### 🔸 6. **Check Running Processes**
- **Command**: `ps aux --sort=-%cpu` or `top`

```bash
ps aux --sort=-%cpu | head
```
> View resource-hungry processes.

---

### 🔸 7. **Check Load Average**
- **Command**: `uptime` or `top`

```bash
uptime
```

> Gives an idea of the system load over 1, 5, and 15 minutes. A load > number of CPUs = overload.

---

## 🛠️ Resolution Strategies

| Issue Detected         | Resolution Idea                              |
|------------------------|----------------------------------------------|
| High CPU               | Restart culprit process, optimize code       |
| High Memory            | Kill heavy process, add swap, upgrade RAM    |
| High Disk I/O          | Optimize I/O-heavy services, check RAID/NFS  |
| Disk Full              | Clean `/var/log`, remove temp/old files      |
| Network Saturation     | Check for malicious traffic, rate limit      |

---

## 🧾 Interview Summary

> “If a server is slow, I begin by using `top` or `htop` to check CPU and memory. Then I use tools like `iostat`, `df -h`, and `iftop` to check disk and network. Based on what I find, I take action—whether it’s killing a process, cleaning up disk space, or adding swap. I also monitor load averages using `uptime` to correlate system stress with resources.”

---

Would you like a script or cheatsheet version of these commands for quick reference?
##############################################################################################################################
2)
Absolutely! Here's a **scenario-based explanation** that's perfect for interviews or real-world situations, focusing on **read-only access setup** in Linux using permissions. 🔐🧑‍💻

---

## 🧠 Scenario:  
A **new team member** joins and needs **read-only access** to specific files on a Linux server. You must ensure they **can view but not modify or delete** these files.

---

## 🧰 Goal:
- ✅ User can **read** the files
- ❌ User **cannot edit**, **delete**, or **add** new files
- ✅ Setup is secure and properly scoped

---

## 🧾 Step-by-Step Setup

### 🔸 1. **Create a New User (if not already created)**

```bash
sudo adduser ro_user
```
> Creates a user named `ro_user`.

---

### 🔸 2. **Create a New Group for Read-Only Access (Optional but Recommended)**

```bash
sudo groupadd readonlygrp
sudo usermod -aG readonlygrp ro_user
```
> Group makes managing multiple users with similar permissions easier.

---

### 🔸 3. **Set Group Ownership of the Target Files/Directory**

Let’s say the files are in `/opt/project/data`

```bash
sudo chown -R root:readonlygrp /opt/project/data
```
> Makes `readonlygrp` the group owner of the directory.

---

### 🔸 4. **Set Read-Only Permissions for the Group**

```bash
sudo chmod -R 750 /opt/project/data
```

| Permission | Explanation                                |
|------------|--------------------------------------------|
| `7` (Owner)| Read, Write, Execute                        |
| `5` (Group)| Read and Execute (no write)                |
| `0` (Other)| No access                                   |

> Ensures group members can read files but not modify them.

If **individual files** only need read permission:

```bash
sudo find /opt/project/data -type f -exec chmod 640 {} \;
```

---

### 🔸 5. **Verify Permissions**

```bash
ls -l /opt/project/data
groups ro_user
```
> Confirm that files have correct permissions and the user is in the proper group.

---

## 🔐 Key Considerations

| Topic                 | Details                                                                 |
|----------------------|-------------------------------------------------------------------------|
| 🔐 Group Management   | Easier than assigning permissions per user                              |
| 📁 Directory Traverse | Ensure user has `x` (execute) permission on parent directories          |
| 🚫 No Write Access    | Avoid assigning `w` (write) permission anywhere unless truly required    |
| 📌 Sticky Bit         | Not needed here, but helpful in shared writable directories             |

---

## 🗣️ Interview Summary

> "To give a user read-only access, I’d create a group, assign the user to that group, and set the directory’s group ownership and permissions accordingly. For example, using `chmod 750` ensures the group can read and execute files, but not modify them. I verify group membership and use `ls -l` to confirm proper setup. This method is scalable and secure."

---

Would you like this turned into a reusable script or a one-pager permission management guide?
##############################################################################################################################
##############################################################################################################################
##############################################################################################################################
##############################################################################################################################
##############################################################################################################################
##############################################################################################################################
##############################################################################################################################
##############################################################################################################################