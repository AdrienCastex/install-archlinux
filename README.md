Common personnal ArchLinux env install

# How to install

Just run:

`bash init.sh` => init system [AS ROOT]

# Description of other scripts

`bash scripts/config-install.sh` => install the updatable scripts (i3 config, custom scripts, ...)

`bash scripts/config-save.sh` => save the updatable scripts (copy the files/folders from the current system into this repository)

`bash install-software.sh` => install all packages and setup the env [AS USER]; is run by `init.sh`

