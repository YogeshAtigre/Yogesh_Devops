1)
To **set a user password that never expires in Linux**, you can use the `chage` command — which manages user account aging settings.

---

## ✅ Step-by-Step Guide

### 🔹 1. Set the password to never expire

```bash
sudo chage -M -1 <username>
```

- `-M` → Maximum number of days the password is valid
- `-1` → Means **no expiration**

✅ Example:
```bash
sudo chage -M -1 devuser
```

---

### 🔹 2. (Optional) Verify the change

```bash
sudo chage -l devuser
```

You’ll see:
```
Maximum number of days between password change : -1
Password expires                                  : never
```

---

## 🔒 Alternative (Shadow File Method)

You can also directly modify the **`/etc/shadow`** file (not recommended unless necessary).

Find the line for the user:

```bash
sudo nano /etc/shadow
```

Look for:
```
devuser:$6$...:19234:0:99999:7:::
```

Change the 5th field (password max age) to **99999** or higher to simulate no expiration.

---

## 🧠 Interview-Ready Answer

> “To prevent a user’s password from expiring, I use `chage -M -1 <user>` which disables the password aging. This is useful for service accounts or automation users where password rotation isn’t practical but still requires secure practices.”

---

Would you like this saved in your Linux Administration notes as `password-never-expire.md`?
################################################################################################
2)
Great question — this touches on **core Linux system architecture** and is often asked in **SysAdmin or DevOps interviews**. Let’s break it down:

---

## 📘 What is `/etc/passwd`?

The `/etc/passwd` file stores **basic user account information**.

### 🧾 Format (Colon-separated fields):
```plaintext
username:password:x:UID:GID:comment:home_directory:shell
```

### 🔍 Example:
```plaintext
john:x:1001:1001:John Doe:/home/john:/bin/bash
```

| Field        | Description                         |
|--------------|-------------------------------------|
| `username`   | Login name                          |
| `x`          | Placeholder (used to store password in `/etc/shadow`) |
| `UID`        | User ID                             |
| `GID`        | Group ID                            |
| `comment`    | User’s full name (GECOS field)      |
| `home`       | Home directory                      |
| `shell`      | Default shell                       |

> 🛡️ Passwords used to be stored directly in `/etc/passwd`, but that posed security risks.

---

## 🔐 What is `/etc/shadow`?

The `/etc/shadow` file holds **encrypted password hashes and account aging information**.

### 🧾 Format:
```plaintext
username:encrypted_password:last_change:min:max:warn:inactive:expire:reserved
```

### 🔍 Example:
```plaintext
john:$6$sdf8w...:19234:0:99999:7:::
```

| Field           | Description                         |
|------------------|-------------------------------------|
| `username`       | Same as in `/etc/passwd`            |
| `encrypted_pw`   | Hashed password (or `!`, `*`, etc.) |
| `last_change`    | Date of last password change        |
| `min`, `max`     | Minimum/maximum days between changes|
| `warn`           | Days before expiry to warn user     |
| `inactive`       | Days after expiry to deactivate     |
| `expire`         | Account expiry date                 |

> ✅ Only **root** can read `/etc/shadow`, keeping password hashes **secure**.

---

## 🚫 Why Not Merge `/etc/passwd` and `/etc/shadow`?

**Security & Separation of Concerns** are the main reasons:

| Reason                        | Explanation |
|-------------------------------|-------------|
| 🔐 **Security**               | `/etc/passwd` is world-readable (`-rw-r--r--`). If it included password hashes, attackers could easily extract and brute-force them. |
| ⚙️ **Modular Management**     | Keeping password and user info separate allows tools (e.g. `passwd`, `chage`, `usermod`) to handle account and password aging independently. |
| 📂 **System Design Best Practice** | Unix philosophy encourages single-purpose files — `/etc/passwd` for user info, `/etc/shadow` for security credentials. |

---

## 🧠 Interview-Ready Answer

