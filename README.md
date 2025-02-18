# 🐧 Raspberry Pi Reset Script

A powerful and safe bash script for resetting your Raspberry Pi, with multiple reset levels and built-in confirmation checks!

---

## 🚀 Features

✨ **Choose how you want to reset your Pi:**  
1️⃣ **Clear Caches**  
- Frees up disk space by removing system caches, logs, and temporary files.  

2️⃣ **Remove User Files**  
- Deletes all files and packages that didn’t come with the original Raspberry Pi OS installation.  

3️⃣ **Reset System Configurations**  
- Resets system settings, SSH keys, and hostname while keeping personal files intact.  

4️⃣ **Full Factory Reset (Without Reflashing)**  
- Completely resets the system to a near-original state, removing all data and configurations.  

⚠️ **Each action requires confirmation, with additional safety measures for destructive operations.**

---

## 🛠️ Installation

1️⃣ **Download the script**

```
wget https://raw.githubusercontent.com/IlumCI/Raspi-reset/main/raspi-reset.sh
```

2️⃣ Make the script executable
```
chmod +x raspi-reset.sh
```
3️⃣ Run the script
```
sudo ./raspi-reset.sh
```

---

📋 Usage

The script presents a menu with four reset levels:

👉 Full factory reset requires a final confirmation:
Type RESET to confirm and proceed.


---

🛡️ Safety Measures

✅ Each reset action prompts for confirmation.
✅ The full factory reset requires a final confirmation step.
✅ Avoids accidental data loss or misclicks.


---

🐛 Troubleshooting

If you encounter any issues, try:
```
sudo apt update && sudo apt upgrade -y
```
Ensure you have the latest version of Raspberry Pi OS and necessary packages installed.


---

🤝 Contributing

Feel free to fork this repository, submit issues, or create pull requests for improvements!


---

📜 License

This project is licensed under the MIT License — see the LICENSE file for details.



⚠️ Disclaimer

⚠️ Use this script at your own risk.
While it’s designed with safety in mind, you are responsible for your data and system integrity.
Always back up your important files before performing destructive operations.
