my_boxen
========

My hacks on top of boxen. Use this at your own risk.

This repo will initially be a collection of notes and links to wrap my head around setting up boxen. My apologies if this all looks incomprehensible.

__TODO List__

1. Figure out how to replace the OS X stock equivalent of coreutils with the GNU variants (OS X shouldn't hide symlinks from the user). As a linux user, the default command line tools are lacking to say the least. - DONE (see below)
2. Fork /opt/boxen/repo into my-boxen (this will likely cause script/boxen to complain about uncommited changes) - DONE
3. Automate/write a boxen recipe that uses puppet to call homebrew to install python - looks like you can do something in the manifests/site.pp file here.
4. Automate/write a boxen recipe that uses puppet to call homebrew to install scapy
5. Automate/write a boxen recipe that uses puppet to call homebrew to install the GNU utils
6. Create a dotfiles repo on github. Create per user manifest for github id tcarmean that points to tcarmean/dotfiles. See modules/people/README.md for info on how to do this.
__Setup Steps__

1. Install xcode command line utils and ACCEPT THE LICENSE!!!
```
xcodebuild -license
```
2. https://github.com/boxen/our-boxen
3. This link seems to explain things a bit better: http://coffeecupblog.com/2013/03/24/automate-your-mac-provisioning-with-boxen-first-steps/
4. This link also has good information: http://garylarizza.com/blog/2013/02/15/puppet-plus-github-equals-laptop-love/

```
git clone https://github.com/boxen/our-boxen /opt/boxen/repo
cd /opt/boxen/repo
git remote rm origin
git remote add origin git@github.com:tcarmean/my-boxen.git 
git push -u origin master
script/boxen --no-fde
```
__TODO__ Figure out the order of operations and modify the steps above for staging a new machine from scratch. Do we clone from boxen/our-boxen or from tcarmean/my-boxen???
```
dhcp84:our-boxen chong$ pwd
/Users/chong/src/our-boxen
dhcp84:our-boxen chong$ ls
Gemfile         Puppetfile      bin             lib             modules         vendor
Gemfile.lock    Puppetfile.lock config          log             script
LICENSE         README.md       docs            manifests       shared
```

At this point you can edit Puppetfile to add things you might like:

```
# Optional/custom modules. There are tons available at
# https://github.com/boxen.
github "python",        "1.2.1"
```

It is worth noting that once you add things to the Puppetfile you also need to add them to manifests/site.pp. The code to do so looks like this:

```
node default {
 --- SNIP ---
	# pull in custom packages that we added in puppetfile
	include	macvim
	include	alfred
	include	virtualbox
	include	iterm2
	include	dropbox
	include	chrome
	include python
 --- SNIP ---
  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }
}
``` 

To get scapy:

```
brew tap samueljohn/python
brew install scapy
```

This gets me a broken environment. Apparently homebrew didn't install all of the deps for scapy (this is a bit weird as it DID get me something usable outside of boxen).

__TODO__ Reinvestigate setting up a proper GNU environment.

To get the GNU set of tools in hopes that the command line will become a bit more like I'm used to from linux:

```
brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt
```
