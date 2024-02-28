# Configurations

<!--toc:start-->
- [Configurations](#configurations)
  - [Windows](#windows)
    - [Scoop](#scoop)
    - [Oh my posh](#oh-my-posh)
    - [PowerShell](#powershell)
    - [Rancher Desktop](#rancher-desktop)
    - [Microsoft PowerToys](#microsoft-powertoys)
    - [Visual Studio 2022](#visual-studio-2022)
    - [Windows Terminals](#windows-terminals)
      - [Wezterm](#wezterm)
      - [Windows Terminal](#windows-terminal)
    - [Windows Text Editors](#windows-text-editors)
      - [NeoVim](#neovim)
        - [Rust Setup](#rust-setup)
      - [Helix](#helix)
        - [Rust](#rust)
        - [C#](#c)
        - [JSON](#json)
        - [YAML](#yaml)
        - [Markdown](#markdown)
    - [Lazygit](#lazygit)
  - [WSL2](#wsl2)
    - [Install](#install)
    - [Map to drive](#map-to-drive)
  - [Linux Arch / Manjaro](#linux-arch-manjaro)
    - [Zsh](#zsh)
    - [Yay Package Manager](#yay-package-manager)
    - [Enable SSH](#enable-ssh)
    - [Oh my posh linux](#oh-my-posh-linux)
    - [Linux Text Editors](#linux-text-editors)
      - [NeoVim-nightly](#neovim-nightly)
    - [Linux Terminals](#linux-terminals)
      - [Wezterm terminal](#wezterm-terminal)
    - [Dotnet](#dotnet)
    - [Lazygit CLI](#lazygit-cli)
    - [Docker](#docker)
    - [Kubectl](#kubectl)
<!--toc:end-->

## Windows

### Scoop

Scoop is a package manager (like Chocolatey)

    Set-ExecutionPolicy RemoteSigned -Scope CurrentUse # Optional: Needed to run a remote script the first time
    irm get.scoop.sh | iex

### Oh my posh

Oh my posh is used to customize prompt in your terminal

    scoop bucket add main
    scoop install main/oh-my-posh

Download and install the nerd font. [Caskaydia Cove Nerd Font Complete](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.zip) looks nice.

Init powershell profile

    New-Item -Path $PROFILE -Type File -Force

Modify newly created file by appending **oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/multiverse-neon.omp.json" | Invoke-Expression**

    notepad $PROFILE

### PowerShell

PowerShell is the .NET Core version of PowerShell (compared to WindowsPowerShell which runs on .NET Framework)

    scoop install main/pwsh

### Rancher Desktop

Rancher desktop is used to locally work with k8s and docker. It's good open source replacement for Docker Desktop.

    scoop install extras/rancher-desktop

### Microsoft PowerToys

[Microsoft PowerToys](https://apps.microsoft.com/store/detail/microsoft-powertoys/XP89DCGQ3K6VLD) add a lot of nice functionalities to windows.

    scoop install extras/powertoys

Run the app:

- **Keyboard Manager** tab - remap **Caps Lock** to **Esc**
- **FancyZones** tab - setup window tiling to desired

### Visual Studio 2022

IDE for .NET development

Visual studio configuration can be found in **vs-2022** subfolder.

### Windows Terminals

#### Wezterm

Terminal written in Rust

    scoop install extras/wezterm

#### Windows Terminal

Windows Terminal is terminal created by Microsoft.

    scoop bucket add extras
    scoop install extras/windows-terminal

Windows Terminal configuration can be found in **windows-terminal** subfolder.

### Windows Text Editors

#### NeoVim

Text editor which can be used as IDE with a lot of configuration, but more mature than Helix

    scoop install main/neovim
    scoop install main/make
    scoop install main/mingw
    scoop install main/ripgrep
    scoop install main/python
    scoop install nodejs-lts

For initial setup we use LazyVim

    git clone https://github.com/LazyVim/starter $env:LOCALAPPDATA\nvim

Copy configuration files form **neovim** directory to %appdata%\nvim

Open neovim and wait for Lazy to install the plugins, after which quit neovim and reopen

    neovim

##### Rust Setup

Install better test runner

    cargo install cargo-nextest --locked

#### Helix

Helix is a text editor which can be used as IDE with minimal setup.

    scoop install helix

Helix configuration can be found in **helix-editor** subfolder.

##### Rust

Configure Helix language server and debugger for Rust

    scoop install main/rust-analyzer
    scoop install main/llvm

NOTE: This assumes Rust tooling and C++ tooling is previously installed

##### C#

Configure Helix language server and debugger forC#

    scoop bucket add versions
    scoop install versions/omnisharp-net6
    scoop install main/netcoredbg
    scoop shim add netcoredbg ~\scoop\apps\netcoredbg\current\netcoredbg.exe

NOTE: This assumes .NET Core SDK and tooling is previously installed

##### JSON

Language server covers JSON and HTML

    npm i -g vscode-langserers-extracted

##### YAML

Language server for YAML

    npm i -g yaml-language-server@next

##### Markdown

Language server for markdown

    scoop install main/marksman

### Lazygit

Lazy git is command line git tool

    scoop install extras/lazygit

## WSL2

### Install

Install WSL (will install Ubuntu distro by default)

    wsl --install

Install Arch Linux distro

    scoop install extras/archwsl

Remove Ubuntu distro

    wsl --unregister Ubuntu

Open wsl (if arch is not main distro type Arch.exe instead)

    wsl

Set the root password

    passwd

Setup default user

    echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
    useradd -m -G wheel -s /bin/bash {username} 

Set user password

    passwd {username}

Add user to sudoers

    sudo usermod -aG wheel {username}
    exit

Set default user

    Arch.exe config --default-user {username}

Initialize key ring

    sudo pacman-key --init
    sudo pacman-key --populate
    sudo pacman -Sy archlinux-keyring
    sudo pacman -Su

(Optional) Edit wsl.config to run sshd on startup

    sudo nano /etc/wsl.conf

Add/modify following under [boot]. Start ssh server on boot

    command="/usr/bin/sshd"

### Map to drive

In windows explorer right click on **This PC** (or **Network**) tab and select **map network drive..**  
Select drive letter and in folder type **\\wsl$\Arch**  
Select Finish

## Linux Arch / Manjaro

### Zsh

    sudo pacman -S zsh

### Yay Package Manager

Yay package manager is needed for installing packages from AUR repository.

First refresh the package cache and update system

    sudo pacman -Syu

Install *base-devel* and *git*

    sudo pacman -S --needed base-devel git

Clone yay git repo

    git clone https://aur.archlinux.org/yay.git

Switch dir to yay

    cd yay

Install yay

    makepkg -si

Remove git repo

    rm -r yay -f

### Enable SSH

Whole reason for enabling ssh is to be able to have **undercurls** by using wezterm ssh instead of wsl directly (ConPty removes all underlines which is annoying)

Arch doesn't have ssh pre installed

    yay -S openssh

Copy existing (generate and copy) %userprofile%/.ssh/id_rsa.pub key contents to ~/.ssh/authorized_keys

    mkdir -p ~/.ssh
    nano ~/.ssh/authorized_keys

Copy id_rsa.pub key contents

    sudo chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys

Generate host keys

    sudo ssh-keygen -A

Open sshd config

    sudo nano /etc/ssh/sshd_config

Append/modify the following to the sshd_config file

    AllowUsers {username}
    Port 2222

Fix PAM rule to allow ssh for non root

    sudo nano /etc/pam.d/sshd

Prepend following lines

    account [success=done default=ignore] pam_succeed_if.so quiet user ingroup wheel
    account required     pam_nologin.so

Start manually

    sudo /usr/bin/sshd

Reboot

    sudo reboot

### Oh my posh linux

Install oh-my-posh

    yay -S oh-my-posh

Edit ~/.zshrc

    sudo nano ~/.zshrc

Copy and paste **./oh_my_posh_themes** directory to **~** (or get from [github](https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/))

Add theme

    eval "$(oh-my-posh init zsh --config ~/oh_my_posh_themes/multiverse-neon-custom.omp.json)"

Refresh zsh

    exec zsh

### Linux Text Editors

#### NeoVim-nightly

Install neovim-nightly and dependencies

    yay -S neovim-git
    yay -S ripgrep
    yay -S python
    yay -S nodejs
    yay -S unzip

For initial setup we use LazyVim

    git clone https://github.com/LazyVim/starter ~/.config/nvim
    rm -rf ~/.config/nvim/.git

Copy configuration files form **neovim** directory to ~/.config/nvim

Open neovim and wait for Lazy to install the plugins, after which quit neovim and reopen

    neovim

### Linux Terminals

#### Wezterm terminal

Terminal written in Rust

    yay -S wezterm
    yay -S wezterm-terminfo

Add TERM=wezterm to /etc/environment

    sudo nvim /etc/environment

Add TERM=wezterm and save

### Dotnet

Install latest dotnet

    yay -S dotnet-sdk

### Lazygit CLI

Install lazygit

    yay -S lazygit

### Docker

Instal docker

    yay -S docker

### Kubectl

Install kubectl

    yay -S kubectl
