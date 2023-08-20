# Already on Linux? You can skip
# On Windows? Install Ubuntu on Windows Subsystem for Linux (WSL)

1. **Enable WSL**:
   - Open PowerShell as Administrator.
   - Run: `dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart`

2. **Enable Virtual Machine Feature (if needed)**:
   - Run: `dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart`

3. **Restart Your Computer**.

4. **Download and Install Ubuntu**:
   - Option 1: Use Microsoft Store:
     - Open the Microsoft Store.
     - Search for "Ubuntu."
     - Click "Install" on your preferred Ubuntu distribution (e.g., Ubuntu 20.04 LTS).
   - Option 2: Manual Download:
     - Run: `Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu.appx -UseBasicParsing`
     - Install: `Add-AppxPackage .\Ubuntu.appx`

5. **Launch Ubuntu**:
   - Search for "Ubuntu" in the Start menu.
   - Or, run `wsl` or `wsl.exe` from PowerShell or Command Prompt.

6. **Initialize Ubuntu**:
   - Create a user account and set a password when prompted.

7. **Update Ubuntu** (optional but recommended):
   - Run:
     ```bash
     sudo apt update
     sudo apt upgrade
     ```
