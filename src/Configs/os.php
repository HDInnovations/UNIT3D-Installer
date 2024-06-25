<?php

return [

    /*
     * Ubuntu
     */
    'ubuntu' => [
        'pkg_manager' => 'apt-get',
        'web-user' => 'www-data',
        'install_dir' => '/var/www/html',
        'nginx-sites-available_path' => '/etc/nginx/sites-available',

        'software' => [
            'build-essential' => 'Basic C/C++ Development Environment',
            'nginx' => 'Web Server',
            'mysql-server' => 'Database Server',
            'supervisor' => 'A Process Control System',
            'nodejs' => 'JavaScript Run-time Environment (Includes npm)',
            'git' => 'Version Control',
            'tmux' => 'Screen Multiplexer',
            'vim' => 'Text Editor',
            'wget' => 'Transfer Data From A Server',
            'zip' => 'Compress Files',
            'unzip' => 'Decompress Files',
            'htop' => 'Monitor Server Resources',
            'cron' => 'Process Scheduling Daemon',
        ],
    ]


];
