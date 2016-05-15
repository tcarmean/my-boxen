require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::homebrewdir}/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

# now i'm just trying stuff...
# Trying to manually run

#class scapy {
#	homebrew::tap { 'samueljohn/python': }
#	require libdnet
#	require pylibpcap
#	
#	package {
#		'samueljohn/python/scapy':
#			ensure => installed,
#	}
#}

#class libdnet {
#	package {
#		'libdnet':
#			ensure => installed,
#			install_options => '--with-python',
#	}
#}

#class pylibpcap {
#	homebrew::tap { 'tcarmean/pylibpcap': }
#
#	package {
#		'tcarmean/pylibpcap/pylibpcap':
#		ensure => installed,
#	}
#}

node default {
  # core modules, needed for most things
  include dnsmasq
  include git
  include hub
  include nginx

  # fail if FDE is not enabled
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }

  # node versions
  nodejs::version { '0.8': }
  nodejs::version { '0.10': }
  nodejs::version { '0.12': }

  # default ruby versions
  ruby::version { '1.9.3': }
  ruby::version { '2.0.0': }
  ruby::version { '2.1.8': }
  ruby::version { '2.2.4': }

	# pull in custom packages that we added in puppetfile
	include	macvim
	include	iterm2::stable
	include	dropbox
	include	chrome

# Attempt to install vagrant-windows plugin (Note: vagrant-windows is rolled into v1.6+)
#vagrant::plugin { 'vagrant-windows':
#}

  # common, useful packages
  package {
    [
      'ack',
      'findutils',
      'gnu-tar',
	'python',
	'coreutils'
    ]:
  }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }
}