> “`/etc/passwd` holds basic user account info, and `/etc/shadow` stores encrypted passwords and aging policies. They’re separated for security reasons — `/etc/passwd` is world-readable, while `/etc/shadow` is root-only. This design prevents unauthorized access to password hashes and allows better management of account policies.”

---

Would you like me to save this as a Markdown file (`linux-passwd-shadow-explained.md`) in your Linux notes collection?
###############################################################################################
3) Absolutely! `lsof` is one of the most powerful and frequently used troubleshooting tools for Linux system administrators and DevOps engineers.

---

## 🔍 What is `lsof`?

> `lsof` stands for **List Open Files**.

In Linux/Unix, **everything is a file** — files, sockets, pipes, devices, etc.  
`lsof` shows **which files are opened by which processes**.

---

## ✅ Common Use Cases of `lsof`

| Command | Description |
|--------|-------------|
| `lsof` | Lists **all open files** |
| `lsof -u <user>` | Lists files opened by a specific **user** |
| `lsof -p <PID>` | Lists files opened by a specific **process ID** |
| `lsof -i :80` | Shows processes using **port 80** |
| `lsof /path/to/file` | See which process is using a specific **file** |
| `lsof +D /dir/path` | Lists all files opened under a **directory** |

---

## 📌 How to List All Files Opened by a Particular PID

```bash
lsof -p <PID>
```

✅ Example:
```bash
lsof -p 1234
```

> This will output a list of all file descriptors (including logs, libraries, sockets, etc.) used by process ID `1234`.

---

## 🧪 Sample Output

```bash
COMMAND   PID USER   FD   TYPE DEVICE SIZE/OFF    NODE NAME
nginx    1234 root  cwd    DIR  253,0     4096       2 /
nginx    1234 root  txt    REG  253,0  1035048  183513 /usr/sbin/nginx
nginx    1234 root  mem    REG  253,0   135168  135431 /lib/x86_64/libnss.so
nginx    1234 root   10u  IPv4  40532      TCP *:80 (LISTEN)
```

---

## 🛠️ Filter Specific FD Types

| FD Type | Meaning |
|---------|---------|
| `cwd`   | Current working directory |
| `txt`   | Executable text (program) |
| `mem`   | Memory-mapped files |
| `u`     | File is open for reading & writing |
| `r`     | Read-only |
| `w`     | Write-only |

---

## 🔒 Permissions

You may need **root/sudo** to view files opened by processes that aren't owned by your user.

```bash
sudo lsof -p 1234
```

---

## ✅ Interview-Ready Answer

> "`lsof` is a tool to list open files in Linux. Since everything is treated as a file, it helps diagnose issues related to file descriptors, locked files, or ports. To view open files by a specific process, I use `lsof -p <PID>`, which shows logs, network sockets, memory maps, and more associated with that process."

---

Would you like me to save this as `lsof-command.md` in your Linux notes collection?
###############################################################################################
4)
Great question! The **kernel routing table** holds the paths the Linux kernel uses to forward network packets — it's a key part of networking diagnostics.

---

## 🧠 How to Check the Kernel Routing Table in Linux

### 🔹 1. **Using `ip route` (Modern & Recommended)**

```bash
ip route show
```

**Output Example:**
```
default via 192.168.1.1 dev eth0 proto dhcp metric 100
192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.100
```

📌 This shows:
- Default gateway
- Network routes
- Associated interfaces

👉 To see routes for IPv6:
```bash
ip -6 route show
```

---

### 🔹 2. **Using `route` (Legacy, still common)**

```bash
route -n
```

**Output Example:**
```
Kernel IP routing table
Destination  Gateway      Genmask        Flags Metric Ref Use Iface
0.0.0.0      192.168.1.1  0.0.0.0        UG    100    0   0   eth0
192.168.1.0  0.0.0.0      255.255.255.0  U     0      0   0   eth0
```

