# Ares-Extras

# still working on this, so somethings might still not work due to me forgetting something. will be fixing it

This is a collection of unofficial installation scripts for Ares allowing you to quickly and easily install emulators, ports and libretrocores 
These scripts can be considered experimental at best.

Most of the scripts do work as is.
Im slowly going through and seeing what i can get working on XU4. 
right now i have a bunch of them that install but will not run due to the lack of OpenGL

First you need to add 2 lines into the sources.list
```
sudo nano/etc/apt/sources.list
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
