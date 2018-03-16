#checking pupdemo
package { "nginx":
    ensure => installed,
}

service { "nginx":
    require => Package["nginx"],
    ensure => running,
    enable => true,
}

# -------------------------------------------

# Java installed
package { "default-jre":
    ensure => installed,
}

# JAVA_HOME set (next session)
file_line { 'set_java_home': # Requires puppetlabs-stdlib
    path => '/etc/environment',
    line => 'JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"',
}

exec { "source_environment":
    command => "/bin/bash -c 'source /etc/environment'",
}

# TC Server installed and user/group added
group { 'pivotal':
    ensure => 'present',
}

user { 'tcserver':
    ensure => 'present',
    require     => [ Group['pivotal'], ],
}

file { '/opt/pivotal':
    ensure    => directory,
    owner     => 'tcserver',
    group      => 'pivotal',
    require     => [ User['tcserver'], Group['pivotal'], ],
    recurse    => true,
}

archive { '/opt/pivotal/pivotal-tc-server-standard-3.2.8.RELEASE.tar.gz':
    source => '/vagrant/pivotal-tc-server-standard-3.2.8.RELEASE.tar.gz',
    extract       => true,
    extract_path  => '/opt/pivotal',
    user          => 'tcserver',
    group         => 'pivotal',
}

# TC Server instance created and started 

exec { 'create_instance':
    environment => ["JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64"],
    command => "/opt/pivotal/pivotal-tc-server-standard-3.2.8.RELEASE/tcruntime-instance.sh create --force --instance-directory /opt/pivotal --java-home /usr/lib/jvm/java-8-openjdk-amd64 myserver",
#    require => [ Archive['/opt/pivotal/pivotal-tc-server-standard-3.2.8.RELEASE.tar'], ],
}

exec { 'start_instance':
    command => '/opt/pivotal/pivotal-tc-server-standard-3.2.8.RELEASE/tcruntime-ctl.sh myserver start -i /opt/pivotal',
#    require => [ Exec['create_instance'], ],
}

# Sample application deployed







# ------------------------------------------


    # Install Java
#     sudo apt-get update -y
#     sudo apt-get install default-jre -y
#     java -version

    # Set JAVA_HOME
#     sudo /bin/sh -c 'echo "JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"" >> /etc/environment'
#     source /etc/environment

    # Install TC Server
#     sudo groupadd pivotal
#     sudo useradd tcserver -g pivotal
#     sudo mkdir -p /opt/pivotal
#     sudo tar -xf /vagrant/pivotal-tc-server-standard-3.2.8.RELEASE.tar --directory /opt/pivotal
    
    # Create and start TC Server instance
#     sudo /opt/pivotal/pivotal-tc-server-standard-3.2.8.RELEASE/tcruntime-instance.sh create --instance-directory /opt/pivotal myserver
#     sudo /opt/pivotal/pivotal-tc-server-standard-3.2.8.RELEASE/tcruntime-ctl.sh myserver start -i /opt/pivotal
#     sudo chown -R tcserver:pivotal /opt/pivotal

    # Deploy a sample application
#     sudo cp /vagrant/sample.war /opt/pivotal/myserver/webapps
 
