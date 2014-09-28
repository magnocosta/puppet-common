# -*- mode: ruby -*-
# vi: set ft=ruby :

class common::basic {

     exec { "apt-update-common":
        command => "/usr/bin/apt-get update"
    }

    # Install util packages
    package { ["git-core", "curl", "vim", "libcurl4-openssl-dev"]:
        ensure  => installed,
        require => Exec["apt-update-common"]
    }

    # Create a directory for swap memory
    file { "/var/swap_files":
        ensure => "directory",
        alias  => "create-swap-directory"
    }

    # Create a swap memory
    exec { "create-swap-memory":
        command => "dd if=/dev/zero of=/var/swap_files/swap bs=1M count=1024 && mkswap /var/swap_files/swap && swapon /var/swap_files/swap",
        creates => "/var/swap_files/swap",
        path    => ["/bin", "/sbin"],
        require => File["create-swap-directory"]
    }

    # Create an user for admin system
    user { "admin":
        managehome => true,
        shell      => '/bin/bash',
        ensure     => present,
        gid        => 110,
        groups     => ["admin"]
    }

}