- `UG` = Up & Gateway
- `U`  = Up (directly connected)

> 📝 Note: `route` comes from the `net-tools` package which is deprecated in favor of `iproute2`.

---

### 🔹 3. **Using `netstat` (Also from `net-tools`)**

```bash
netstat -rn
```

- `-r` = Routing table
- `-n` = Show numeric addresses (no DNS)

---

### 🔹 4. **To Watch Route Changes Live**

```bash
ip monitor route
```

This will display real-time updates to the routing table.

---

### ✅ Interview-Ready Answer

> “To check the kernel routing table, I use `ip route show`, which is the modern replacement for older tools like `route -n` or `netstat -rn`. It gives a clean view of the system's routing decisions. For live monitoring, I use `ip monitor route`.”

---

Would you like me to save this as `check-kernel-routing-table.md` in your Linux/networking notes?
###############################################################################################
5)
Great question! Sticky bit, along with the `'s'` and `'S'` permission bits, is a common Linux/Unix topic, especially in **file permissions and secure directory management**.

---

## 🧠 What is the Sticky Bit?

### 🔹 Sticky Bit (`t`)
- **Purpose**: Restricts file deletion in a directory.
- **Effect**: 
  - Only the **file owner**, the **directory owner**, or **root** can delete or rename files within that directory — even if others have write permissions.

### 📌 Real-World Use:
Most commonly used on `/tmp`, which is **world-writable** but protected with sticky bit:
```bash
drwxrwxrwt  10 root root 4096 Apr  9 15:25 /tmp
```
Note the **`t`** at the end (`rwt`) — that’s the sticky bit.

---

## ✅ How to Set the Sticky Bit

### 1. Symbolic method:
```bash
chmod +t /my/dir
```

### 2. Numeric method:
```bash
chmod 1777 /my/dir
```

- The **1** at the front sets the sticky bit
- 777 = full permissions

---

## 🔍 What's the Difference Between `'s'` and `'S'`?

These apply to **SetUID** and **SetGID** bits.

| Symbol | Meaning                            | Applies To | Requires Execute |
|--------|-------------------------------------|------------|------------------|
| `s`    | **SetUID/SetGID bit is set** *and* execute bit is also set | user/group | ✅ Yes |
| `S`    | **SetUID/SetGID bit is set** but execute bit is **missing** | user/group | ❌ No  |

---

### 🧪 Examples:

```bash
-rwsr-xr-x 1 root root 12345 /usr/bin/passwd
```
- `s` in user position → **SetUID is active**, and file is executable

```bash
-rwSr--r-- 1 root root 12345 somefile
```
- `S` in user position → **SetUID is set**, but file is **not executable**, so the bit is basically ineffective

---

## ✅ Summary

| Bit         | Description                                                 | Set On     | Symbol | Example        |
|-------------|-------------------------------------------------------------|------------|--------|----------------|
| **Sticky**  | Only file owner can delete/rename files in a dir            | Directory  | `t`/`T`| `/tmp`         |
| **SetUID**  | Run file with **owner’s privileges**                        | Files      | `s`/`S`| `/usr/bin/passwd` |
| **SetGID**  | Run file with **group’s privileges** or set group on files  | Files/Dirs | `s`/`S`| group-shared dir |

---

## ✅ Interview-Ready Answer

> “The sticky bit is used on directories to prevent users from deleting each other’s files — common on `/tmp`. The `s` and `S` characters refer to SetUID or SetGID permissions. A lowercase `s` means the bit is set and the file is executable, while an uppercase `S` means the bit is set but the file is not executable, which may indicate a misconfiguration.”

---

Would you like this saved in a Markdown file (`sticky-bit-and-special-permissions.md`) for your Linux notes?
###############################################################################################
6)
###############################################################################################
7)
###############################################################################################
###############################################################################################
###############################################################################################
###############################################################################################
###############################################################################################
###############################################################################################
###############################################################################################
###############################################################################################