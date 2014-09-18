# -*- mode: ruby -*-
# vi: set ft=ruby :

class common::basic {

     exec { "apt-update":
        command => "/usr/bin/apt-get update"
    }

    # Create shell for variables and scripts for initializer
    file { "/etc/profile.d/common.sh":
       mode    => 755,
       content => template("common/alias")
    }

    # Install util packages
    package { ["git-core", "curl", "vim", "libcurl4-openssl-dev"]:
        ensure  => installed,
        require => Exec["apt-update"]
    }

    # Install apache server and depences
    package { ["apache2", "apache2-threaded-dev", "libapr1-dev", "libaprutil1-dev"]:
        ensure  => installed,
        require => Exec["apt-update"]
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
        ensure     => present,
        gid        => 110,
        groups     => ["www-data", "admin"],
        require    => Package["apache2"]
    }

}
