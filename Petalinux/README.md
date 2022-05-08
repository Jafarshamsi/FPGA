# Run Petalinux on ARTY-A7-100T
***

## Part 1: Install WSL & Petalinux tools
1. Open Powershell as administartor
2. Install WSL Ubuntu-18.04 LTS
   ```sh
   wsl --install -d Ubuntu-18.04
   ```
   note: you can see the location of WSL in Windows by typing:
   ```sh
   explorer.exe .
   ```


2. Configure WSL
(INSIDE UBUNTU)
sudo ln -s /mnt/e/Projects/sourcefiles ~/src
sudo ln -s /mnt/e/Projects/ARTY_base ~/prj
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install -y gcc git make net-tools libncurses5-dev tftpd zlib1g-dev libssl-dev flex bison libselinux1 gnupg wget diffstat chrpath socat xterm autoconf libtool tar unzip texinfo zlib1g-dev gcc-multilib build-essential libsdl1.2-dev libglib2.0-dev zlib1g:i386 screen pax gzip




3.download petalinux put in [source files (petalinux-v2021.2-final-installer.run)]
https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html

4. Copy the source file 
mkdir petalinux
cp src/petalinux-v2021.2-final-installer.run petalinux

5. run the source file
cd petalinux
./petalinux-v2021.2-final-installer.run

Step 6: Edit some language parameters 
sudo dpkg-reconfigure locales
sudo update-locale LANG=en_US.UTF-8

Step 7: Run the petalinux tools
sudo dpkg-reconfigure dash
source ~/petalinux/settings.sh

Part 2 – Creating and building a petalinux project
Step 1: Create a project directory
cd ~/petalinux
mkdir projects

Step 2: Create the project
cd projects
petalinux-create --type project --template microblaze --name arty_petalinux

Step 3: Perform the project config
cd arty_petalinux
petalinux-config --get-hw-description ~/prj/TOP_ARTY_base_wrapper.xsa

Step 4: Perform the project config
petalinux-config -c rootfs
	Filesystem Packages -> console -> network -> dropbear
	Filesystem Packages -> devel -> Python
	Apps -> gpio demo

Step 5: Build the project
petalinux-build

Step 6: Check it runs on qemu
petalinux-boot --qemu --kernel

root@arty_petalinux:~# python3
>>>> print("Hello World")	


Step 7: USB cofiguration
replace the last line in petalinux\tools\xsct\bin\xsdb with "$RDI_BINROOT"/loader -exec rdi_xsct "${RDI_ARGS[@]}"

(INSIDE POWERSELL)
wsl -l -v
wsl --set-default-version 2
wsl --set-version Ubuntu-18.04 2
usbipd wsl list
Install the latest release of usbipd-win (https://github.com/dorssel/usbipd-win/releases)
usbipd wsl list


(INSIDE UBUNTU)
uname -a (kernel version > 5.10.60.1 otherwise download & update https://lifesaver.codes/answer/how-to-update-the-wsl2-kernel-on-current-windows-10-5650)
sudo apt install linux-tools-5.4.0-77-generic hwdata
sudo update-alternatives --install /usr/local/bin/usbip usbip /usr/lib/linux-tools/5.4.0-77-generic/usbip 20

(INSIDE POWERSELL)
usbipd wsl attach --busid <busid>

download runtime and utilites for linux https://digilent.com/reference/software/adept/start
xar xvzf digilent.adept.runtime_2.26.1-x86_64.tar.gz
xar xvzf digilent.adept.utilities_2.7.1-x86_64.tar.gz
sudo ./digilent.adept.utilities_2.7.1-x86_64/install.sh
sudo mkdir /etc/hotplug
sudo mkdir /etc/hotplug/usb 
sudo mkdir /etc/hotplug/usb/digilentusb
sudo ./digilent.adept.runtime_2.26.1-x86_64/install.sh

git clone git://git.zerfleddert.de/usb-driver
download install_drivers.tar.gz from xilinx.com: https://www.xilinx.com/member/forms/download/design-license.html?cid=103670

Step 8: BOOT
petalinux-boot --jtag --fpga
ERROR

Step 7: BOOT from windows
Make a virtual drive for WSL by going to \\wsl$\ in file explorer, then dragging the folder for your WSL distribution onto "This PC" in the navigation pane. WSL will now be accessible through a drive called Y:/, Z:/, or something similar.




PROGRAM + HELLO WORLD







Part 3 - Gitting involved
Step 1: Build the project again, this time for an sdk.
petalinux-build --sdk

Step 2: Package the sdk
petalinux-package --sysroot

Step 3: Ironing out the OS issues
mkdir sdk
cd sdk
mkdir sysroots
cd sysroots
mkdir usr
mkdir lib

cd ~/petalinux/projects/arty_petalinux

# Remove the current usr and lib directories
sudo -S rm -rf sdk/sysroots/usr
sudo -S rm -rf sdk/sysroots/lib

# Copy the newly generated ones
sudo cp -R -L images/linux/sdk/sysroots/microblazeel-v11.0-bs-cmp-re-mh-div-xilinx-linux/usr sdk/sysroots/
sudo cp -R -L images/linux/sdk/sysroots/microblazeel-v11.0-bs-cmp-re-mh-div-xilinx-linux/lib sdk/sysroots/

# Get a list of the CAPS APPENDED duplicate files and add them to the gitignore
find ./sdk/ | sort -f | tac | uniq -di | cut -c2- >> .gitignore

# Remove duplicate lines and save in .temp
sort .gitignore | uniq > .temp

# Remove gitignore and rename .temp to that
rm .gitignore
mv .temp .gitignore

Step 4: Copy the wrapper to the sdk directory
cp ~/prj/TOP_ARTY_base_wrapper.xsa sdk

Step 5: Actually create yourself a real gitignore
sudo chmod a+w .gitignore
(remove *.o in .gitignore & change /images/linux to /images/linux/sdk/, remove vmlinux, remove rootfs...)

Step 6: Make the git repo
(install git and gitub https://www.windowscentral.com/how-use-github-cli-app-windows-and-wsl)
(git upgrade)
$ sudo add-apt-repository ppa:git-core/ppa
$ sudo apt update
$ sudo apt install git
$ git --version

git config --global user.name "Jafarshamsi"
git config --global user.email "jafarshamsi.e@gmail.com"
git init
git add .gitignore
git commit -m "Added gitignore to start"
(clone from github in windows)
git add -A
git commit -m "Added the project source files"
(clone from github in windows)

Step 7: copy the git to vitis git + generate_project.tcl + launch.bat + output.bif

Step 8: run launch.bat and open vitis platform there!


git remote add name(origin) url(/mnt/c/git)
git remote set-url name(origin) url(/mnt/c/git)
git push --set-upstream origin master
(PWOERSHELL in /mnt/c/git) git init --bare

large files
	curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
	sudo apt-get install git-lfs
	git lfs install
	git lfs track "some-massive-files-name.ext"
git push https://github.com/Jafarshamsi/PETALINUX.git


Part 4 - Setting up the windows project

	
## Reference
	[1] https://yangyt96.github.io/2021/04/14/petalinux-on-windows-10-with-wsl.html
	[2] https://doayee.co.uk/petalinux-on-windows-via-wsl-and-git/
