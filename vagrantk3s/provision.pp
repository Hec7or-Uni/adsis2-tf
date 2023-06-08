class provision {
  $hostname = $facts['hostname']
  $nodeip   = $facts['node_ip']
  $masterip = $facts['master_ip']
  $nodetype = $facts['type']

  # Configura la zona horaria
  class { 'timezone':
    timezone => 'Europe/Madrid',
  }

  # Configura el archivo de hosts
  file { '/etc/hosts':
    ensure  => file,
    content => "# This file is managed by Puppet\n
                 192.168.1.70 m\n
                 192.168.1.71 w1\n
                 192.168.1.72 w2\n
                 192.168.1.73 w3\n",
  }

  # Copia el archivo "k3s" a /usr/local/bin/
  file { '/usr/local/bin/k3s':
    source => '/vagrant/k3s',
    mode   => '0755',
  }

  # Comprueba el tipo de nodo y realiza la instalación correspondiente
  if $nodetype == 'master' {
    # Instalación del nodo maestro
    exec { 'install_k3s_master':
      command => "/bin/bash /vagrant/install.sh server \
                  --token 'wCdC16AlP8qpqqI53DM6ujtrfZ7qsEM7PHLxD+Sw+RNK2d1oDJQQOsBkIwy5OZ/5' \
                  --flannel-iface enp0s8 \
                  --bind-address $nodeip \
                  --node-ip $nodeip --node-name $hostname \
                  --disable traefik \
                  --node-taint k3s-controlplane=true:NoExecute",
      require => File['/usr/local/bin/k3s'],
    }

    # Copia el archivo de configuración k3s.yaml al directorio /vagrant
    file { '/vagrant/k3s.yaml':
      ensure  => present,
      source  => '/etc/rancher/k3s/k3s.yaml',
      require => Exec['install_k3s_master'],
    }
  } else {
    # Instalación del nodo agente
    exec { 'install_k3s_agent':
      command => "/bin/bash /vagrant/install.sh agent \
                  --server https://$masterip:6443 \
                  --token 'wCdC16AlP8qpqqI53DM6ujtrfZ7qsEM7PHLxD+Sw+RNK2d1oDJQQOsBkIwy5OZ/5' \
                  --node-ip $nodeip --node-name $hostname --flannel-iface enp0s8",
      require => File['/usr/local/bin/k3s'],
    }
  }
}

include provision
