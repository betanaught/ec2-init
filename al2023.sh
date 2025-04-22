#!/usr/bin/env bash

sudo dnf upgrade --releasever=latest -y
sudo dnf update --releasever=latest -y

################################################################################
# oh-my-bash / colorization                                                    #
################################################################################

bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended
# ADD TO PYTHON VENV AREA:
# OMB_PROMPT_CONDAENV_FORMAT="(%s) "
# EDIT: .oh-my-bash/themes/font/font.theme.sh
# python_venv=$_omb_prompt_bold_red$python_venv

# To correct Emacs if not using Dracula theme:
# cat <<EOT >> ~/.bashrc
# export TERM=xterm-color
# export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
# export CLICOLOR=1
# export LSCOLORS=ExFxCxDxBxegedabagacad
# EOT

################################################################################
# Emacs                                                                        #
################################################################################

# https://elpa.gnu.org/packages/gnu-elpa-keyring-update.html
curl https://elpa.gnu.org/packages/gnu-elpa-keyring-update-2022.12.1.tar \
  -o ~/gnu-elpa-keyring-update-2022.12.1.tar
# (M-x package-install-file ./gnu-elpa-keyring-update-2022.12.1.tar)
echo '(package-install-file "~/gnu-elpa-keyring-update-2022.12.1.tar")' \
  >> ~/.emacs
# (M-x package-refresh-contents)
echo '(package-install `dracula-theme)' >> ~/.emacs
echo '(load-theme `dracula)' >> ~/.emacs

################################################################################
# Docker                                                                       #
################################################################################

sudo groupadd docker
sudo usermod -aG docker $(whoami)
# This is better, but does not work on AL2023:
# sudo usermod -aG docker $USER
newgrp docker

################################################################################
# miniforge                                                                    #
################################################################################

curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh -b
source ~/miniforge3/etc/profile.d/conda.sh
source ~/miniforge3/etc/profile.d/mamba.sh
conda install argcomplete
echo 'eval "$(register-python-argcomplete conda)"' >> .bashrc

################################################################################
# Spack                                                                        #
################################################################################

git clone --depth=2 --branch=releases/v0.23 https://github.com/spack/spack.git ~/spack
. ~/spack/share/spack/setup-env.sh

################################################################################
#                                                                     #
################################################################################

################################################################################
#                                                                     #
################################################################################
