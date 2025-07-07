# Use Windows Server Core with Python 3.11 pre-installed
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Install Python manually
RUN powershell -Command `
    Invoke-WebRequest -Uri https://www.python.org/ftp/python/3.11.9/python-3.11.9-amd64.exe -OutFile python-installer.exe ; `
    Start-Process -Wait -FilePath python-installer.exe -ArgumentList '/quiet InstallAllUsers=1 PrependPath=1'; `
    Remove-Item python-installer.exe -Force

# Set working directory
WORKDIR /app

# Copy source files
COPY . .

# Install dependencies (if requirements.txt exists)
RUN powershell -Command `
    if (Test-Path requirements.txt) { pip install -r requirements.txt }

# Set default command (change script.py to your main file)
CMD ["python", "script.py"]
