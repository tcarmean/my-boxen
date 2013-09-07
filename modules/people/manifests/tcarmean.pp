class people::tcarmean {
    $home       = "/Users/${::boxen_user}"
    $my         = "${home}/my"
    $dotfiles   = "${my}/dotfiles"

    file { $my:
        ensure  => directory
    }

    repository { $dotfiles:
        source  => 'tcarmean/dotfiles',
        require => File[$my]
    }

	file { "${home}/.bash_profile":
		ensure => link,
		target => "${dotfiles}/.bash_profile"
	}

	file { "${home}/.bashrc":
		ensure => link,
		target => "${dotfiles}/.bashrc"
	}
	
	file { "${home}/.vim":
		ensure => link,
		target => "${dotfiles}/.vim"
	}

	file { "${home}/.vimrc":
		ensure => link,
		target => "${dotfiles}/.vim/vimrc"
	}		
}
