my_boxen
========

My hacks on top of boxen. Use this at your own risk.

This repo will initially be a collection of notes and links to wrap my head around setting up boxen. My apologies if this all looks incomprehensible.

__TODO List__

1. Figure out how to replace the OS X stock equivalent of coreutils with the GNU variants (OS X shouldn't hide symlinks from the user). As a linux user, the default command line tools are lacking to say the least.
2. Fork /opt/boxen/repo into my_boxen (this will likely cause script/boxen to complain about uncommited changes) - DONE but to my-boxen which is where you're reading this...

__Setup Steps__

1. https://github.com/boxen/our-boxen
2. This link seems to explain things a bit better: http://coffeecupblog.com/2013/03/24/automate-your-mac-provisioning-with-boxen-first-steps/

```
git clone https://github.com/boxen/our-boxen /opt/boxen/repo
cd /opt/boxen/repo
git remote rm origin
git remote add origin git@github.com:tcarmean/my-boxen.git 
git push -u origin master
script/boxen --no-fde
```
This seems to pull in a bunch of stuff and sets up ~/src/our-boxen which appears to be where custom configurations on top of the defaults are meant to go. It appears that ~/src/our-boxen is a symlink to /opt/boxen/repo. 

```
dhcp84:our-boxen chong$ pwd
/Users/chong/src/our-boxen
dhcp84:our-boxen chong$ ls
Gemfile         Puppetfile      bin             lib             modules         vendor
Gemfile.lock    Puppetfile.lock config          log             script
LICENSE         README.md       docs            manifests       shared
```


