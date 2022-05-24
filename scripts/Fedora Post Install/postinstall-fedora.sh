#!/bin/bash
#
# POSTINSTALL SCRIPT para FEDORA (versiones 15 en adelante)
# Reynaldo R. martinez P.
# Diciembre 22 2014
#

PATH=$PATH:/bin:/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin
 
echo ""
echo "Instalar RPM Fusion:"
dnf -y install --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
echo "Listo.."

echo ""
echo "Actualizar RPM Fusion:"
dnf -y update --nogpgcheck rpmfusion*
echo "Listo.."

dnf -y update
 
echo ""
echo "Instalar los paquetes:"
echo ""
 
mylist='
	yumex
	gconf-editor
	control-center-extra
	alacarte
	pidgin
	amarok*
	xine-*
	gtweakui*
	plymouth*
	lsb
	vim
	dkms
	dpkg
	leonidas-*
	kdebase-workspace-wallpapers
	kdeartwork-wallpapers
	kmenu-gnome games-menus
	multimedia-menus
	unace
	unrar
	mplayer-*
	vlc-*
	mencoder
	kplayer
	gnome-tweak-tool
	dconf-editor
	remmina*
	cups-pdf
	thunderbird
	thunderbird-lightning
	gstreamer-plugins-*
	gstreamer1-plugins-*
	libtxc_dxtn
	pidgin*
	linux_logo
	wine-*
	pulseaudio-*
	gnome-shell-extension-common
	gnome-shell-extension-places-menu
	gnome-shell-extension-apps-menu
	gnome-shell-extension-drive-menu
	gnome-shell-extension-gpaste
	gnome-shell-extension-user-theme
	gnome-shell-extension-pidgin
	sound-theme-*
	gnome-themes-legacy
	k3b-extras-freeworld
	celestia
	stellarium
	k9copy
	ghex
	lzop
	pbzip2
	procinfo
	ghasher
	dstat
	paman
	pavucontrol
	gparted
	pavumeter
	paprefs
	nmap-frontend
	iotop
	lha
	isomaster
	tzclock
	arc
	galternatives
	bzip2
	rdesktop
	freerdp
	mc
	arj
	cabextract
	p7zip
	p7zip-plugins 
	klamav 
	hddtemp 
	kdeadmin 
	mikmod 
	kchmviewer 
	nautilus-pastebin 
	nautilus-sound-converter 
	nautilus-actions 
	nautilus-open-terminal 
	Thunar 
	thunar 
	cinnamon-* 
	nemo 
	nemo-extensions 
	nemo-terminal 
	samba 
	mate-* 
	hdparm 
	openldap-clients 
	lm_sensors 
	grub2-starfield-theme 
	lynx 
	dia-electronic 
	dia-optics 
	dia 
	dia-CMOS 
	dia-Digital 
	dia-gnomeDIAicons 
	dia-electric2 
	pencil
	powerline
	vim-plugin-powerline
	tmux-powerline
	gtk-recordmydesktop
	python-pip
	postgresql
	mariadb
	kernel-devel
	kernel-headers
	docker
	docker-vim
	docker-selinux
	docker-utils
	cowsay
	fortune-mod
'
for i in $mylist
do
	echo "Instalando $i"
	dnf -y install \
		--enablerepo=rpmfusion-free \
		--enablerepo=rpmfusion-free-updates \
		--enablerepo=rpmfusion-nonfree \
		--enablerepo=rpmfusion-nonfree-updates \
		$i
done

# BUSCAR CLIENTES LDAP

echo "Listo.."
echo ""
echo "Aplicando Updates"
dnf -y update --nogpgcheck
echo ""
echo "Listo.."

echo ""
echo "Reaplicando GRUB"
grub2-mkconfig -o /boot/grub2/grub.cfg
echo "Listo.."

echo ""
echo "Instalando FLASH Plugin"

myarch=`uname -m`
case $myarch in
x86_64)
	dnf -y install --nogpgcheck adobe-release-x86_64-1.0-1.noarch.rpm
	;;
*)
	dnf -y install --nogpgcheck adobe-release-i386-1.0-1.noarch.rpm
	;;
esac

dnf -y update

dnf -y install flash-plugin

echo "Instalando WINETRICKS"

wget -O /usr/local/bin/winetricks http://winetricks.org/winetricks
chmod 755 /usr/local/bin/winetricks

echo "Instalando Lenguajes Adicionales"

dnf -y install dnf-langpacks
dnf -y langinstall es_VE

