class { '::mysql::server':
  root_password           => '123',
  remove_default_accounts => true,
  override_options        => {
    'mysqld' => {
      'server-id' => 1,
      'log_bin' => '/var/log/mysql/mysql-bin.log',
      'binlog_do_db' => 'mydb',
      'bind-address' => '0.0.0.0',
    }
  },
  databases => {
    'mydb' => {
      charset  => 'utf8',
      collate  => 'utf8_swedish_ci',
    }
  },
  users => {
    'myuser@%' => {
      ensure                   => 'present',
      max_connections_per_hour => '0',
      max_queries_per_hour     => '0',
      max_updates_per_hour     => '0',
      max_user_connections     => '0',
      password_hash            => '*23AE809DDACAF96AF0FD78ED04B6A265E05AA257', # PASSWORD('123')
    },
    'slave_user@%' => {
      ensure                   => 'present',
      max_connections_per_hour => '0',
      max_queries_per_hour     => '0',
      max_updates_per_hour     => '0',
      max_user_connections     => '0',
      password_hash            => '*23AE809DDACAF96AF0FD78ED04B6A265E05AA257', # PASSWORD('123')
    },
  },
  grants => {
    'myuser@%/mydb.*' => {
      ensure     => 'present',
      options    => ['GRANT'],
      privileges => ['ALL'],
      table      => 'mydb.*',
      user       => 'myuser@%',
    },
    'slave_user@%/*.*' => {
      ensure     => 'present',
      options    => ['GRANT'],
      privileges => ['REPLICATION SLAVE'],
      table      => '*.*',
      user       => 'slave_user@%',
    },
  }
}

class { 'firewall': }

firewall { '100 allow mysql access':
  port   => [3306],
  proto  => tcp,
  action => accept,
}
