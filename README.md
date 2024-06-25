<h1 align="center">UNIT3D Community Edition Installer</h1>

<p align="center">
    🎉<b>A Big Thanks To All Our <a href="https://github.com/HDInnovations/UNIT3D-Community-Edition/graphs/contributors">Contributors</a> and <a href="https://github.com/sponsors/HDVinnie">Sponsors</a></b>🎉
</p>

<p align="center"><b>NOTE: This only works for a fresh server with nothing on it but a new OS install!</b></p>

## This Repository
Installer for the [UNIT3D-Community-Edition](https://github.com/HDInnovations/UNIT3D-Community-Edition).

**Officially Supported OS's**
- Ubuntu 22.04 LTS (Jammy Jellyfish)
- Ubuntu 20.04 LTS (Focal Fossa)

**Unstable WIP**
- Ubuntu 24.04 LTS (Noble Numbat)


**We offer install and tuning services for a small price if not comfortable installing and tuninng server yourself. Otherwise if want to install yurself run commannd below.**

**To install run the following:** (and follow the instructions. must be a fresh deicated server with nothing on it besides supported OS. Also must have a proper valid domain pointing to your server IP via A RECORD and CNAME for www)
```
sudo apt -y install git
git clone https://github.com/HDInnovations/UNIT3D-Installer.git installer
cd installer
sudo ./install.sh
```

**NOTE: If you are running UNIT3D-Community-Edition on a non HTTPS instance you MUST change the following configs.**
```
.env  <-- SESSION_SECURE_COOKIE must be set to false
config/secure-headers.php   <-- HTTP Strict Transport Security must be set to false
config/secure-headers.php   <-- Content Security Policy must be disabled
```

### Suggestions and/or Bug Reporting
We encourage the use of [GitHub Issues](https://github.com/HDInnovations/UNIT3D-INSTALLER/issues/new)!