echo "Instalando TUNED"

dnf -y install tuned tuned-utils tuned-gtk
systemctl enable tuned
systemctl start tuned
tuned-adm profile desktop

echo "Instalando Soporte Highlight para less"

dnf -y install source-highlight

export LESSOPEN="| /bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

echo "export LESSOPEN=\"| /bin/src-hilite-lesspipe.sh %s\"" > /etc/profile.d/less-hl.sh
echo "export LESS=' -R '" >> /etc/profile.d/less-hl.sh

echo "Ajustando perfil de bash"

echo "export EDITOR=vim" > /etc/profile.d/fedora-extraprofile.sh
echo "alias vi='vim'" >> /etc/profile.d/fedora-extraprofile.sh
echo "alias dmesg='dmesg -T'" >> /etc/profile.d/fedora-extraprofile.sh

echo "if [ -f \`which powerline-daemon\` ]; then" > /etc/profile.d/powerline-profile.sh
echo "  powerline-daemon -q" >> /etc/profile.d/powerline-profile.sh
echo "  POWERLINE_BASH_CONTINUATION=1" >> /etc/profile.d/powerline-profile.sh
echo "  POWERLINE_BASH_SELECT=1" >> /etc/profile.d/powerline-profile.sh
echo "  . /usr/share/powerline/bash/powerline.sh" >> /etc/profile.d/powerline-profile.sh
echo "fi" >> /etc/profile.d/powerline-profile.sh


# fedora24=`grep -c 24 /etc/fedora-release`
fedorarelease=`lsb_release -r|grep -i release:|awk '{print $2}'`

case $fedorarelease in
24|25|26|27|28|29|30)
	echo "" >> /etc/vimrc
	echo "source /usr/share/vim/vimfiles/plugin/powerline.vim" >> /etc/vimrc
	echo "set laststatus=2" >> /etc/vimrc
	echo "set t_Co=256" >> /etc/vimrc
	;;
*)
	echo "" >> /etc/vimrc
	echo "python from powerline.vim import setup as powerline_setup" >> /etc/vimrc
	echo "python powerline_setup()" >> /etc/vimrc
	echo "python del powerline_setup" >> /etc/vimrc
	echo "set laststatus=2" >> /etc/vimrc
	echo "set t_Co=256" >> /etc/vimrc
	;;
esac

echo "source \"/usr/share/tmux/powerline.conf\"" > /etc/tmux.conf
echo "set -g terminal-overrides 'xterm*:smcup@:rmcup@'" >> /etc/tmux.conf
echo "set -g status-style bg=blue" >> /etc/tmux.conf
echo "set -g status on" >> /etc/tmux.conf

echo "/usr/bin/fortune | /usr/bin/cowsay" > /etc/profile.d/fortune-cowsay.sh

sed -r -i 's/ls --color=auto/ls --color=auto -F/g' /etc/profile.d/colorls.sh

echo ""
echo "Instalando awscli via PIP"
dnf -y install python-pip
pip install awscli

echo ""
echo "Preparando ambiente Docker"

systemctl enable docker.service
systemctl start docker.service

docker pull busybox:latest
docker pull ubuntu:latest
docker pull debian:latest
docker pull debian:wheezy
docker pull centos:latest
docker pull centos:6
docker pull fedora:latest

echo ""
echo "Instalando OpenStack Python Client"

dnf -y install python-devel
dnf -y install python3-devel
dnf -y install python-pip
dnf -y install blas-devel
dnf -y install lapack-devel
dnf -y install gcc-c++
dnf -y groupinstall "Development Tools"
dnf -y install rpm-build rpm-build-libs

# More python:

dnf -y install tkinter python-mtTkinter python3-tkinter
dnf -y install python-tools python3-tools
dnf -y install python-imaging

# Eclipse:

dnf -y install eclipse eclipse-pydev eclipse-pdt eclipse-cdt-llvm \
eclipse-gef eclipse-cdt-sdk eclipse-cdt-parsers eclipse-dltk-sh \
eclipse-manpage eclipse-egit

# Haskell:

dnf -y install haskell-platform

# And, openstackclient with other things:

pip install python-openstackclient
pip install python-novaclient
pip install python-neutronclient
pip install python-cinderclient
pip install python-glanceclient
pip install python-troveclient
pip install python-swiftclient
pip install python-manilaclient
pip install python-designateclient


echo ""

echo "Listo.."
echo ""
echo "POSTINSTALL TERMINADO..."
echo "Revise y reinicie su PC".
echo ""