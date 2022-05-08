# Run Petalinux on ARTY-A7-100T (Under development)
***

## Part 1: Create a base project including a Microblaze processor and interfaces for ARTY board

***
## Part 2: Install WSL
**1. Open Windows powershell as administartor**
**2. Install WSL_Ubuntu-18.04_LTS**
   ```sh
   wsl --install -d Ubuntu-18.04
   ```
   QUICK_NOTE: Want to know where WSL_Ubuntu is? Open Ubuntu-18.04 LTS (it is in the windows start menu) and type the following syntax to see the installation folder:
   ```sh
   explorer.exe .
   ```
   QUICK_NOTE: You can access to any folder in Windows from WSL_Ubuntu; type the following syntax to access c:\myfolder ("myfloder" in drive c)
   ```sh
   cd /mnt/c/myfolder
   ```
**3. Install required packages**
* Add 32-bit apps to apt-get and update apt-get
   ```sh
   sudo dpkg --add-architecture i386
   sudo apt-get update
   ```
* Install dependencies
   ```sh
   sudo apt-get install -y gcc git make net-tools libncurses5-dev tftpd zlib1g-dev libssl-dev flex bison libselinux1 gnupg wget diffstat chrpath socat xterm autoconf libtool tar unzip texinfo zlib1g-dev gcc-multilib build-essential libsdl1.2-dev libglib2.0-dev zlib1g:i386 screen pax gzip
   ```
***
## Part 3: Install Petalinux tools & apply some configurations
**1. download petalinux-v2021.2 ("petalinux-v2021.2-final-installer.run")**
[source files (petalinux-v2021.2-final-installer.run)]
https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html

**2. Create folder "petalinux" in WSL_Ubuntu and copy the file "petalinux-v2021.2-final-installer.run" from Windows to a folder in WSL_Ubuntu**
   ```sh
   mkdir petalinux
   cp /mnt/[YOUR DOWNLOAD FOLDER]/petalinux-v2021.2-final-installer.run petalinux
   ```
**3. run the source file "petalinux-v2021.2-final-installer.run"**
  ```sh
  cd petalinux
  ./petalinux-v2021.2-final-installer.run
  ```
**4. Edit some language parameters**
  ```sh
  sudo dpkg-reconfigure locales 
  sudo update-locale LANG=en_US.UTF-8
  ```
**5. On Ubuntu, /bin/sh is a symbolic link to dash. You need to make it a symbolic link to bash instead. Run the following syntax and answer “no”**
  ```sh
  sudo dpkg-reconfigure dash
  ```
**6. Run the petalinux tools (don’t worry about the tftp warrning!)**
  ```sh
  source ~/petalinux/settings.sh
  ```
  QUICK_NOTE: You can check to see if it is running. Using the following syntax you will receive the petalinux locaton
  ```sh
  echo $PETALINUX
  ```
  
***
## Part 4:  Creating and building a petalinux project
**1. Create a project**
  ```sh
  cd ~/petalinux
  mkdir petalinux_project
  cd petalinux_project
  petalinux-create --type project --template microblaze --name PETALINUX_ARTY
  ```

**2. Perform the project config (let's call it Hardware Config) and exit!**
  ```sh
  cd PETALINUX_ARTY
  petalinux-config --get-hw-description /mnt/[PATH-TO-VIVADO-PROJECT]/TOP_ARTY_base_wrapper.xsa
  ```
**3. Perform the project config (let's call it Linux Config) and config as follow**
  ```sh
  petalinux-config -c rootfs
  Filesystem Packages -> console -> network -> dropbear
  Filesystem Packages -> devel -> Python
  Apps -> gpio demo
  ```
**4. Build the project**
  ```sh
  petalinux-build
  ```
**5. Check it runs on qemu emulator**
  ```sh
  petalinux-boot --qemu --kernel
  ...
  root@arty_petalinux:~# python3
  >>>> print("Hello World")	
  ```

***
## Part 5:  Create tcl file and program the FPGA from Windows
**1. Make a virtual drive for WSL_Ubunto to be able to access it from Windows**
* Go to \\wsl$\ in file explorer, then dragging the folder onto "This PC" in the navigation pane. WSL will now be accessible through a drive called Y:/, Z:/, or something similar.

**2. Create a tcl file**
  * Go back to WSL environment and create a TCL file
  ```sh
  petalinux-boot --jtag --fpga --kernel --tcl FPGA.tcl
  ```
**3. Modify the tcl file**
* copy FPGA.tcl from WSL_Ubunto to a folder in Windows
* open it using a text editor (e.g. notpad++) 
* add your_WSL_drive_letter:/ to the beginning of each path inside the tcl
**4. Run tcl file using a bat file**
* Create a text file beside the tcl file using a text editor and write the following command
  ```sh
  C:\[Path_To_Xilinx_Installation_Folder]\Vitis\2021.2\bin\xsct.bat program.tcl
  ```
* save it as a bat file (e.g. Prog.bat)

**5. Connect the FPGA board (ARTY board) and program it by running the bat file (Prog.bat)**

**6. Open putty or mobaXterm or any similar application and connect to the FPGA board through Serial Port**

**7. After booting, test it using **
   ```sh
   root@arty_petalinux:~# python3
   >>>> print("Hello World")
  ```

***
## Reference
	[1] https://yangyt96.github.io/2021/04/14/petalinux-on-windows-10-with-wsl.html
	[2] https://doayee.co.uk/petalinux-on-windows-via-wsl-and-git/
	[3] https://www.hackster.io/whitney-knitter/installing-vivado-vitis-petalinux-2021-2-on-ubuntu-18-04-0d0fdf
	
