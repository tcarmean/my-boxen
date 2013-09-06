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
}
