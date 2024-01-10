# Ares-XU4-Extras

# still working on this, so somethings might still not work due to me forgetting something. will be fixing it

This is a collection of unofficial installation scripts for Ares allowing you to quickly and easily install emulators, ports and libretrocores 
These scripts can be considered experimental at best.

Most of the scripts do work as is.
Im slowly going through and seeing what i can get working on XU4. 
right now i have a bunch of them that install but will not run due to the lack of OpenGL

First you need to add 2 lines into the sources.list
```
sudo nano /etc/apt/sources.list
```

then add these anywhere in the list 
```
deb http://deb.debian.org/debian/ buster main

deb http://deb.debian.org/debian buster-backports main contrib non-free
```
when run sudo apt-get update

after that these scripts will install and work

you might not see some of them due to im on a Windows coomputer and moving it to github. something to do with the spaces. 
i will see if i can somehow use the same thing as my retropie-extras format

**Installation**

The following commands clone the repo to your Raspberry Pi and then run install-scripts.sh to install the scripts in the master branch directly to the proper directories in the RetroPie-Setup/ folder.

```

cd
git clone https://github.com/Exarkuniv/Ares-XU4-Extras
cd Ares-XU4-Extras/
./install-extras.sh

```

The installation script assumes that you are running it on a Raspberry Pi with the RetroPie-Setup/ folder being stored in /home/pi/RetroPie-Setup. If your setup differs, just copy the scripts directly to the folder they need to be in.
